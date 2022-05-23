


generic configuration Alarm32khz16C() {
  provides interface Init;
  provides interface Alarm<T32khz,uint16_t> as Alarm;
} implementation {

  components HplCC2430Timer1AlarmCounterC;
  //components HplCC2430TimerSleepP;

  enum { ALARM_ID = unique("AlarmTimer1") };

  Init = HplCC2430Timer1AlarmCounterC;
  //Init = HplCC2430TimerSleepP;
  //Alarm = HplCC2430Timer1AlarmCounterC.Alarm[ ALARM_ID ];
  Alarm = HplCC2430Timer1AlarmCounterC.Alarm[ ALARM_ID ];
  //Alarm = HplCC2430TimerSleepP;
}
