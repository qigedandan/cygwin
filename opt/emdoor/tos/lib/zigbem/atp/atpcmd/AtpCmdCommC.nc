

configuration AtpCmdCommC
{
	provides interface StdControl;
	provides interface AtpCmdComm;
}
implementation
{
	components AtpCmdCommP;
	components new AtpUartC(2*1024);
	components AtpCmdPacketC;

	StdControl = AtpCmdCommP;
	AtpCmdComm = AtpCmdCommP;

	AtpCmdCommP.AtpUartStdControl -> AtpUartC;
	AtpCmdCommP.AtpUart -> AtpUartC;
	AtpCmdCommP.AtpCmdPacket -> AtpCmdPacketC;
}

