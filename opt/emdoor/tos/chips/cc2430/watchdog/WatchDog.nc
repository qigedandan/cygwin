
interface WatchDog
{
	command void resetCpu();
	
	command void enable();
	command void disable();
	command void tickle();
}

