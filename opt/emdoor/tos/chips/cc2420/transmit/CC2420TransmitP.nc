/*
 * "Copyright (c) 2007-2008 Washington University in St. Louis.
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 *
 * IN NO EVENT SHALL WASHINGTON UNIVERSITY IN ST. LOUIS BE LIABLE TO ANY PARTY
 * FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
 * OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF WASHINGTON
 * UNIVERSITY IN ST. LOUIS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * WASHINGTON UNIVERSITY IN ST. LOUIS SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND WASHINGTON UNIVERSITY IN ST. LOUIS HAS NO
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
 * MODIFICATIONS."
 */
 
/*
 * Copyright (c) 2005-2006 Arch Rock Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Arch Rock Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * ARCHED ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */

/**
 * @author Jonathan Hui <jhui@archrock.com>
 * @author David Moss
 * @author Jung Il Choi Initial SACK implementation
 * @author Greg Hackmann
 * @author Kevin Klues
 * @author Octav Chipara
 * @version $Revision: 1.1 $ $Date: 2007/07/04 00:37:16 $
 */

#include "CC2420.h"
#include "crc.h"
#include "message.h"

#include "CC2430_CSP.h"

module CC2420TransmitP {

  provides interface Init;
  provides interface AsyncStdControl;
  provides interface CC2420Transmit as Send;
  provides interface Resend;
  provides interface RadioTimeStamping as TimeStamp;
  provides interface ReceiveIndicator as EnergyIndicator;
  provides interface ReceiveIndicator as ByteIndicator;
  provides interface CcaControl[am_id_t amId];
  provides interface GlobalTXPower;
  
  uses interface Alarm<T32khz,uint32_t> as BackoffTimer;
 
  uses interface CC2420Packet;
  uses interface CC2420PacketBody;
  uses interface GpioCapture as CaptureSFD;
  uses interface GeneralIO as CCA;
  uses interface GeneralIO as CSN;
  uses interface GeneralIO as SFD;

  uses interface Resource as SpiResource;
  uses interface ChipSpiResource;
  uses interface CC2420Fifo as TXFIFO;
  uses interface CC2420Ram as TXFIFO_RAM;
  uses interface CC2420Register as TXCTRL;
  uses interface CC2420Strobe as SNOP;
  uses interface CC2420Strobe as STXON;
  uses interface CC2420Strobe as STXONCCA;
  uses interface CC2420Strobe as SFLUSHTX;
  uses interface CC2420Register as MDMCTRL1;

  uses interface CC2420Receive;
  uses interface Random;
  uses interface Leds;


  uses interface GpioInterrupt as InterruptTXDone;

  uses interface Timer<TMilli> as SystemTimer;
}

implementation {

  typedef enum {
    S_STOPPED,
    S_STARTED,
    S_LOAD,
    S_SAMPLE_CCA,
    S_BEGIN_TRANSMIT,
    S_SFD,
    S_EFD,
    S_ACK_WAIT,
    S_LOAD_CANCEL,
    S_TX_CANCEL,
    S_CCA_CANCEL,
  } cc2420_transmit_state_t;

  // This specifies how many jiffies the stack should wait after a
  // TXACTIVE to receive an SFD interrupt before assuming something is
  // wrong and aborting the send. There seems to be a condition
  // on the micaZ where the SFD interrupt is never handled.
  enum {
    CC2420_ABORT_PERIOD = 320//320
  };
  
  norace message_t *m_msg;
  
  norace bool m_cca;
  
  norace uint8_t m_tx_power;
  
  cc2420_transmit_state_t m_state = S_STOPPED;
  
  bool m_receiving = FALSE;
  
  uint16_t m_prev_time;

  uint8_t cc2420_default_power = CC2420_DEF_RFPOWER;
  
  /** Byte reception/transmission indicator */
  bool sfdHigh;
  
  /** Let the CC2420 driver keep a lock on the SPI while waiting for an ack */
  bool abortSpiRelease;
  
  /** Total CCA checks that showed no activity before the NoAck LPL send */
  norace int8_t totalCcaChecks;
  
  /** The initial backoff period */
  norace uint16_t myInitialBackoff;
  
  /** The congestion backoff period */
  norace uint16_t myCongestionBackoff;
  

  /***************** Prototypes ****************/
  error_t send( message_t *p_msg, bool cca );
  error_t resend( bool cca );
  void loadTXFIFO();
  void attemptSend();
  void requestInitialBackoff(message_t * msg);
  void requestCongestionBackoff(message_t * msg);
  void congestionBackoff();
  error_t acquireSpiResource();
  error_t releaseSpiResource();
  void signalDone( error_t err );
  uint16_t defaultInitialBackoff();
  uint16_t defaultCongestionBackoff();
  bool defaultCca();
  
  
  /***************** Init Commands *****************/
  command error_t Init.init() {
    call CCA.makeInput();
    call CSN.makeOutput();
    call SFD.makeInput();
   call BackoffTimer.stop();
   ADBG(1, "***Init.init()  call BackoffTimer.stop()\n");
    return SUCCESS;
  }

  /****************** GlobalTXPower commands ************/
  command uint8_t GlobalTXPower.getTXPower()
  {
  	atomic return cc2420_default_power;
  }

  command void GlobalTXPower.setTXPower(uint8_t power)
  {
  	cc2420_default_power = power;
  }
  /***************** StdControl Commands ****************/
  async command error_t AsyncStdControl.start() {
    ADBG(12, "CC2420TransmitP.AsyncStdControl.start\n");
    atomic {
      call InterruptTXDone.enableRisingEdge();
      call CaptureSFD.captureRisingEdge();
      m_state = S_STARTED;
      m_receiving = FALSE;
      abortSpiRelease = FALSE;
      m_tx_power = 0;
    }
   
    return SUCCESS;
  }

  async command error_t AsyncStdControl.stop() {
    ADBG(12, "CC2420TransmitP.AsyncStdControl.stop\n");
    
    atomic {
       m_state = S_STOPPED;
      call BackoffTimer.stop();
      ADBG(1, "***AsyncStdControl.stop()  call BackoffTimer.stop()\n");
      call CaptureSFD.disable();
      call InterruptTXDone.disable();
      call SpiResource.release();  // REMOVE
      call CSN.set();
    }
    //call BackoffTimer.stop();
    return SUCCESS;
  }


  /**************** Send Commands ****************/
  am_id_t getType(message_t * p_msg) { 
    return ((cc2420_header_t*)(p_msg->data - sizeof(cc2420_header_t)))->type;
  }

  async command error_t Send.send( message_t* p_msg ) {
    ADBG(12, "CC2420TransmitP.CC2420Transmit.send p_msg=0x%x, m_state = %d\n", (int)p_msg,(int)m_state);
    return send( p_msg, signal CcaControl.getCca[getType(p_msg)](p_msg, defaultCca()) );
  }

  async command error_t Resend.resend() {
    ADBG(12, "CC2420TransmitP.Resend.resend m_msg=0x%x\n", (int)m_msg);
    return resend( signal CcaControl.getCca[getType(m_msg)](m_msg, defaultCca()) );
  }

  async command error_t Send.cancel() {
    atomic {
      switch( m_state ) {
      case S_LOAD:
         m_state = S_LOAD_CANCEL;
        break;
        
      case S_SAMPLE_CCA:
         m_state = S_CCA_CANCEL;
        break;
        
      case S_BEGIN_TRANSMIT:
         m_state = S_TX_CANCEL;
        break;
        
      default:
        //cancel not allowed while radio is busy transmitting
        return FAIL;
      }
    }

    return SUCCESS;
  }

  async command error_t Send.modify( uint8_t offset, uint8_t* buf, 
                                     uint8_t len ) {
    call CSN.clr();
    call TXFIFO_RAM.write( offset, buf, len );
    call CSN.set();
    return SUCCESS;
  }
  
  /***************** Indicator Commands ****************/
  command bool EnergyIndicator.isReceiving() {
    return !(call CCA.get());
  }
  
  command bool ByteIndicator.isReceiving() {
    bool high;
    //atomic high = sfdHigh;
    atomic high = (m_state >= S_LOAD && m_state<= S_ACK_WAIT);
    
    return high;
  }  
  
  
  /***************** CC2420Receive Events ****************/
  /**
   * If the packet we just received was an ack that we were expecting,
   * our send is complete.
   */
  async event void CC2420Receive.receive( uint8_t type, message_t* ack_msg ) {
    cc2420_header_t* ack_header;
    cc2420_header_t* msg_header;
    cc2420_metadata_t* msg_metadata;
    uint8_t* ack_buf;
    uint8_t length;

      ADBG(10, "CC2420TransmitP.CC2420Receive.receive type=%d, m_state=%d\n", (int)type, (int)m_state);

    if ( type == IEEE154_TYPE_ACK ) {
      ack_header = call CC2420PacketBody.getHeader( ack_msg );
      msg_header = call CC2420PacketBody.getHeader( m_msg );
      

      
      if ( m_state == S_ACK_WAIT && msg_header->dsn == ack_header->dsn ) {
        ADBG(1, "***CC2420Receive.receive  call BackoffTimer.stop()\n");
	 call BackoffTimer.stop();
	 ADBG(12, "IEEE154_TYPE_ACK m_state= %d, msg_header->dsn=0x%x, ack_header->dsn=0x%x\n", (int)m_state, (int)msg_header->dsn, (int)ack_header->dsn);
        
        
        msg_metadata = call CC2420PacketBody.getMetadata( m_msg );
        ack_buf = (uint8_t *) ack_header;
        length = ack_header->length;
        
        msg_metadata->ack = TRUE;
        msg_metadata->rssi = ack_buf[ length - 1 ];
        msg_metadata->lqi = ack_buf[ length ] & 0x7f;
        signalDone(SUCCESS);
        
      }
    }
  }

  
  /******************************************************************************************************/
  /**
   * The CaptureSFD event is actually an interrupt from the capture pin
   * which is connected to timing circuitry and timer modules.  This
   * type of interrupt allows us to see what time (being some relative value)
   * the event occurred, and lets us accurately timestamp our packets.  This
   * allows higher levels in our system to synchronize with other nodes.
   *
   * Because the SFD events can occur so quickly, and the interrupts go
   * in both directions, we set up the interrupt but check the SFD pin to
   * determine if that interrupt condition has already been met - meaning,
   * we should fall through and continue executing code where that interrupt
   * would have picked up and executed had our microcontroller been fast enough.
   */

  void doCaptureSFD(uint16_t time)
  {

  	ADBG(12, "doCaptureSFD time=0x%x, m_state=%d\n", time, (int)m_state);
  	
	atomic m_state = S_EFD;
	sfdHigh = TRUE;
	
	signal TimeStamp.transmittedSFD( time, m_msg );
	if ( (call CC2420PacketBody.getHeader( m_msg ))->fcf & ( 1 << IEEE154_FCF_ACK_REQ ) ) {
		// This is an ack packet, don't release the chip's SPI bus lock.
		abortSpiRelease = TRUE;
	}
	releaseSpiResource();
	ADBG(1, "***doCaptureSFD  call BackoffTimer.stop()\n");
	call BackoffTimer.stop();

        
	if ( ( ( (call CC2420PacketBody.getHeader( m_msg ))->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7 ) == IEEE154_TYPE_DATA ) {
		(call CC2420PacketBody.getMetadata( m_msg ))->time = time;
	}

	//XLQ: 2009-12-01
	call BackoffTimer.start(CC2420_TXDONE_PERIOD);
  }

  void doTxDone(uint16_t time)
  {
	sfdHigh = FALSE;
       call BackoffTimer.stop();

	ADBG(5, "doTxDone m_state=%d\n", (int)m_state);
        
       if ( (call CC2420PacketBody.getHeader( m_msg ))->fcf & ( 1 << IEEE154_FCF_ACK_REQ ) ) {
          atomic m_state = S_ACK_WAIT;
          ADBG(12, "call BackoffTimer.start( CC2420_ACK_WAIT_DELAY ) = %d\n", (int)CC2420_ACK_WAIT_DELAY);
          ADBG(1, "***doTxDone  call BackoffTimer.stop()\n");
          call BackoffTimer.start( CC2420_ACK_WAIT_DELAY );
       } else {
          signalDone(SUCCESS);
       }
  }

  void doTx2(uint16_t time)
  {
        /** Fall Through because the next interrupt was already received */
  	if ( !m_receiving ) {
          sfdHigh = TRUE;
          signal TimeStamp.receivedSFD( time );
          call CC2420Receive.sfd( time );
          m_receiving = TRUE;
          m_prev_time = time;
          if ( call SFD.get() ) {
            // wait for the next interrupt before moving on
            return;
          }
       }
        
        sfdHigh = FALSE;
        m_receiving = FALSE;
        if ( time - m_prev_time < 10 ) {
          call CC2420Receive.sfd_dropped();
        }
  }

  
  async event void CaptureSFD.captured( uint16_t time )
  {
  
    atomic
    {
        if (m_state == S_SFD)
        {
	        doCaptureSFD(time);
	        if (!call SFD.get())
	        {
	        	doTxDone(time);
	        }
	 }
    }
  }

  
  #define GET_NOW(p) { ((uint8_t*)&p)[1]=T1CNTL; ((uint8_t*)&p)[0]=T1CNTH; }
  async event void InterruptTXDone.fired()
  {
  	uint16_t time;
  	
  	GET_NOW(time);  /* The timer1 */
  	
  	//ADBG(DBG_LEV, "InterruptTXDone.fired time=0x%x\n", time);
  	
  	
  	if (m_state == S_EFD)
  	{
  		doTxDone(time);
/*
  		if (call SFD.get())
  		{
  			doTx2(time);
  		}*/
  	}
  	
  }
  

  /***************** ChipSpiResource Events ****************/
  async event void ChipSpiResource.releasing() {
    if(abortSpiRelease) {
      call ChipSpiResource.abortRelease();
    }
  }
  

  /***************** SpiResource Events ****************/
  event void SpiResource.granted() {
    uint8_t cur_state;

    ADBG(5, "CC2420Transmit.SpiResource.granted\n");

    atomic {
      cur_state = m_state;
    }

    switch( cur_state ) {
    case S_LOAD:
      loadTXFIFO();
      break;
      
    case S_BEGIN_TRANSMIT:
      attemptSend();
      break;
      
    case S_LOAD_CANCEL:
    case S_CCA_CANCEL:
    case S_TX_CANCEL:
      call CSN.clr();
      call SFLUSHTX.strobe();
      call CSN.set();
      releaseSpiResource();
      atomic {
        m_state = S_STARTED;
      }
      break;
      
    default:
      releaseSpiResource();
      break;
    }
  }
  
  /***************** TXFIFO Events ****************/
  /**
   * The TXFIFO is used to load packets into the transmit buffer on the
   * chip
   */
  async event void TXFIFO.writeDone( uint8_t* tx_buf, uint8_t tx_len,
                                     error_t error ) {

    ADBG(1, "TXFIFO.writeDone, m_state=%d\n",(int)m_state);

    call CSN.set();
    if ( m_state == S_LOAD_CANCEL ) {
      atomic {
        call CSN.clr();
        call SFLUSHTX.strobe();
        call CSN.set();
      }
      releaseSpiResource();
      atomic m_state = S_STARTED;

    } else if ( !m_cca ) {
      atomic {
        if (m_state == S_LOAD_CANCEL) {
           m_state = S_TX_CANCEL;
        } else {
           m_state = S_BEGIN_TRANSMIT;
        }
      }
      attemptSend();
      
    } else {
      releaseSpiResource();
      atomic {
        if (m_state == S_LOAD_CANCEL) {
          m_state = S_CCA_CANCEL;
        } else {
          m_state = S_SAMPLE_CCA;
        }
      }
      
      requestInitialBackoff(m_msg);
      ADBG(1, "***TXFIFO.writeDone  call BackoffTimer.stop()\n");
      call BackoffTimer.stop();
      call BackoffTimer.start(myInitialBackoff);
    }
  }

  
  async event void TXFIFO.readDone( uint8_t* tx_buf, uint8_t tx_len, 
      error_t error ) {
  }
  
  
  /***************** Timer Events ****************/
  /**
   * The backoff timer is mainly used to wait for a moment before trying
   * to send a packet again. But we also use it to timeout the wait for
   * an acknowledgement, and timeout the wait for an SFD interrupt when
   * we should have gotten one.
   */
  async event void BackoffTimer.fired() {
     if (m_state >= S_SAMPLE_CCA)
     {
	     ADBG(1, "BackoffTimer.fired m_state=%d\n", (int)m_state);
     }
    atomic {
      switch( m_state ) {
        
      case S_SAMPLE_CCA : 
        // sample CCA and wait a little longer if free, just in case we
        // sampled during the ack turn-around window
        if ( call CCA.get() ) {
          m_state = S_BEGIN_TRANSMIT;
          call BackoffTimer.stop();
          ADBG(1, "***S_SAMPLE_CCA  call BackoffTimer.stop()\n");
          call BackoffTimer.start( CC2420_TIME_ACK_TURNAROUND );
          
        } else {
          congestionBackoff();
        }
        ADBG(1, "the cca is:%d\n", (int) call CCA.get());
        break;
        
      case S_CCA_CANCEL:
         m_state = S_TX_CANCEL;
        /** Fall Through */
        
      case S_BEGIN_TRANSMIT:
      case S_TX_CANCEL:
        if ( acquireSpiResource() == SUCCESS ) {
          attemptSend();
        }
        else
        {
        	ADBG(1, "\n\n@#$@#$@#$@#$  acquireSpiResource() fail!\n");
        }
        
        break;
        
      case S_ACK_WAIT:
      ADBG(1,"\r\nS_ACK_WAIT  timeout, FAIL\r\n");
        /*signalDone( SUCCESS );*/
        signalDone( FAIL);  /* It should be an error?? XLQ */
        break;

      case S_SFD:      
        // We didn't receive an SFD interrupt within CC2420_ABORT_PERIOD
        // jiffies. Assume something is wrong.
	case S_EFD:  //In case something that SFD without TXDONE,..?? XLQ 20091201
        call SFLUSHTX.strobe();
        releaseSpiResource();
        signalDone( ERETRY );
        break;

      default:
        break;
      }
    }
  }
      
  /***************** Functions ****************/
  /**
   * Set up a message to be sent. First load it into the outbound tx buffer
   * on the chip, then attempt to send it.
   * @param *p_msg Pointer to the message that needs to be sent
   * @param cca TRUE if this transmit should use clear channel assessment
   */
   event void SystemTimer.fired()
   {
   	signalDone(FAIL); ///wowo....
   }
   
  error_t send( message_t* p_msg, bool cca ) {
    ADBG(12, "CC2420TransmitP.send m_state = %d\n", (int)m_state);
    atomic {
      if (m_state == S_LOAD_CANCEL
          || m_state == S_CCA_CANCEL
          || m_state == S_TX_CANCEL) {
        return ECANCEL;
      }
      
      if ( m_state != S_STARTED ) {
        return FAIL;
      }
      
      m_state = S_LOAD;
      m_cca = cca;
      m_msg = p_msg;
      totalCcaChecks = 0;

      call SystemTimer.startOneShot(3000);   //very ugly to prevent TransmitP die...
    }
    
    if ( acquireSpiResource() == SUCCESS ) {
      ADBG(12, "acquireSpiResource Success!\n");
      loadTXFIFO();
    }

    return SUCCESS;
  }
  
  /**
   * Resend a packet that already exists in the outbound tx buffer on the
   * chip
   * @param cca TRUE if this transmit should use clear channel assessment
   */
  error_t resend( bool cca ) {
    ADBG(12, "CC2420TransmitP.resend() m_state = %d, cca=%d\n", (int)m_state,(int)cca);
    atomic {
      if (m_state == S_LOAD_CANCEL
          || m_state == S_CCA_CANCEL
          || m_state == S_TX_CANCEL) {
        return ECANCEL;
      }
      
      if ( m_state != S_STARTED ) {
        return FAIL;
      }
      
      m_cca = cca;
      m_state = cca ? S_SAMPLE_CCA : S_BEGIN_TRANSMIT;
      totalCcaChecks = 0;


      call SystemTimer.startOneShot(2000);   //very ugly to prevent TransmitP die...
    }
    
    if(m_cca) {
      requestInitialBackoff(m_msg);
      call BackoffTimer.stop();
          ADBG(1, "***resend call BackoffTimer.stop()\n");
      call BackoffTimer.start( myInitialBackoff );
      
    } else if ( acquireSpiResource() == SUCCESS ) {
      attemptSend();
    }
    
    return SUCCESS;
  }
  
  /**
   * Attempt to send the packet we have loaded into the tx buffer on 
   * the radio chip.  The STXONCCA will send the packet immediately if
   * the channel is clear.  If we're not concerned about whether or not
   * the channel is clear (i.e. m_cca == FALSE), then STXON will send the
   * packet without checking for a clear channel.
   *
   * If the packet didn't get sent, then congestion == TRUE.  In that case,
   * we reset the backoff timer and try again in a moment.
   *
   * If the packet got sent, we should expect an SFD interrupt to take
   * over, signifying the packet is getting sent.
   */
  void attemptSend() {
    uint8_t status;
    bool congestion = TRUE;

    ADBG(1, "CC2420TransmitP.attemptSend m_state=%d, m_cca=0x%x\n", (int)m_state, (int)m_cca);

    atomic {
      if (m_state == S_TX_CANCEL) {
        call SFLUSHTX.strobe();
        releaseSpiResource();
        call CSN.set();
        m_state = S_STARTED;
        
	ADBG(1, "S_TX_CANCEL\n");
        
        return;
      }
      
      
      call CSN.clr();
	/*
      status = m_cca ? call STXONCCA.strobe() : call STXON.strobe();
      if ( !( status & CC2420_STATUS_TX_ACTIVE ) ) {
        status = call SNOP.strobe();
        if ( status & CC2420_STATUS_TX_ACTIVE ) {
          congestion = FALSE;
        }
      }
      */

	/* Wait for it to send the packet */
	{
        uint8_t i = 0;
        uint8_t counter;
        while (i++ < 3) 
        {
            //RFST = _CC2430_ISTXON;
            status = m_cca ? call STXONCCA.strobe() : call STXON.strobe();
            counter = 0;

            do {
                status = _CC2430_RFSTATUS;
            }while ( !(status & _BV(CC2430_RFSTATUS_TX_ACTIVE))  && (counter++ < 200));

            if (status & _BV(CC2430_RFSTATUS_TX_ACTIVE)) 
            {
            	  congestion = FALSE;
                break;
             }
        }

        /***********************************************
        ** Check if packet is being transmitted
        ***********************************************/    
        if (!(status & _BV(CC2430_RFSTATUS_TX_ACTIVE))) {

            /* flush transmit buffer */
            RFST = _CC2430_ISFLUSHTX;

            ADBG(1, "   =======  TX FAIL, c2430 status=0x%x\n", (int)_CC2430_RFSTATUS);

            signalDone(FAIL);

            return;
        }
        }
      
      m_state = congestion ? S_SAMPLE_CCA : S_SFD;
      
      call CSN.set();
      
    }
    
    if ( congestion ) {
      ADBG(1, "   =======  congestion when TX, c2430 status=0x%x\n", (int)_CC2430_RFSTATUS);
      totalCcaChecks = 0;
      releaseSpiResource();
      congestionBackoff();
    } else {
        /*if ( (call CC2420PacketBody.getHeader( m_msg ))->fcf & ( 1 << IEEE154_FCF_ACK_REQ ) ) {	
      		ADBG(12, "call BackoffTimer.start(CC2420_ABORT_PERIOD) = %d\n", (int)CC2420_ABORT_PERIOD);
      		call BackoffTimer.stop();
     		 call BackoffTimer.start(CC2420_ABORT_PERIOD);
     	  }*/
	  ADBG(1, "call BackoffTimer.start CC2420_ABORT_PERIOD=%d\n", (int)CC2420_ABORT_PERIOD);
     	  call BackoffTimer.start(CC2420_ABORT_PERIOD);
    }
  }
  
  void requestInitialBackoff(message_t * msg) {
    myInitialBackoff = signal CcaControl.getInitialBackoff[getType(msg)](msg, defaultInitialBackoff()) + 1;
  }
  
  void requestCongestionBackoff(message_t * msg) {
    myCongestionBackoff = signal CcaControl.getCongestionBackoff[getType(msg)](msg, defaultCongestionBackoff()) + 1;
  }

  /**  
   * Congestion Backoff
   */
  uint8_t m_backoff_counter = 0;
   
  void congestionBackoff() {
    atomic {
      requestCongestionBackoff(m_msg);
      call BackoffTimer.stop();

	ADBG(1, "%%congestionBackoff!, RFIF=0x%x, RFIM=0x%x\n", (int)RFIF, (int)RFIM);

      if (m_backoff_counter++ < 5)
      {
	      call BackoffTimer.start(myCongestionBackoff);
      }
      else
      {/* fail off  congestionBackoff */
      		ADBG(1, "%%%%%Congestion FAIL!, RFIF=0x%x, RFIM=0x%x\n", (int)RFIF, (int)RFIM);
      		
      		m_backoff_counter= 0;
      		
      		RFST = _CC2430_ISSTOP;
      		RFST = _CC2430_ISRFOFF;
      		RFST = _CC2430_ISRXON;
      		
      		signalDone(FAIL);
      }
    }
  }
  
  error_t acquireSpiResource() {
    error_t error = call SpiResource.immediateRequest();
    if ( error != SUCCESS ) {
      call SpiResource.request();
    }
    return error;
  }

  error_t releaseSpiResource() {
    call SpiResource.release();
    return SUCCESS;
  }


  /** 
   * Setup the packet transmission power and load the tx fifo buffer on
   * the chip with our outbound packet.  
   *
   * Warning: the tx_power metadata might not be initialized and
   * could be a value other than 0 on boot.  Verification is needed here
   * to make sure the value won't overstep its bounds in the TXCTRL register
   * and is transmitting at max power by default.
   *
   * It should be possible to manually calculate the packet's CRC here and
   * tack it onto the end of the header + payload when loading into the TXFIFO,
   * so the continuous modulation low power listening strategy will continually
   * deliver valid packets.  This would increase receive reliability for
   * mobile nodes and lossy connections.  The crcByte() function should use
   * the same CRC polynomial as the CC2420's AUTOCRC functionality.
   */
  void loadTXFIFO() {
    cc2420_header_t* header = call CC2420PacketBody.getHeader( m_msg );
   uint8_t tx_power = (call CC2420PacketBody.getMetadata( m_msg ))->tx_power;

    if ( !tx_power ) {
      tx_power = cc2420_default_power;//CC2420_DEF_RFPOWER;
      ADBG(10,"the  txPower is:%d\r\n", (int)tx_power);
    }
    
    call CSN.clr();
    
    if ( m_tx_power != tx_power ) {
      call TXCTRL.write( ( 2 << CC2420_TXCTRL_TXMIXBUF_CUR ) |
                         ( 3 << CC2420_TXCTRL_PA_CURRENT ) |
                         ( 1 << CC2420_TXCTRL_RESERVED ) |
                         ( (tx_power & 0x1F) << CC2420_TXCTRL_PA_LEVEL ) );
    }
    
    m_tx_power = tx_power;
    
    call TXFIFO.write( (uint8_t*)header, header->length - 1);
  }
  
  void signalDone( error_t err ) {
  
    ADBG(1, "CC2420TransmitP.signalDone err=%d, m_msg=0x%x\n", (int)err, (int)m_msg);

    call SystemTimer.stop();
    
    atomic m_state = S_STARTED;
    abortSpiRelease = FALSE;
    call ChipSpiResource.attemptRelease();
    signal Send.sendDone( m_msg, err );
  }
  
  
  
  /***************** Tasks ****************/

  /***************** Defaults ****************/
  default async event void TimeStamp.transmittedSFD( uint16_t time, message_t* p_msg ) {
  }
  
  default async event void TimeStamp.receivedSFD( uint16_t time ) {
  }
  
   default async event uint16_t CcaControl.getInitialBackoff[am_id_t amId](message_t * msg, uint16_t defaultBackoff) {
  	return defaultBackoff;
  }
  
  default async event uint16_t CcaControl.getCongestionBackoff[am_id_t amId](message_t * msg, uint16_t defaultBackoff) {
  	return defaultBackoff;
  }
  
  default async event bool CcaControl.getCca[am_id_t amId](message_t * msg, bool defaultValue) {
  	return defaultValue;
  }
  
  uint16_t defaultInitialBackoff() {
  	return (call Random.rand16() 
        % (0x1F * CC2420_BACKOFF_PERIOD) + CC2420_MIN_BACKOFF);
  }
  
  uint16_t defaultCongestionBackoff() {
  	return ( call Random.rand16() % (0x7 * CC2420_BACKOFF_PERIOD) + CC2420_MIN_BACKOFF);
  }
  
  bool defaultCca() {
  	return TRUE;
  }
}

