#include "McuSleep.h"

generic configuration McuSleepLockC()
{
    provides interface McuSleepLock;
}
implementation
{
    components McuSleepLockManC;
    
    McuSleepLock = McuSleepLockManC.McuSleepLock[unique(UQ_MCUSLEEP_LOCK)];
}

