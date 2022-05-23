
configuration SleepNodeSimpleForwardC
{
	provides interface SimpleForward;
	provides interface Intercept;
	provides interface CoreControl;
}
implementation
{
	components new SimpleForwardC(10);
	SimpleForward = SimpleForwardC;
	Intercept = SimpleForwardC;
	CoreControl = SimpleForwardC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();

	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> SimpleForwardC;
}

