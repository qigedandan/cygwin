
configuration OSAClientCoreC
{
	uses interface OSAMain;
	uses interface OSAMainControl;
}
implementation
{
	components OSAClientCoreP;
	OSAMain = OSAClientCoreP;
	OSAMainControl = OSAClientCoreP;

	components MainC;
	MainC.SoftwareInit -> OSAClientCoreP;
	OSAClientCoreP.Boot -> MainC.Boot;

	/* OSAgent Communication */
	components OSACommClientC;
	OSAClientCoreP.OSACommClientControl -> OSACommClientC;
	OSAClientCoreP.OSACommClient -> OSACommClientC;


	/* User App Control */
	components OSAUsrAppC;
	OSAClientCoreP.OSAUsrApp -> OSAUsrAppC;
	

	/* Logger Control */
	components PlatformLoggerC;
	OSAClientCoreP.OSALogger -> PlatformLoggerC;


	/*  */
	components ActiveMessageAddressC;
	OSAClientCoreP.ActiveMessageAddress -> ActiveMessageAddressC;


	/* RealTimer Control */
	components OSARealTimerC;
	components PlatformRealTimerC;
	
	OSAClientCoreP.RealTimerOSA -> OSARealTimerC;
	OSAClientCoreP.RealTimerUser -> PlatformRealTimerC;


	/* User mode run time control */
	components new TimerMilliC();
	OSAClientCoreP.OSARunControlTimer -> TimerMilliC;


	/* WatchDog control */
	components WatchDogC;
	OSAClientCoreP.WatchDog -> WatchDogC;
	
}

