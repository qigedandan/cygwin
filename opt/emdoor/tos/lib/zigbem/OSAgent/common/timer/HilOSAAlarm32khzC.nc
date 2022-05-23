#include "OSATimer.h"

configuration HilOSAAlarm32khzC
{
  provides interface Init;
  provides interface Alarm<T32khz, uint32_t> as Alarm32khz[ uint8_t num ];
}
implementation
{
  components new OSAAlarm32khz32C();
  components new VirtualizeAlarmC(T32khz, uint32_t, uniqueCount(UQ_OSAALARM_32KHZ));

  Init = VirtualizeAlarmC;
  Alarm32khz = VirtualizeAlarmC;

  VirtualizeAlarmC.AlarmFrom -> OSAAlarm32khz32C;
}
