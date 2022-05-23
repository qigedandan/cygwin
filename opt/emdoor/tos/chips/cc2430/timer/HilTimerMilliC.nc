

configuration HilTimerMilliC
{
  provides interface Init;
  provides interface Timer<TMilli> as TimerMilli[ uint8_t num ];
  provides interface LocalTime<TMilli> as LocalTime;
}
implementation
{
  components new AlarmMilli32C();
  components new AlarmToTimerC(TMilli);
  components new VirtualizeTimerC(TMilli,uniqueCount(UQ_TIMER_MILLI));
  components new CounterToLocalTimeC(TMilli);
  components CounterMilli32C;

  Init = AlarmMilli32C;
  TimerMilli = VirtualizeTimerC;
  LocalTime = CounterToLocalTimeC;

  VirtualizeTimerC.TimerFrom -> AlarmToTimerC;
  AlarmToTimerC.Alarm ->AlarmMilli32C;
  CounterToLocalTimeC.Counter -> CounterMilli32C;
}
