
configuration OSALoggerRFC
{
	provides interface OSALoggerRF;
	uses interface OSALogger;
	uses interface RealTimer<TMilli, uint32_t>;
}
implementation
{
	components OSALoggerRFP;
	OSALoggerRF = OSALoggerRFP;
	OSALogger = OSALoggerRFP;
	RealTimer = OSALoggerRFP;
}

