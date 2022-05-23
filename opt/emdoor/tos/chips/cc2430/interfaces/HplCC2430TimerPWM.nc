

#include <CC2430Timer.h>

interface HplCC2430TimerPWM {

  async command error_t PwmConfig(uint8_t cycle,uint8_t pulse);
  
  async command error_t SetPwmCycle(uint8_t cycle);
  
  async command error_t SetPwmPulseLength(uint8_t pulse);
  
  async command error_t PwmStart();
  
  async command error_t PwmStop();

}
