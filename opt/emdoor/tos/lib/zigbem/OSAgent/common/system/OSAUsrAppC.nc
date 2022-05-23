
configuration OSAUsrAppC
{
	provides interface OSAUsrApp;
}
implementation
{
	components OSAUsrAppP;
	components PlatformInterruptC;

	OSAUsrApp = OSAUsrAppP;

	OSAUsrAppP.PlatformInterrupt -> PlatformInterruptC;
}

