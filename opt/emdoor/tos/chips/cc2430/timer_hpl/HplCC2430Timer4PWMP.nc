
#include <ioCC2430.h>

module HplCC2430Timer4PWMP {
  provides interface HplCC2430TimerPWM as Timer4PWM;
  
} implementation {

  async command error_t Timer4PWM.PwmConfig(uint8_t cycle,uint8_t pulse)
  {
	T4CTL = 0x12;
	T4CCTL1 = 0x24;
	
	/*set p1.1 pwm output*/
	PERCFG &= ~0x10 ;	
	P1_ALT |= 0x02 ;   
	
	T4CC0 = cycle;
	T4CC1 = pulse;

	return SUCCESS;
  }
  
  async command error_t Timer4PWM.PwmStart()
  {
	T4CTL |= 0x10 ;
	return SUCCESS;	
  }
  
  async command error_t Timer4PWM.PwmStop()
  {
	T4CTL &= ~0x10 ;
	return SUCCESS;	
  }
  
  async command error_t Timer4PWM.SetPwmCycle(uint8_t cycle)
  {
	T4CC0 = cycle;
	return SUCCESS;	
  }
  
  async command error_t Timer4PWM.SetPwmPulseLength(uint8_t pulse)
  {
	T4CC1 = pulse;
	return SUCCESS;	
  }
}
