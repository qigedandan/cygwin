#include "TimerRTC.h"

interface SleepNodeCycleControl {
	command error_t begin();
	event void end();

	command timerrtc_time_t getSleepTime();
}

