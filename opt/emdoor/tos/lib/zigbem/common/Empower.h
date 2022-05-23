#ifndef EMPOWER_H
#define EMPOWER_H

#include "Emsleep.h"

#define EM_POWER_PM0   0
#define EM_POWER_PM1   1
#define EM_POWER_PM2   2
#define EM_POWER_PM3   3

uint8_t g_ant_power_state = EM_POWER_PM0;
uint32_t g_ant_sleep_time = 0x0000;

void antPowerSwitchTo(uint8_t power_state)
{
    g_ant_power_state = power_state;
}


#define antPowerProcess(void) \
{ \
    if (g_ant_power_state != EM_POWER_PM0)\
    {\
       SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | g_ant_power_state; \
       PCON = 0x01;\
       g_ant_power_state = EM_POWER_PM0;\
    }\
}


void antSleep(uint32_t time)
{    
    g_ant_power_state = EM_POWER_PM2;
    g_ant_sleep_time = time;
}

#endif

