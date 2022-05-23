//#include "Timer.h"

configuration OSACounter32khz16C
{
  provides interface Counter<T32khz,uint16_t> as Counter;
}
implementation {
  components OSATimer1AlarmCounterC;

  Counter = OSATimer1AlarmCounterC.Counter;
}
