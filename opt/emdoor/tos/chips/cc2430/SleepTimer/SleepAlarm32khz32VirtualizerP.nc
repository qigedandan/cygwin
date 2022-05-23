


#include "SleepAlarmConstants.h"


configuration SleepAlarm32khz32VirtualizerP
{
	provides interface Alarm<T32khz, uint32_t>[uint8_t id];
}
implementation
{
	enum
	{
		COUNT = uniqueCount(UQ_VIRTUALIZED_SLEEPALARM_32KHZ_32),
	};

	components new SleepAlarm32Khz32C();

	components new VirtualizeAlarmC(T32khz, uint32_t, COUNT) as Alarms;
	Alarm = Alarms.Alarm;
	Alarms.AlarmFrom -> SleepAlarm32khz32C;
}

