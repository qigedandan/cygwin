

configuration HplCC2430Timer1AlarmCounterC{
  provides interface Init;
  provides interface Counter< T32khz, uint16_t> as Counter;
  provides interface Alarm< T32khz, uint16_t> as Alarm[ uint8_t id ];
  provides interface GpioCapture as CaptureChannel2;
} implementation {

  components new HplCC2430Timer1AlarmCounterP( T32khz );
  components MainC;

  MainC.SoftwareInit -> HplCC2430Timer1AlarmCounterP;

  Init = HplCC2430Timer1AlarmCounterP;

  Alarm[0] = HplCC2430Timer1AlarmCounterP.Alarm0;
  Alarm[1] = HplCC2430Timer1AlarmCounterP.Alarm1;
  Alarm[2] = HplCC2430Timer1AlarmCounterP.Alarm2;
  Counter = HplCC2430Timer1AlarmCounterP.Counter;
  CaptureChannel2 = HplCC2430Timer1AlarmCounterP.CaptureChannel2;

  components PlatformInterruptC;
  HplCC2430Timer1AlarmCounterP.IntTimer -> PlatformInterruptC.IntTimerUser;
  PlatformInterruptC.PlatformInterruptTimerControlUser -> HplCC2430Timer1AlarmCounterP;
  HplCC2430Timer1AlarmCounterP.PlatformInterrupt -> PlatformInterruptC;




  //components TimerRTCC;
  //HplCC2430Timer1AlarmCounterP.TimerRTC -> TimerRTCC;
}
