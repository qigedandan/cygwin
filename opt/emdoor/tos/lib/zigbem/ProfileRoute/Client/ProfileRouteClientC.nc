
configuration ProfileRouteClientC
{
	provides interface ProfileRouteClientControl;
}
implementation
{
	components ProfileRouteClientP;
	components new TimerMilliC();
	components ProfileRouteFlashC;
	components ProfileRouteClientRadioC;

	ProfileRouteClientControl = ProfileRouteClientP;

	ProfileRouteClientP.ProfileRouteClientRadio -> ProfileRouteClientRadioC;
	ProfileRouteClientP.ProfileRouteFlash -> ProfileRouteFlashC;
	ProfileRouteClientP.Timer -> TimerMilliC;
}

