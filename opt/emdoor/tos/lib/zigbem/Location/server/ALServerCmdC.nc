

configuration ALServerCmdC
{
	provides interface StdControl;
	provides interface ALServerCmd;
}
implementation
{
	components ALServerCmdP;
	components ALServerCmdCommC;

	StdControl = ALServerCmdP;
	ALServerCmd = ALServerCmdP;

	ALServerCmdP.ALServerCmdCommControl -> ALServerCmdCommC;
	ALServerCmdP.ALServerCmdComm -> ALServerCmdCommC;
}

