
configuration CycleNodeUnsyncC
{
	provides interface CycleNodeUnsync;
	provides interface CoreControl;
}
implementation
{
	components CycleNodeUnsyncP;
	CycleNodeUnsync = CycleNodeUnsyncP;
	

	components SleepNodeClockSyncC;
	CycleNodeUnsyncP.ClockSync -> SleepNodeClockSyncC;

	components new TimerMilliC() as UnsyncTimerC;
	CycleNodeUnsyncP.UnsyncTimer -> UnsyncTimerC;

	components new CoreControlC();
	CoreControl = CoreControlC;
	CycleNodeUnsyncP.CoreControlOwner -> CoreControlC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();
	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> CoreControlC;
}

