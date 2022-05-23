

#include <ioCC2430.h

#warning "This code is untested"

module HplCC2430TimerWDTP {
  provides interface HplCC2430TimerWDT as TimerWDT;
  provides interface Init;

} implementation {
  command error_t Init.init() {
    IR2CON2 |= ~_BV(CC2430_IRCON2_WDTIF);
  }

  async command void TimerWDT.clear() {
    WDCTL = (WDCTL & 0x0F) | 0xA0;
    WDCTL = (WDCTL & 0x0F) | 0x50;
  }

  async command void TimerWDT.setMode( enum cc2430_timerWDT_mode_t mode ) {
    if (mode) {
      WDCTL &= _BV(CC2430_WDCTL_MODE); 
    } else {
      WDCTL |= ~_BV(CC2430_WDCTL_MODE);
    }
  }

  async command void TimerWDT.setInterval( enum cc2430_timerMAC_interval_t i ){
    WDCTL = (WDCTL & ~CC2430_WDCTL_INT_MASK) | i;
  }

  async command enum cc2430_timerMAC_interval_t getInterval(){
    return (enum cc2430_timerMAC_interval_t) (WDCTL & 3);
  }
  
  async command void TimerWDT.enable()  {    WDCTL |= CC2430_WDCTL_EN;   }
  async command void TimerWDT.disable() {    WDCTL &= ~0x08;  }

  async command void TimerWDT.enableEvents()  { IEN2 &=  _BV(CC2430_IEN2_WDTIE)  }
  async command void TimerWDT.disableEvents() { IEN2 |= ~_BV(CC2430_IEN2_WDTIE); }

  
  MCS51_INTERRUPT(SIG_WDT) {
    signal TimerWDT.fired();
    IR2CON2 |= ~_BV(CC2430_IRCON2_WDTIF);
  }
}
