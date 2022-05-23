

generic module Halcc2430emLedPinP() {
  provides {
    interface Init;
    interface HalMcs51Led as Led;
  } 
  uses {
    interface GeneralIO as Led_pin;
  }
}
implementation {

  /*
   * Initialize the led to off: set the pin as output and set it
   * high. It should also select the function of the pin by setting
   * the P?SEL register (this is unsupported by the interface at this
   * time).
   */
  command error_t Init.init() {
    call Led_pin.makeOutput();
    call Led_pin.set();
    return SUCCESS;
  }

  async inline command void Led.on() {
    call Led_pin.clr();
  }

  async inline command void Led.off() {
    call Led_pin.set();
  }

  async inline command void Led.toggle() {
    // Either maintain the state of the Led in a variable or read it
    if(call Led_pin.get()){
      call Led_pin.clr();}
    else {
      call Led_pin.set();}
    }
}

