
#include "ioCC2430.h"

/* Just use while statement to delay us */
generic module BusyWaitMicroP()
{
  provides interface BusyWait<TMicro, uint16_t>;
}
implementation
{
  async command void BusyWait.wait(uint16_t us)
  {//no accurately, use the MACRO for wait
    uint32_t tick = us*32;
    do
    {
    }
    while (tick--);
  }
}
