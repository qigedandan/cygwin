

#ifndef PLATFORM_LOGGER_SIZE

/* default log size 2K */
#define PLATFORM_LOGGER_SIZE 	1*1024
#endif /* PLATFORM_LOGGER_SIZE */

configuration PlatformLoggerC
{
	provides interface OSALogger;
	provides interface OSALoggerRF;
}
implementation
{
	components PlatformRealTimerC;
	components new OSALoggerC(PLATFORM_LOGGER_SIZE);
	components OSALoggerRFC;

	OSALogger = OSALoggerC;
	OSALoggerRF = OSALoggerRFC;

	OSALoggerRFC.OSALogger -> OSALoggerC;
	OSALoggerRFC.RealTimer -> PlatformRealTimerC;
}

