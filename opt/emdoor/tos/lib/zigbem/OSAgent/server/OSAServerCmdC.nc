

configuration OSAServerCmdC
{
	provides interface StdControl;
	provides interface OSAServerCmd;
}
implementation
{
	components OSAServerCmdP;
	components OSAServerCmdCommC;

	StdControl = OSAServerCmdP;
	OSAServerCmd = OSAServerCmdP;

	OSAServerCmdP.OSAServerCmdCommControl -> OSAServerCmdCommC;
	OSAServerCmdP.OSAServerCmdComm -> OSAServerCmdCommC;
}

