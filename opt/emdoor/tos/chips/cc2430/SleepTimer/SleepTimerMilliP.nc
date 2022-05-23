
#include "Timer.h"

configuration SleepTimerMilliP {
	provides interface Timer<TMilli> as TimerMilli[uint8_t id];
}
implementation {
	components SleepHilTimerMilliC, MainC;
	MainC.SoftwareInit -> SleepHilTimerMilliC;
	TimerMilli = SleepHilTimerMilliC;
}
