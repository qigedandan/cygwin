


module OSARFInterruptsP {

  provides interface GpioCapture as CaptureSFD;
  provides interface GpioInterrupt as InterruptTXDone;
  provides interface GpioInterrupt as InterruptCCA;
  provides interface GpioInterrupt as InterruptFIFOP;
  provides interface GpioInterrupt as InterruptRFErr;
  
  uses interface PlatformInterruptRF<TPlatformIntOSA> as IntRF;

}

implementation {

  /**
   * Any one interrupt is eabled then RFIE will be enabled, which is never disabled.
   * So if all interrupts are later turned off we will still receive the RFIE interrups,
   * but they will be rejected in the interrupt handler...
   */

  /**
   * All the interrupts are "rising-edge" that is the interrupts are generated
   * when the corresponding signal goes from 0 to 1
   */

 // Clear any left over inerrupts
 // Enable the global RFIE - for all
 // Enable the bit mask for this int
 // No falling int will be generated

#define MAKE_NEW_RF_IRQ(name, bit_name)		   \
  async command error_t name.enableRisingEdge() {  \
    atomic {		                           \
     RFIM |=  _BV(CC2430_RFIM_##bit_name );        \
     RFIF &= ~_BV(CC2430_RFIF_##bit_name);         \
     IEN2 |=  _BV(CC2430_IEN2_RFIE);               \
    }                                              \
    return SUCCESS;                                \
  };						   \
  async command error_t name.enableFallingEdge() { \
     return FAIL;                                  \
  };				                   \
  async command error_t name.disable() {           \
    atomic {RFIM &= ~_BV( CC2430_RFIM_##bit_name );}\
    return SUCCESS;                                \
  };

  /*
   * Ugh.. Hack, maybe I should do a real capture some day...
   *
   * we just want to capture the radio matches the start frame (SFD) and we know they'll
   * be using timer 1 - so just read the time and give it to 'em 0].
   */

#define GET_NOW(p) ((uint8_t*)&p)[1]=T1CNTL;\
                   ((uint8_t*)&p)[0]=T1CNTH
 // Clear any left over inerrupts
 // Enable the global RFIE - for all
#define MAKE_NEW_RF_CAPTURE(name, bit_name)	   \
  async command error_t name.captureRisingEdge() { \
    atomic {                                       \
     RFIM |=  _BV(CC2430_RFIM_##bit_name);	   \
     RFIF &= ~_BV(CC2430_RFIF_##bit_name);         \
     IEN2 |=  _BV(CC2430_IEN2_RFIE);               \
     return SUCCESS;                               \
    }                                              \
  };                                               \
  async command error_t name.captureFallingEdge() {\
    return FAIL;				   \
  };                                               \
  async command void name.disable() {              \
    atomic {RFIM &= ~_BV(CC2430_RFIM_##bit_name);} \
  };


/*
 * Interrupts from SIG_RF
 */

  MAKE_NEW_RF_IRQ(InterruptCCA, CCA);
  MAKE_NEW_RF_IRQ(InterruptFIFOP, FIFOP);
  MAKE_NEW_RF_IRQ(InterruptTXDone, TXDONE);

  MAKE_NEW_RF_CAPTURE(CaptureSFD, SFD);

/*
 * Interrupts from SIG_RFERR
 */

  async command error_t InterruptRFErr.enableRisingEdge() {
    atomic {
      RFERRIF = 0;	
      RFERRIE = 1;
    }
    return SUCCESS;
  };
  async command error_t InterruptRFErr.enableFallingEdge() {
     return FAIL;
  };
  async command error_t InterruptRFErr.disable() {
     RFERRIE = 0;
     return SUCCESS;
  }


  event void IntRF.firedRFERR()
  {
  atomic {
    RFERRIF = 0; // Same as TCON &= ~_BV(1);
    signal InterruptRFErr.fired();
  }
  }

  event void IntRF.firedRF()
  {
    // Remember to clear the flags in the order RFIM, S1CON
    // see datasheet section 14.4

     //P1_3 = P1_3 ? 0 : 1; // Toggle Led3

    atomic{
      uint8_t RFIF_RFIM = RFIF & RFIM; // Event signalled and mask enabled


      // Clear all interrupt flags
      //RFIF = 0;

      /* The eratta sheet suggests that this is the propper way
	 to work arround bugs */

      RFIF &= ~((uint8_t)0x01);
      RFIF &= ~((uint8_t)0x02);
      RFIF &= ~((uint8_t)0x04);
      RFIF &= ~((uint8_t)0x08);
      RFIF &= ~((uint8_t)0x10);
      RFIF &= ~((uint8_t)0x20);
      RFIF &= ~((uint8_t)0x40);
      RFIF &= ~((uint8_t)0x80);

      if ( RFIF_RFIM & _BV(CC2430_RFIF_CCA)) {
	  signal InterruptCCA.fired();
      }

      if ( RFIF_RFIM & _BV(CC2430_RFIF_FIFOP)) {
         P1_0 = P1_0 ? 0 : 1; // Toggle Led1
	  signal InterruptFIFOP.fired();
      }

      if ( RFIF_RFIM & _BV(CC2430_RFIF_TXDONE)) {
	  signal InterruptTXDone.fired();
      }

      if ( RFIF_RFIM & _BV(CC2430_RFIF_SFD) ) {
    	uint16_t now;
    	GET_NOW(now);
    	signal CaptureSFD.captured(now);
      }

      // Clear the general RF interrupts
      S1CON &= ~0x03;
      
    }
  }

 default async event void CaptureSFD.captured(uint16_t time) {}
 default async event void InterruptTXDone.fired() {}
 default async event void InterruptCCA.fired() {}
 default async event void InterruptFIFOP.fired() {}
 default async event void InterruptRFErr.fired() {}


}
