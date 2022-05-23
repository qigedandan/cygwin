
#include "OSATimer.h"

configuration HilOSATimerMilliC
{
  provides interface Init;
  provides interface Timer<TMilli> as TimerMilli[ uint8_t num ];
  provides interface LocalTime<TMilli> as LocalTime;
}
implementation
{
  components new OSAAlarmMilli32C();
  components new AlarmToTimerC(TMilli);
  components new VirtualizeTimerC(TMilli,uniqueCount(UQ_OSATIMER_MILLI));
  components new CounterToLocalTimeC(TMilli);
  components OSACounterMilli32C;

  Init = OSAAlarmMilli32C;
  TimerMilli = VirtualizeTimerC;
  LocalTime = CounterToLocalTimeC;

  VirtualizeTimerC.TimerFrom -> AlarmToTimerC;
  AlarmToTimerC.Alarm -> OSAAlarmMilli32C;
  CounterToLocalTimeC.Counter -> OSACounterMilli32C;
}
