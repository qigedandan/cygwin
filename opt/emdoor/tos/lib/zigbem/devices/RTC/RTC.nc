#include "pcf8563.h"
interface RTC
{
	command error_t setTime(rtc_time *Time,uint8_t mTimeFlag);
	command error_t getTime(rtc_time *Time,uint8_t mTimeFlag);

	command error_t setAlarm(rtc_time *Time,uint8_t mTimeFlag,uint8_t mAlarmFlag);
	command error_t getAlarm(rtc_time *Time,uint8_t mTimeFlag,uint8_t *pAlarmFlag);

	event void AlarmFired();
	
	event void setTimeDone(error_t error, rtc_time *Time,uint8_t mTimeFlag);
	event void getTimeDone(error_t error, rtc_time *Time,uint8_t mTimeFlag);

	event void setAlarmDone(error_t error, rtc_time *Time,uint8_t mTimeFlag,uint8_t mAlarmFlag);
	event void getAlarmDone(error_t error, rtc_time *Time,uint8_t mTimeFlag,uint8_t *pAlarmFlag);

}

