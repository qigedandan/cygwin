
configuration SleepNodeAliveControlC
{
	provides interface SleepNodeAliveControl;
	provides interface CoreControl;
}
implementation
{
	components SleepNodeAliveControlP;
	SleepNodeAliveControl = SleepNodeAliveControlP;

	components new CoreControlC();
	CoreControl = CoreControlC;
	SleepNodeAliveControlP.CoreControlOwner -> CoreControlC;

	components new TimerMilliC();
	SleepNodeAliveControlP.Timer -> TimerMilliC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();
	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> CoreControl;
}

