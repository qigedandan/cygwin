


generic configuration OSAAlarm32khz16C() {
  provides interface Init;
  provides interface Alarm<T32khz,uint16_t> as Alarm;
} implementation {

  components OSATimer1AlarmCounterC;

  enum { ALARM_ID = unique("OSAAlarmTimer1") };

  Init = OSATimer1AlarmCounterC;
  Alarm = OSATimer1AlarmCounterC.Alarm[ ALARM_ID ];
}
