
configuration ProfileRouteServerC
{
	provides interface ProfileRouteServerControl;
}
implementation
{
	components ProfileRouteServerP;
	components ProfileRouteServerRadioC;
	components ProfileRouteServerCmdC;

	ProfileRouteServerControl = ProfileRouteServerP;

	ProfileRouteServerP.ProfileRouteServerCmd -> ProfileRouteServerCmdC;
	ProfileRouteServerP.ProfileRouteServerRadio -> ProfileRouteServerRadioC;
	ProfileRouteServerP.CmdCommControl -> ProfileRouteServerCmdC;
}

