#include "Timer.h"
configuration SleepHilTimerMilliC
{
	provides interface Init;
	provides interface Timer<TMilli> as TimerMilli[ uint8_t num];
}
implementation
{
	//components new SleepAlarmMilli32C();
	components new VirtualizedSleepAlarmMilli32C();
	components new AlarmToTimerC(TMilli);
	components new VirtualizeTimerC(TMilli, uniqueCount(UQ_SLEEPTIMER_MILLI));

	//Init = SleepAlarmMilli32C;
	Init = VirtualizedSleepAlarmMilli32C;
	TimerMilli = VirtualizeTimerC;

	VirtualizeTimerC.TimerFrom -> AlarmToTimerC;
	//AlarmToTimerC.Alarm -> SleepAlarmMilli32C;
	AlarmToTimerC.Alarm -> VirtualizedSleepAlarmMilli32C.Alarm;
}
