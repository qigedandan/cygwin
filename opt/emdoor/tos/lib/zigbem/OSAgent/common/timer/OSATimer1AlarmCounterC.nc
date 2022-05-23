

configuration OSATimer1AlarmCounterC
{
  provides interface Init;
  provides interface Counter< T32khz, uint16_t> as Counter;
  provides interface Alarm< T32khz, uint16_t> as Alarm[ uint8_t id ];
  provides interface GpioCapture as CaptureChannel2;
} implementation {

  components new OSATimer1AlarmCounterP( T32khz );
  components MainC;

  MainC.SoftwareInit -> OSATimer1AlarmCounterP;

  Init = OSATimer1AlarmCounterP;

  Alarm[0] = OSATimer1AlarmCounterP.Alarm0;
  Alarm[1] = OSATimer1AlarmCounterP.Alarm1;
  Alarm[2] = OSATimer1AlarmCounterP.Alarm2;
  Counter = OSATimer1AlarmCounterP.Counter;
  CaptureChannel2 = OSATimer1AlarmCounterP.CaptureChannel2;

  components PlatformInterruptC;
  OSATimer1AlarmCounterP.IntTimer -> PlatformInterruptC.IntTimerOSA;
  OSATimer1AlarmCounterP.PlatformInterrupt -> PlatformInterruptC;
}
