

configuration HilAlarm32khzC
{
  provides interface Init;
  provides interface Alarm<T32khz, uint32_t> as Alarm32khz[ uint8_t num ];
}
implementation
{
  components new Alarm32khz32C();
  components new VirtualizeAlarmC(T32khz, uint32_t, uniqueCount(UQ_ALARM_32KHZ));

  Init = VirtualizeAlarmC;
  Alarm32khz = VirtualizeAlarmC;

  VirtualizeAlarmC.AlarmFrom -> Alarm32khz32C;
}
