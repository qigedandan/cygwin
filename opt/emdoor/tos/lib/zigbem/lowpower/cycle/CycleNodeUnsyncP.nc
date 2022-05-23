
module CycleNodeUnsyncP
{
	provides interface CycleNodeUnsync;

	uses interface ClockSync;
	uses interface UnsleepClock;

	uses interface Timer<TMilli> as UnsyncTimer;
	uses interface CoreControlOwner;
}
implementation
{
#ifndef SLEEPNODE_UNSYNC_SLEEP
#define SLEEPNODE_UNSYNC_SLEEP	5000
#endif

#ifndef SLEEPNODE_UNSYNC_WAKEUP
#define SLEEPNODE_UNSYNC_WAKEUP	3000
#endif
	
	/*=======================*/
	/*Unsynchornized*/

	void unsyncEnd()
	{
		call UnsyncTimer.stop();
		
		call CoreControlOwner.setFree(0);
	}
	
	void unsyncProcess()
	{
		call ClockSync.requestSync();
		call UnsyncTimer.startOneShot(SLEEPNODE_UNSYNC_WAKEUP);
	}

	event void UnsyncTimer.fired()
	{
		ADBG(DBG_LEV, "UnsyncTimer.fired\n");
		unsyncEnd();
	}
	
	event void ClockSync.syncFired(bool unsyncBefore)
	{
		ADBG(DBG_LEV, "ClockSync.syncFired unsyncBefore=%d\n", (int)unsyncBefore);

		if (unsyncBefore)
		{
			unsyncEnd();
		}
	}

	event void ClockSync.requestSyncDone(error_t result)
	{
	}
	
	event void ClockSync.sourceBroadcastDone(error_t result)
	{
	}

	
	event void UnsleepClock.cpuWakeup()
	{
	}
	
	/*=======================*/

	command void CycleNodeUnsync.begin()
	{
		call CoreControlOwner.setBusy(0);

		unsyncProcess();
	}

	
	command timerrtc_time_t CycleNodeUnsync.getSleepTime()
	{
		ADBG(DBG_LEV, "CycleNodeUnsync.getSleepTime()=%ld\n", SLEEPNODE_UNSYNC_SLEEP);
		atomic return SLEEPNODE_UNSYNC_SLEEP;
	}

	default event void CycleNodeUnsync.end(uint8_t result) { }
}

