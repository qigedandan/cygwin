
configuration ProfileRouteFlashC
{
	provides interface ProfileRouteFlash;
}
implementation
{
	components ProfileRouteFlashP;
	components HalFlashC;

	ProfileRouteFlash = ProfileRouteFlashP;

	ProfileRouteFlashP.HalFlash -> HalFlashC;
}

