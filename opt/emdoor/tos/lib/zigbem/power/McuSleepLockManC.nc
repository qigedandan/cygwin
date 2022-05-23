#include "McuSleep.h"

configuration McuSleepLockManC
{
    provides interface McuSleepLock[uint8_t num];
    provides interface McuSleepLockMan;
}
implementation
{
    components new McuSleepLockManP(uniqueCount(UQ_MCUSLEEP_LOCK));

    McuSleepLock = McuSleepLockManP;
    McuSleepLockMan = McuSleepLockManP;

	  #ifdef MCU_SLEEP
	    components OSA_MainC as MainC;
	    MainC.SoftwareInit -> McuSleepLockManP.Init;
    #endif
}

