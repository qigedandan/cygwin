#include "OSARF.h"

module OSARFP
{
    provides  interface OSARF;
    provides  interface StdControl as OSARFControl;
    provides  interface Init;
    
    uses interface GpioInterrupt as InterruptTXDone;
    uses interface GpioInterrupt as InterruptFIFOP;
    uses interface GpioInterrupt as InterruptRFErr;
    uses interface Leds;
}
implementation
{


#define SFD_TIMER_WAIT_FIFOP    3000

#define debug_fsm(x) //call StdOut.print("FSM: "); call StdOut.printHexword(call HPLCC2420.read(CC_REG_FSMSTATE)); call StdOut.print("\r\n");

norace uint8_t volatile RFIF  __attribute((sfrAT0xE9)); /*  RF Interrupt Flags          */

  void CC2430SetPanid(uint16_t id);
  void CC2430SetShortaddr(uint16_t shortAddr);
  void CC2420SetIEEEAddr(ieee_mac_addr_t extAddress);
  void CC2430Reset();
  void CC2430RFEnable();
  void CC2430RFDisable();
  void CC2430ExternalOscillator();
  void CC2430RxEnable();
  void CC2430RxDisable();
  void CC2430ChannelSet(uint8_t channel);
  void CC2430PALevelSet(uint8_t new_power);
  void CC2430ControlSet();
  void CC2430TxWait();
  void wait(uint16_t u);


  task void initTask();
  task void transmitTask();
  task void setChannelTask();


/*************************************************************************************************
*** StdControl
**************************************************************************************************/
    // uint16_t mcr0 = 0x0AE2, iocfg0 = 0x007F;
    uint16_t mcr0 = 0x0000, iocfg0 = 0x007F;
    MDMCTRL0_t * mcr0Ptr;

    ieee_mac_addr_t ieeeAddress;
    mac_addr_t shortAddress, panid;

    bool rxEnabled = FALSE;

    uint8_t receivedPacket[128];
    uint8_t * receivedPacketPtr;
    //uint8_t packet_buf_real[PACKET_MAX_PAYLOAD];

    /**********************************************************************
     * Init
     *********************************************************************/
    command error_t Init.init() 
    {
        ADBG(1, "OSARFP.Init.init\n");
        receivedPacketPtr = receivedPacket;

        post initTask();
        
        return SUCCESS;
    }

    task void initTask()
    {
        /* Power cycle radio*/
        CC2430Reset();
        
        /* turn on oscillator, enabling RAM access */
        CC2430ExternalOscillator();

        /******************************************
        ** Register related                      **
        ******************************************/
        /* Set control registers */
        CC2430ControlSet();

        /* Set channel */
        CC2430ChannelSet(11);
        
        CC2430PALevelSet(100);

        //_CC2430_MDMCTRL0 = 0x2AF2;
        _CC2430_MDMCTRL0 = 0x2AEF;

	call InterruptTXDone.enableRisingEdge();
	call InterruptRFErr.enableRisingEdge();
    }

    /**********************************************************************
    * Start
    *********************************************************************/
    command error_t OSARFControl.start()
    {       
      /* Turn radio on */
      CC2430RFEnable();

      /* Enable receiver */
      CC2430RxEnable();


      ADBG(1, "OSARFControl.start _CC2430_MDMCTRL0= %x\n", _CC2430_MDMCTRL0);

      return SUCCESS;
    }
       
  /**********************************************************************
   * Stop
   *********************************************************************/
  command error_t OSARFControl.stop()
  {
    /* Wait if radio is transmitting */
    CC2430TxWait();
    CC2430RFDisable();
    
    return SUCCESS;
  }
    

/*************************************************************************************************
*** Transmit/receive related
**************************************************************************************************/
    /**********************************************************************
    * sendPacket
    *********************************************************************/
    uint8_t * transmitPacketPtr;
    bool transmitInProgress = FALSE;

    command error_t OSARF.sendPacket(uint8_t * packet) 
    {
        
        transmitPacketPtr = packet;        

        post transmitTask();
    
        return SUCCESS;
    }

    task void transmitTask()
    {
        bool oldRxEnabled;
        uint8_t i, status, counter;
        uint8_t data_length;

        /***********************************************
        * Check if channel is clear - If radio is not in 
        * receive mode, turn on receiver to gather RSSI
        ***********************************************/
        oldRxEnabled = rxEnabled;
        if (!rxEnabled)
        {
            /* turn on receiver */
            CC2430RxEnable();
        }

        /* check if channel is busy */
        if ( !(_CC2430_RFSTATUS & _BV(CC2430_RFSTATUS_CCA)) ) {

            /* restore previous state before returning call */
            if (!rxEnabled)
            {
                /* turn off receiver */
                CC2430RxDisable();
            }

            signal OSARF.sendPacketDone(transmitPacketPtr, CC2420_ERROR_CCA);


            return;
        }


        /***********************************************
        ** Clear to send packet
        ***********************************************/

        /* put packet in transmit buffer */
        RFST = _CC2430_ISFLUSHTX;

        /* Even 0x7F is a valid length */
        data_length = transmitPacketPtr[0];
        RFD = data_length;


        ADBG(1, "\r\nRADIO send:%02x ", ADBG_N(u8(transmitPacketPtr, 0)));

        for (i = 0; i < data_length; i++) {
            RFD = transmitPacketPtr[i+1];  
	     ADBG(1, "%02x ", ADBG_N(u8(transmitPacketPtr, i+1)));
        }


        /* Wait for it to send the packet */
        i = 0;
        while (i++ < 3) 
        {
            RFST = _CC2430_ISTXON;
            counter = 0;

            do {
                status = _CC2430_RFSTATUS;
            }while ( !(status & _BV(CC2430_RFSTATUS_TX_ACTIVE))  && (counter++ < 200));

            if (status & _BV(CC2430_RFSTATUS_TX_ACTIVE)) 
                break;
        }

        /***********************************************
        ** Check if packet is being transmitted
        ***********************************************/    
        if (!(status & _BV(CC2430_RFSTATUS_TX_ACTIVE))) {

            /* flush transmit buffer */
            RFST = _CC2430_ISFLUSHTX;

            signal OSARF.sendPacketDone(transmitPacketPtr, CC2420_ERROR_TX);


            return;
        }


        atomic transmitInProgress = TRUE;
    
        ADBG(1, "sending now\n ");
        return;
    }

    command bool OSARF.getCCA()
    {      /* Turn radio on */
    	return (_CC2430_RFSTATUS & _BV(CC2430_RFSTATUS_CCA));
    }
    /**********************************************************************
    * setChannel
    *********************************************************************/
    uint8_t currentChannel;
    
    command error_t OSARF.setChannel(uint8_t channel) 
    {
        if ( (channel < 11) || (channel > 26) ) 
            return FAIL;
        else {
            currentChannel = channel;
            post setChannelTask();
        }

        return SUCCESS;
    }
    
    task void setChannelTask()
    {
    	CC2430ChannelSet(currentChannel);             
    }
    
    /**********************************************************************
    * setTransmitPower
    *********************************************************************/
    command error_t OSARF.setTransmitPower(uint8_t power)
    {
        if (power > 100) 
            return FAIL;
        else 
            CC2430PALevelSet(power);
            
        return SUCCESS;
    }
    

    /**********************************************************************
    * rxEnable
    *********************************************************************/
    command error_t OSARF.rxEnable()
    {
        /* turn on receiver */
        CC2430RxEnable();
        
        return SUCCESS;
    }
    
    /**********************************************************************
    * rxDisable
    *********************************************************************/
    command error_t OSARF.rxDisable()
    {
        /* ignore call if radio is already off */
        if (rxEnabled) 
        {
            CC2430RxDisable();
        }
        
        return SUCCESS;
    }

/*************************************************************************************************
*** Adressing
**************************************************************************************************/

    /**********************************************************************
     * setShortAddress
     *********************************************************************/
    command error_t OSARF.setAddress(mac_addr_t *addr)
    {
        shortAddress = *addr;
        _CC2430_SHORTADDR = (*addr);

        return SUCCESS;
    }

    /**********************************************************************
     * getShortAddress
     *********************************************************************/
    command const mac_addr_t * OSARF.getAddress()
    {
        return &shortAddress;
    }
    
    /**********************************************************************
     * setPANAddress
     *********************************************************************/
    command error_t OSARF.setPanAddress(mac_addr_t *addr)
    {
        panid = *addr;
        _CC2430_PANID = panid;

        return SUCCESS;
    }
    
    /**********************************************************************
     * getShortAddress
     *********************************************************************/
    command const mac_addr_t * OSARF.getPanAddress()
    {
        return &panid;
    }
    
    /**********************************************************************
     * getExtAddress
     *********************************************************************/
    command const ieee_mac_addr_t * OSARF.getExtAddress()
    {
        return (const ieee_mac_addr_t *) &ieeeAddress;
    }

    /**********************************************************************
     * Hardware Address Filtering
     *********************************************************************/
    command error_t OSARF.addressFilterEnable()
    {
        _CC2430_MDMCTRL0H |= _BV(CC2430_MDMCTRL0H_ADDR_DECODE);
        
        return SUCCESS;
    }
    
    command error_t OSARF.addressFilterDisable()
    {
        _CC2430_MDMCTRL0H &= ~_BV(CC2430_MDMCTRL0H_ADDR_DECODE);

        return SUCCESS;
    }

    void CC2430SetPanid(uint16_t id)
    {
        _CC2430_PANID = id;
    }

    void CC2430SetShortaddr(uint16_t shortAddr)
    {
        _CC2430_SHORTADDR = shortAddr;
    }

    void CC2420SetIEEEAddr(ieee_mac_addr_t extAddress)
    {
        _CC2430_IEEE_ADDR7 = extAddress[7];
        _CC2430_IEEE_ADDR6 = extAddress[6];
        _CC2430_IEEE_ADDR5 = extAddress[5];
        _CC2430_IEEE_ADDR4 = extAddress[4];
        _CC2430_IEEE_ADDR3 = extAddress[3];
        _CC2430_IEEE_ADDR2 = extAddress[2];
        _CC2430_IEEE_ADDR1 = extAddress[1];
        _CC2430_IEEE_ADDR0 = extAddress[0];
    }



/*************************************************************************************************
*** Interrupt handler
**************************************************************************************************/

    task void receivedPacketTask();
    task void flushBufferTask();
    task void sendPacketDoneTask();
    bool receivedPacketTaskPosted = FALSE, flushBufferTaskPosted = FALSE; 


    

    /**************************************************************************
    * TXDone fired
    **************************************************************************/
    async event void InterruptTXDone.fired()
    {
      ADBG(1, "InterruptTXDone.fired\n");
      if (transmitInProgress) {
        transmitInProgress = FALSE;
        post sendPacketDoneTask();
      } else {
        ADBG(1, "MAC: Unscheduled transmit\n");
      }

      
    }

    task void sendPacketDoneTask() {
        signal OSARF.sendPacketDone(transmitPacketPtr, SUCCESS);
        
    }


    /**************************************************************************
    * FIFOP fired
    **************************************************************************/
    async event void InterruptFIFOP.fired() {

        // Packet reception completed and address completed
        // Number of packets in fifo can be found in RXFIFOCNT

        ADBG(2, "InterruptFIFOP.fired\n");
        
        if (!receivedPacketTaskPosted && (_CC2430_RXFIFOCNT > 0) ) {


          receivedPacketTaskPosted = TRUE;
          post receivedPacketTask();

        } 

    }

    uint8_t frameLength = 0, receivedPacketTaskRetries = 0;
  
    task void receivedPacketTask()
    {
        uint8_t correlation, i, tmp8;

        receivedPacketPtr = receivedPacket;


        /* read frame length if not done so already */
        if (frameLength == 0) 
        {
            frameLength = RFD;
            
            if (frameLength < 127)
                receivedPacketPtr[0] = frameLength;
            else {

                /* error - frame too big - flush buffer*/
                post flushBufferTask();
                atomic receivedPacketTaskPosted = FALSE;
                frameLength = 0;
                receivedPacketTaskRetries = 0;
                
                return;
            }
        }

        /* check if entire frame has been received */
        if (frameLength > _CC2430_RXFIFOCNT)
        {
            /* frame not complete */
            /* repost task if buffer is not overrun */
            /* or if this is not the 10th try       */
            atomic {
                if (flushBufferTaskPosted || receivedPacketTaskRetries > 10) 
                {
                    post flushBufferTask();
                    receivedPacketTaskPosted = FALSE;
                    frameLength = 0;
                    receivedPacketTaskRetries = 0;
                } else {
                    post receivedPacketTask();
                    receivedPacketTaskRetries++;
                }
            }

            return;
        }

        /* reset retry counter */
        receivedPacketTaskRetries = 0;
            
        /* read frame from receive buffer */
        for (i = 0; i < frameLength; i++) {
            if ( (_CC2430_RXFIFOCNT > 0) && (_CC2430_RXFIFOCNT < 129) )        
            {
                tmp8 = RFD;
                //receivedPacketPtr[i+1] = tmp8;
                u8(receivedPacketPtr, i+1) = tmp8;
            }
            else {
                receivedPacketPtr[frameLength] = 0;
                break;
            }
        }

        /* read CORRELATION */
        correlation = receivedPacketPtr[frameLength];

        ADBG(1, "RADIO received: len=%d DATA:", ADBG_N(frameLength));
		for (i=0; i < frameLength+1; i++)
		{
		   ADBG(1, "%02x ", ADBG_N(u8(receivedPacketPtr, i)));
		}

		ADBG(1, "\r\n");


        /* reset frameLength so next frame is read from the top */
        frameLength = 0;
                
        /***********************************************
        ** Process this frame
        ***********************************************/

        /* only signal packet if not corrupt */        
        if (correlation & FCS_CRC_OK_MASK) 
        {
            #ifndef EM_RADIO_NOT_LED
           // LED_TOGGLE(1);
           call Leds.BlueLedToggle();
            #endif
            receivedPacketPtr = signal OSARF.receivedPacket(receivedPacketPtr);
        } else {

            ADBG(1, "MAC: CRC Failed\n\r");

            /* corrupt packet might indicate misaligned frame */        
            atomic receivedPacketTaskPosted = FALSE;
            post flushBufferTask();
        }

        /***********************************************
        ** Check if other frames are available
        ***********************************************/
        atomic {
        
            /* if there are more bytes in rxfifo then get them */
            if ( (_CC2430_RXFIFOCNT > 0) && (_CC2430_RXFIFOCNT < 129) ) 
                post receivedPacketTask();
            else 
            {
                receivedPacketTaskPosted = FALSE;

                /* check if buffer has overrun while processing frame   */
                /* and post flushBufferTask if it has           */
                if (flushBufferTaskPosted)
                {
                    post flushBufferTask();
                }
            }
        }

        /* buggy hardware - enable interrupt when frame has been read */
        RFIF &= ~_BV(CC2430_RFIF_FIFOP);

    }
  
    /**************************************************************************
    * RFErr fired
    **************************************************************************/
    async event void InterruptRFErr.fired()
    {
        ADBG(1, "MAC: Buffer overrun\r\n");

        /* buffer overrun detected      *
         * if no receivedPacketTask is posted,  *
         * then flush buffer            *
         * else flag buffer to be flushed   */   
        if (!receivedPacketTaskPosted && !flushBufferTaskPosted)
        {
           post flushBufferTask();
        }

        flushBufferTaskPosted = TRUE;
    }
  

    task void flushBufferTask() 
    {
        if (rxEnabled) 
        {
            /* turn off receiver */
            CC2430RxDisable();

            /* flush buffer - done when enabling/disabling receiver */
            RFST = _CC2430_ISFLUSHRX;
            RFST = _CC2430_ISFLUSHRX;

            /* enable receiver */
            CC2430RxEnable();
        } else
        {
          /* flush buffer */
          RFST = _CC2430_ISFLUSHRX;
          RFST = _CC2430_ISFLUSHRX;
        }

        atomic flushBufferTaskPosted = FALSE;

        ADBG(11, "MAC: Buffer flushed\r\n");
    }


/*************************************************************************************************
*** Internal utility functions
**************************************************************************************************/
    /**********************************************************************
    **
    ** Internal CC2420 utility functions
    **
    **********************************************************************/

    /********************
    ********************/
    void CC2430Reset()
    {
      // Power cycle voltage regulator
      _CC2430_RFPWR |= _BV(CC2430_RFPWR_RREG_RADIO_PD); 
      _CC2430_RFPWR &= ~_BV(CC2430_RFPWR_RREG_RADIO_PD);

      // RFPWR contains the register ADI_RADIO_PD as a delayed version
      // The manual however waits for the IF
      while ( !(RFIF & _BV(CC2430_RFIF_RREG_ON)) ) {
      }
    }

    /********************
    ** Enable radio and wait for boot up
    ********************/
    void CC2430RFEnable()
        {
      // Set delay an power up radio
      _CC2430_RFPWR = 0x04; // Power up radio and set delay

      // Wait for radio to power up.
      // Wait by delay time in RFPWR_RREG_DELAY
      // One or the other should be good enough..
      while((_CC2430_RFPWR & 0x10)){}
    }

    /********************
    ********************/
    void CC2430RFDisable()
        {
      _CC2430_RFPWR |= _BV(CC2430_RFPWR_RREG_RADIO_PD);
    }


    /********************
    ********************/
    void CC2430InternalRCOscillator()
    {
        CLKCON |= _BV(CC2430_CLKCON_CLKSPD); // Select clock source = int. RC osc
        SLEEP  |= _BV(CC2430_SLEEP_OSC_PD); // Power down external osc
        // Wait for RC osc stable
        while (!(SLEEP & _BV(CC2430_SLEEP_HFRC_STB))); 
    }

    
    /********************
    ** Switch clock source to high-power, high-precision crystal 
    ** and wait for it to stable 
    *********************/
    void CC2430ExternalOscillator()
    {
      SLEEP  &= ~_BV(CC2430_SLEEP_OSC_PD); // Power up external osc
      CLKCON &= ~_BV(CC2430_CLKCON_CLKSPD); // Select clock source  = ext osc
      // Wait for XOSC powered up and stable
      while (!(SLEEP & _BV(CC2430_SLEEP_XOSC_STB)));
    }

    /********************
    **
    ********************/
    void CC2430RxEnable()
    {
      /* flush rx buffer */
      RFST = _CC2430_ISFLUSHRX;
      RFST = _CC2430_ISFLUSHRX;

      /* enable interrupts */
      call InterruptFIFOP.enableRisingEdge();

      /* Enable receiver */
      RFST = _CC2430_ISRXON;
      
      rxEnabled = TRUE;
    }

    /********************
    **
    ********************/
    void CC2430RxDisable()
    {
      RFST = _CC2430_ISRFOFF;

      /* disable interrupts */
      call InterruptFIFOP.disable();

      rxEnabled = FALSE;
    }

    /********************
    **
    ********************/
    void CC2430ChannelSet(uint8_t channel)
    {
        uint16_t freq;
        
        /* Channel values: 11-26 */
        freq = (uint16_t) channel - 11;
        freq *= 5;  /* channel spacing */
        freq += 357;    /* correct channel range */
        freq |= 0x4000; /* LOCK_THR = 1 */

        _CC2430_FSCTRL = freq;

    }

    /********************
    **
    ********************/
    void CC2430PALevelSet(uint8_t new_power)
    {
        uint16_t power;
        
        power = new_power * 0x1F; // 0x1F ~ 100% power level
        power /= 100;

        _CC2430_TXCTRL = (_CC2430_TXCTRL & ~0x1F) | (power & 0x1F);
    }

    /***********************************************
    ** Set the correlation threshold = 20          
    ** Turn off "Security enable"
    ** Set the FIFOP threshold to maximum
    ***********************************************/
    void CC2430ControlSet()
    {
        /* disable address recognition */
        _CC2430_MDMCTRL0H &= ~_BV(CC2430_MDMCTRL0H_ADDR_DECODE);
//        _CC2430_MDMCTRL0H |= _BV(CC2430_MDMCTRL0H_ADDR_DECODE);
        
        /* enable auto-crc */
        _CC2430_MDMCTRL0L |= _BV(CC2430_MDMCTRL0L_AUTOCRC);

//        _CC2430_MDMCTRL0 = mcr0; 


        /* set FIFOP threshold to 0x7F */
        _CC2430_IOCFG0  = 0x7F;

        /* */
        _CC2430_TXCTRL = 0x050F;
        
        return;
    }

    /***********************************************
    ** Wait while radio is transmitting
    ***********************************************/
    void CC2430TxWait()
    {
        uint16_t i = 0;

        while ( (_CC2430_RFSTATUS & _BV(CC2430_RFSTATUS_TX_ACTIVE) ) && (i < 250) ) 
        {
            wait(100);
            i++;
        } 
        
        return;
    }

    /**********************************************************************
    * wait
    * Guess: loop size is perhaps 10 cycles including load/store of 16 bit value
    * 32 MHz equals 32 cycles pr. us. 
    *********************************************************************/
    inline void wait(uint16_t u)
    {
      uint8_t j;
      uint16_t i;
 
      u = u >> 3; // devide by 8 ~ 10 =]

      // (u*32) cycles / 10 (cyles/loop)
 
      for (i = 0; i < u; i++) {
        for (j = 0; j < 32;) {
            j++;
        }
      }
    }

}



