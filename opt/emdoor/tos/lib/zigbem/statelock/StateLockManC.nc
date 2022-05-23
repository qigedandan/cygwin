#include "StateLock.h"

generic configuration StateLockManC(char RES_ID[])
{
    provides interface StateLock[uint8_t num];
    provides interface StateLockMan;
}
implementation
{
    components new StateLockManP(uniqueCount(RES_ID));

    StateLock = StateLockManP;
    StateLockMan = StateLockManP;

    components MainC;
    MainC.SoftwareInit -> StateLockManP;
}

