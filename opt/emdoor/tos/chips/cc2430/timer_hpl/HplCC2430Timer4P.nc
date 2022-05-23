
#include <ioCC2430.h>

#warning "This code is untested"

module HplCC2430Timer4P {
  provides interface HplCC2430Timer8 as Timer4;
  provides interface Init;

} implementation {
  command error_t Init.init() {

    T4CTL  = 0x00;    // Stop the timer
    T4CCTL0 = 0x00;
    T4CCTL1 = 0x00;   
    T4IE    = 0;      // Disable events
    T4OVFIF = 0;      // Clear any leftover events
    T4CH0IF = 0;
    T4CH1IF = 0;

    return SUCCESS;
  }

  async command uint8_t Timer4.get() {   return ((uint8_t) T4CNT);  };
  async command void Timer4.set( uint8_t t ){    T4CNT = t;        };

  async command void Timer4.setMode( enum cc2430_timer_mode_t mode ){
    T4CTL = (T4CTL & ~CC2430_T34CTL_MODE_MASK) | mode;
  };
  async command enum cc2430_timer_mode_t Timer4.getMode(){
    return ((enum cc2430_timer_mode_t) (T4CTL & CC2430_T34CTL_MODE_MASK));
  };

  // Set/clear the interrupt mask
  async command bool Timer4.isIfPending(enum cc2430_timer34_if_t if_mask) {
    return (TIMIF | _BV(if_mask) );
  }
  async command void Timer4.clearIf(enum cc2430_timer34_if_t if_mask) {
    TIMIF &= ~_BV(if_mask);
  }

  async command void Timer4.enableEvents() {   T4IE    = 1;  };
  async command void Timer4.disableEvents(){   T4IE    = 0;  };

  async command void Timer4.enableOverflow() {  T4OVFIF = 1; }
  async command void Timer4.disableOverflow(){  T4OVFIF = 0; }

  async command bool Timer4.isOVFIFending() { return (bool) T4OVFIF; }
  async command void Timer4.clearOVFIF()    { T4OVFIF = 0;           }

  async command bool Timer4.isCH0IFPending(){ return (bool) T4CH0IF; }
  async command void Timer4.clearCH0IF()    { T4CH0IF = 0;           }

  async command bool Timer4.isCH1IFPending(){ return (bool) T4CH1IF; }
  async command void Timer4.clearCH1IF()    { T4CH1IF = 0;           }

  async command bool Timer4.enable(){
    T4CTL |= _BV(CC2430_T34CTL_START);
  };
  async command void Timer4.disable(){
    T4CTL &= ~_BV(CC2430_T34CTL_START);
  };

  async command void Timer4.setScale( enum cc2430_timer3_4_prescaler_t p){
    T4CTL = ((T4CTL & ~CC2430_T34CTL_DIV_MASK) | p);
  };
  async command enum cc2430_timer3_4_prescaler_t Timer4.getScale(){
    return ( (enum cc2430_timer3_4_prescaler_t ) T4CTL & CC2430_T34CTL_DIV_MASK);
  };

  MCS51_INTERRUPT(SIG_T4) {
    signal Timer4.fired();
  }
}
