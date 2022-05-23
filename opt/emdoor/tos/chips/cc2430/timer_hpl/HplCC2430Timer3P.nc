

#include <ioCC2430.h>

#warning "This code is untested"

module HplCC2430Timer3P {
  provides interface HplCC2430Timer8 as Timer3;
  provides interface Init;

} implementation {
  command error_t Init.init() {

    T3CTL  = 0x00;    // Stop the timer
    T3CCTL0 = 0x00;
    T3CCTL1 = 0x00;   
    T3IE    = 0;      // Disable events
    T3OVFIF = 0;      // Clear any leftover events
    T3CH0IF = 0;
    T3CH1IF = 0;

    return SUCCESS;
  }

  async command uint8_t Timer3.get() {   return ((uint8_t) T3CNT);  };
  async command void Timer3.set( uint8_t t ){    T3CNT = t;        };

  async command void Timer3.setMode( enum cc2430_timer_mode_t mode ){
    T3CTL = (T3CTL & ~0x3) | mode;
  };
  async command enum cc2430_timer_mode Timer3.getMode(){
    return ((enum cc2430_timer_mode_t) (T3CTL & CC2430_T34CTL_MODE_MASK));
  };

  // Set/clear the interrupt mask
  async command void Timer3.enableEvents() {   T3IE    = 1;  };
  async command void Timer3.disableEvents(){   T3IE    = 0;  };

  async command void Timer3.enableOverflow() {  T3OVFIF = 1; }
  async command void Timer3.disableOverflow(){  T3OVFIF = 0; }


  async command bool Timer3.isIfPending(enum cc2430_timer34_if_t if_mask) {
    return (TIMIF | _BV(if_mask) );
  }
  async command void Timer3.clearIf(enum cc2430_timer34_if_t if_mask) {
    TIMIF &= ~_BV(if_mask);
  }

  async command bool Timer3.isOVFIFending() { return (bool) T3OVFIF; }
  async command void Timer3.clearOVFIF()    { T3OVFIF = 0;           }

  async command bool Timer3.isCH0IFPending(){ return (bool) T3CH0IF; }
  async command void Timer3.clearCH0IF()    { T3CH0IF = 0;           }

  async command bool Timer3.isCH1IFPending(){ return (bool) T3CH1IF; }
  async command void Timer3.clearCH1IF()    { T3CH1IF = 0;           }

  async command bool Timer3.enable(){
    T3CTL |= _BV(CC2430_T34CTL_START);
  };
  async command void Timer3.disable(){
    T3CTL &= ~_BV(CC2430_T34CTL_START);
  };

  async command void Timer3.setScale( enum cc2430_timer3_4_prescaler_t p){
    T3CTL = ((T3CTL & ~CC2430_T34CTL_DIV_MASK) | p);
  };
  async command enum cc2430_timer3_4_prescaler_t Timer3.getScale(){
    return ( (enum cc2430_timer3_4_prescaler_t ) T3CTL & CC2430_T34CTL_DIV_MASK);
  };

  MCS51_INTERRUPT(SIG_T3) {
    signal Timer3.fired();
  }
}
