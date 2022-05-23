

#include "SleepAlarmConstants.h"

/**
 * Provides a 32 Khz, 32-bit Alarm. All instances of this component share
 * a single underlying SleepAlarm32Khz32C, so that you can instantiate as
 * you need without running out of hardware timers.
 */

generic configuration VirtualizedSleepAlarm32kh32C()
{
	provides interface Alarm<T32khz, uint32_t>;
}
implementation
{
	enum
	{
		ID = unique(UQ_VIRTUALIZED_SLEEPALRM_32KHZ_32),
	};

	components SleepAlarm32khz32VirtualizerP as Alarms;
	Alarm = Alarm.Alarm[ID];
}
 
