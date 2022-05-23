
configuration OSAMainC
{
	provides interface Boot;
	provides interface OSAMain;
	provides interface OSAMainControl;

	uses interface Init as PlatformInit;
	uses interface Init as SoftwareInit;
}
implementation
{
	components OSAMainP;
	Boot = OSAMainP;
	OSAMain = OSAMainP;
	OSAMainControl = OSAMainP;
	SoftwareInit = OSAMainP.SoftwareInit;
	PlatformInit = OSAMainP.PlatformInit;

	components TinySchedulerC;
	OSAMainP.Scheduler -> TinySchedulerC;

	components PlatformRealTimerC;
	OSAMainP.RealTimer -> PlatformRealTimerC;


	components OSAClientCoreC;
	OSAClientCoreC.OSAMain -> OSAMainP;
	OSAClientCoreC.OSAMainControl -> OSAMainP;

}

