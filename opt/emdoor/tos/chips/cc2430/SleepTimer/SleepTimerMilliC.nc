

#include "Timer.h"

generic configuration SleepTimerMilliC() {
	provides interface Timer<TMilli>;
}
implementation {
	components SleepTimerMilliP;

	Timer = SleepTimerMilliP.TimerMilli[unique(UQ_SLEEPTIMER_MILLI)];
}
