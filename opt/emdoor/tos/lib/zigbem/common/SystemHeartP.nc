
module SystemHeartP
{
	provides interface StdControl;

	uses interface WatchDog;
	uses interface Timer<TMilli> as HeartTimer;
}
implementation
{
#define SYSTEM_HEART_SPEED 500
	
	command error_t StdControl.start()
	{
		call HeartTimer.startPeriodic(SYSTEM_HEART_SPEED);
		call WatchDog.enable();
	}

	command error_t StdControl.stop()
	{
		call HeartTimer.stop();
		call WatchDog.disable();
	}

	event void HeartTimer.fired()
	{
		call WatchDog.tickle();
	}
	
}

