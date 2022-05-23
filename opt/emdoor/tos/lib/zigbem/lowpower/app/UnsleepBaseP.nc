
module UnsleepBaseP
{
	provides interface UnsleepBase;

	uses interface Timer<TMilli>;
	uses interface ClockSync;
}
implementation
{
	/*=======================*/
	
	
	/*=======================*/
	command error_t UnsleepBase.start(uint32_t interval)
	{
		call ClockSync.sourceBroadcast();
		
		call Timer.startPeriodic(interval);
	
		return SUCCESS;
	}

	event void Timer.fired()
	{
		ADBG(DBG_LEV, "\n\n#################\nUnsleepBase broadcast begin\n");
		//call ClockSync.sourceBroadcast();
	}

	
	event void ClockSync.syncFired(bool unsyncBefore)
	{
	}

	event void ClockSync.requestSyncDone(error_t result)
	{
	}
	
	event void ClockSync.sourceBroadcastDone(error_t result)
	{
	}
	
}

