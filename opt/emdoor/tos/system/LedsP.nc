/*************************************************
*	FUNCTION NAME : LedP.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

module LedsP {
  provides {
    interface Init;
    interface Leds;
  }
  uses {
    interface GeneralIO as RedLed;
    interface GeneralIO as BlueLed;
	interface GeneralIO as YellowLed;

	#ifdef USE_BOARD_LED	
    interface GeneralIO as BoardRedLed;
    interface GeneralIO as BoardBlueLed;
    interface GeneralIO as BoardGreenLed;
	interface GeneralIO as BoardYellowLed;
	#endif
  }
}
implementation {
  command error_t Init.init() {
    atomic {
      call RedLed.makeOutput();
      call BlueLed.makeOutput();
	  call YellowLed.makeOutput();
      call RedLed.set();
      call BlueLed.set();
	  call YellowLed.set();
	  #ifdef USE_BOARD_LED
	  call BoardRedLed.makeOutput();
      call BoardBlueLed.makeOutput();
      call BoardGreenLed.makeOutput();
	  call BoardYellowLed.makeOutput();
      call BoardRedLed.set();
      call BoardBlueLed.set();
      call BoardGreenLed.set();
	  call BoardYellowLed.set();
	  #endif
    }
    return SUCCESS;
  }

  async command void Leds.RedLedOn() {
    call RedLed.set();
	#ifdef USE_BOARD_LED
	call BoardRedLed.set();
	#endif
  }

  async command void Leds.RedLedOff() {
    call RedLed.clr();
	#ifdef USE_BOARD_LED
	call BoardRedLed.clr();
	#endif
  }

  async command void Leds.RedLedToggle() {
    call RedLed.toggle();
	#ifdef USE_BOARD_LED
	call BoardRedLed.toggle();
	#endif
  }

  async command void Leds.BlueLedOn() {
    call BlueLed.set();
	#ifdef USE_BOARD_LED
	call BoardBlueLed.set();
	#endif
  }

  async command void Leds.BlueLedOff() {
    call BlueLed.clr();
	#ifdef USE_BOARD_LED
	call BoardBlueLed.clr();
	#endif
  }

  async command void Leds.BlueLedToggle() {
    call BlueLed.toggle();
	#ifdef USE_BOARD_LED
	call BoardBlueLed.toggle();
	#endif
  }

  async command void Leds.YellowLedOn() {
    call YellowLed.set();
	#ifdef USE_BOARD_LED
	call BoardYellowLed.set();
	#endif
  }

  async command void Leds.YellowLedOff() {
    call YellowLed.clr();
	#ifdef USE_BOARD_LED
	call BoardYellowLed.clr();
	#endif
  }

  async command void Leds.YellowLedToggle() {
    call YellowLed.toggle();
	#ifdef USE_BOARD_LED
	call BoardYellowLed.toggle();
	#endif
  }
  
  
  #ifdef USE_BOARD_LED
  async command void Leds.GreenLedOn() {
    call BoardGreenLed.set();
  }

  async command void Leds.GreenLedOff() {
    call BoardGreenLed.clr();
  }

  async command void Leds.GreenLedToggle() {
    call BoardGreenLed.toggle();
  }
  #endif

}
