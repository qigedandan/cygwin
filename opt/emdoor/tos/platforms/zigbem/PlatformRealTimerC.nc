

configuration PlatformRealTimerC
{
	provides interface RealTimer<TMilli, uint32_t>;
}
implementation
{
	components new RealTimerC();
	RealTimer = RealTimerC;
}
