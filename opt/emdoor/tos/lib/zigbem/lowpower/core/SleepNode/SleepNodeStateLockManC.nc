
configuration SleepNodeStateLockManC
{
	provides interface StateLock[uint8_t num];
	provides interface StateLockMan;
}
implementation
{
	components new StateLockManC("SleepNodeStateLockManC.unique");

	StateLock = StateLockManC;
	StateLockMan = StateLockManC;
}

