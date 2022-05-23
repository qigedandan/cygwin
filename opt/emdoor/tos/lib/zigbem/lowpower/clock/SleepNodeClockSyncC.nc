
configuration SleepNodeClockSyncC
{
	provides interface ClockSync;
	provides interface CoreControl;
}
implementation
{
	components new ClockSyncC(FALSE);

	ClockSync = ClockSyncC;
	CoreControl = ClockSyncC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();

	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> ClockSyncC;
}

