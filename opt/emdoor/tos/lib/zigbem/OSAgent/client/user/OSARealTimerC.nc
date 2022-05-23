
configuration OSARealTimerC
{
	provides interface RealTimer<TMilli, uint32_t>;
}
implementation
{
	components new RealTimerP();
	components OSACounterMilli32C;

	RealTimer = RealTimerP;
	RealTimerP.Counter -> OSACounterMilli32C;
}

