

generic configuration SleepNodeStateLockC()
{
	provides interface StateLock;
}
implementation
{
	components SleepNodeStateLockManC;
	StateLock = SleepNodeStateLockManC.StateLock[unique("SleepNodeStateLockManC.unique")];
}

