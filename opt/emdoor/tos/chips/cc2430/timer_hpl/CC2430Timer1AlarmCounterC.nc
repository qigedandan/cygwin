

configuration CC2430Timer1AlarmCounterC {
  provides interface Counter<T32khz, uint16_t>;
  provides interface Alarm<T32khz, uint16_t>[ uint8_t id ];
} implementation {

  components new CC2430Timer1AlarmCounterP(T32khz);
  components MainC, HplCC2430Timer1P;

  MainC.SoftwareInit -> HplCC2430Timer1P;
  MainC.SoftwareInit -> CC2430Timer1AlarmCounterP.Init;
  CC2430Timer1AlarmCounterP.Timer1 -> HplCC2430Timer1P;
  CC2430Timer1AlarmCounterP.SubInit -> HplCC2430Timer1P.Init;

  Alarm[0] = CC2430Timer1AlarmCounterP.Alarm0;
  Alarm[1] = CC2430Timer1AlarmCounterP.Alarm1;
  Alarm[2] = CC2430Timer1AlarmCounterP.Alarm2;
  Alarm[3] = CC2430Timer1AlarmCounterP.Alarm3;
  Counter = CC2430Timer1AlarmCounterP;
}
