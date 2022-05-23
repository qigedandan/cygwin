

#include <ioCC2430.h>

#warning "This code is untested"

module HplCC2430Timer2P {
  provides interface HplCC2430TimerMAC as Timer2;
  provides interface Init;

} implementation {
  command error_t Init.init() {

    T2CNF &= ~(CC2430_T2CNF_CMPIF | CC2430_T2CNF_PERIF | CC2430_T2CNF_OFCMPIF); // Clear all if

    return SUCCESS;
  }

  async command void Timer2.setMode( enum cc2430_timerMAC_mode_t mode ){
    T2CNF = (T2CNF & ~_BV(CC2430_T2CNF_RUN)) | mode;
  };

  async command enum  Timer2.getMode(){
    return ((enum cc2430_timerMAC_mode_t) (T2CNF & CC2430_T2CNF_RUN));
  };

  async command uint16_t Timer2.getAdjust() {
  }

  async command void Timer2.setAdjust( uint16_t d ) {
  }

  async command void Timer2.enableOvfCmpEvent(){  T2PEROF2 |=  _BV(CC2430_T2PEROF2_OFCMPIM); }
  async command void Timer2.disableOvfCmpEvent(){ T2PEROF2 &= ~_BV(CC2430_T2PEROF2_OFCMPIM); }

  async command void Timer2.enableOverflowEvent(){  T2PEROF2 |=  _BV(CC2430_T2PEROF2_CMPIM); }
  async command void Timer2.disableOverflowEvent(){ T2PEROF2 &= ~_BV(CC2430_T2PEROF2_CMPIM); }

  async command void Timer2.enableCmpEvent(){  T2PEROF2 |=  _BV(CC2430_T2PEROF2_OFCMPIM); }
  async command void Timer2.disableCmpEvent(){ T2PEROF2 &= ~_BV(CC2430_T2PEROF2_OFCMPIM); }

  async command bool Timer2.isIfPending(enum cc2430_timerMAC_if_t if_mask_t){
    return (T2CNF & if_mask);
  };
  async command void Timer2.clearIf(enum cc2430_timerMAC_if if_mask_t){
    T2CNF &= ~if_mask;
  };

  MCS51_INTERRUPT(SIG_T2) {
    signal Timer2.fired();
  }
}
