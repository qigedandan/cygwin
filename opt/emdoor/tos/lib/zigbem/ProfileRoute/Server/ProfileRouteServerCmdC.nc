
configuration ProfileRouteServerCmdC {

	provides interface StdControl as CmdCommControl;
	provides interface ProfileRouteServerCmd;
}

implementation {

	components ProfileRouteServerCmdP,AtpCmdCommC;

	CmdCommControl = AtpCmdCommC.StdControl;
	ProfileRouteServerCmd = ProfileRouteServerCmdP;

	ProfileRouteServerCmdP.AtpCmdComm -> AtpCmdCommC.AtpCmdComm;

}
