
interface CycleNodeUnsync {
	command void begin();	
	event void end(uint8_t result);

	command timerrtc_time_t getSleepTime();
}

