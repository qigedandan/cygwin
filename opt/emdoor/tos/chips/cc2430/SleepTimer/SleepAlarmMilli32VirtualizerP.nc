

#include "SleepAlarmConstants.h"

/**
 * Provides an array of 32-bit millisecond Alarms, by virtualizing a
 * single SleepAlarmMilli32C.
 */

 configuration SleepAlarmMilli32VirtualizerP
 {
 	provides interface Init;
 	provides interface Alarm<TMilli, uint32_t>[uint8_t id];
 }
 implementation
 {
 	enum
 	{ 	
 		COUNT = uniqueCount(UQ_VIRTUALIZED_SLEEPALARM_MILLI_32),
 	};
 	components new SleepAlarmMilli32C();

 	components new VirtualizeAlarmC(TMilli, uint32_t, COUNT) as Alarms;
 	Init = SleepAlarmMilli32C;
 	Alarm = Alarms.Alarm;
 	Alarms.AlarmFrom -> SleepAlarmMilli32C;
#ifdef MCU_SLEEP
 	components new McuSleepLockC();
 	Alarms.McuSleepLock -> McuSleepLockC;
 #endif
 }
 
