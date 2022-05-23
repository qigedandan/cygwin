

#include "TimerRTC.h"

interface UnsleepClock {
	command timerrtc_time_t getClockTime();
	command void setClockTime(timerrtc_time_t time);
	
	command error_t sleepCpu(timerrtc_time_t time);

	event void cpuWakeup();
}

