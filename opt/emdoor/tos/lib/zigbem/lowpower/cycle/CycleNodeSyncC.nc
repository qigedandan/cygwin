
configuration CycleNodeSyncC
{
	provides interface CycleNodeSync;
	provides interface CycleNodeSyncData;
	provides interface CoreControl;
}
implementation
{
	components CycleNodeSyncP;
	CycleNodeSync = CycleNodeSyncP;
	CycleNodeSyncData = CycleNodeSyncP;

	components SleepNodeClockSyncC;
	CycleNodeSyncP.ClockSync -> SleepNodeClockSyncC;

	components UnsleepClockC;
	CycleNodeSyncP.UnsleepClock -> UnsleepClockC;
	
	components new TimerMilliC() as SyncTimerC;
	CycleNodeSyncP.SyncTimer -> SyncTimerC;

	components new CoreControlC();
	CoreControl = CoreControlC;
	CycleNodeSyncP.CoreControlOwner -> CoreControlC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();
	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> CoreControlC;

}

