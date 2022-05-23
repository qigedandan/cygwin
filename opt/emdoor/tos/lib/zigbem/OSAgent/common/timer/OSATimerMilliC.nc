#include "OSATimer.h"

generic configuration OSATimerMilliC()
{
	provides interface Timer<TMilli>;
}
implementation
{
	components MainC;
	components HilOSATimerMilliC;

	MainC.SoftwareInit -> HilOSATimerMilliC;
	Timer = HilOSATimerMilliC.TimerMilli[unique(UQ_OSATIMER_MILLI)];
}


