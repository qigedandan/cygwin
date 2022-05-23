
module SleepNodeAliveControlP
{
	provides interface SleepNodeAliveControl;
	
	uses interface CoreControlOwner;
	uses interface Timer<TMilli>;
}
implementation
{
	command error_t SleepNodeAliveControl.start(uint32_t ms)
	{
		call CoreControlOwner.setBusy(0);
		call Timer.startOneShot(ms);
	}

	event void Timer.fired()
	{
		signal SleepNodeAliveControl.aliveOver();
		call CoreControlOwner.setFree(0);
	}
	
	default event void SleepNodeAliveControl.aliveOver()
	{
	}
}

