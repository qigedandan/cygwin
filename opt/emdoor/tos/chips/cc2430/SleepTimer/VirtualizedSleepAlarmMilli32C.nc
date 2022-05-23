

#include "SleepAlarmConstants.h"

/**
 * Provides a millisecond, 32-bit Alarm. All instances of this component share
 * a single underlying SleepAlarm32C, so that you can instantiate as you need
 * without running out of harware timers.
 */

 generic configuration VirtualizedSleepAlarmMilli32C()
 {
 	provides interface Init;
 	provides interface Alarm<TMilli, uint32_t>;
 
 }
 implementation
 {
 	enum
 	{
 		ID = unique(UQ_VIRTUALIZED_SLEEPALARM_MILLI_32),
 	};
 	components SleepAlarmMilli32VirtualizerP as Alarms;
 	Alarm = Alarms.Alarm[ID]; 
 	Init = Alarms; 	
 }
 
