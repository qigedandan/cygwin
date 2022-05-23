
interface SleepNodeAliveControl {
	command error_t start(uint32_t ms);
	event void aliveOver();
}

