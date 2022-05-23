

generic configuration RealTimerC()
{
	provides interface RealTimer<TMilli, uint32_t>;
}
implementation
{
	components new RealTimerP();
	components CounterMilli32C;

	RealTimer = RealTimerP;
	RealTimerP.Counter -> CounterMilli32C;
}

