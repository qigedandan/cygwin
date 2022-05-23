#include "TimerRTC.h"

interface TimerRTC {
	command timerrtc_time_t getTime();
	command timerrtc_time_t getAlarmTime();
	command void setTime(timerrtc_time_t time);

	command void setUpdateRate(timerrtc_time_t time);
	command void setAlarmTime(timerrtc_time_t time);
	command void setAlarmPeriod(timerrtc_time_t period);

	command timerrtc_time_t getUpdateRate();
	
	event void alarmFired();
	event void updateFired();
}

