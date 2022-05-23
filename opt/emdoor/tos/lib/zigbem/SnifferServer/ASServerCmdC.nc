

configuration ASServerCmdC
{
	provides interface StdControl as ASServerControl;
	provides interface ASServerCmd;
}
implementation
{
	components ASServerCmdP;
	components AtpCmdCommC;

	ASServerControl = ASServerCmdP;
	ASServerCmd = ASServerCmdP;

	ASServerCmdP.AtpCmdCommControl -> AtpCmdCommC.StdControl;
	ASServerCmdP.AtpCmdComm -> AtpCmdCommC.AtpCmdComm;
}

