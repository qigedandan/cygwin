

generic configuration OSALoggerC(int32_t size)
{
	provides interface OSALogger;
}
implementation
{
	components new OSALoggerP(size);
	OSALogger = OSALoggerP;
}

