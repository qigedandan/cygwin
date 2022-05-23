

configuration ALServerCmdCommC
{
	provides interface StdControl;
	provides interface ALServerCmdComm;
}
implementation
{
	components ALServerCmdCommP;
	components PlatformSerialC;
	components ALServerCmdPacketC;

	StdControl = ALServerCmdCommP;
	ALServerCmdComm = ALServerCmdCommP;

	ALServerCmdCommP.UartStdControl -> PlatformSerialC;
	ALServerCmdCommP.UartStream -> PlatformSerialC;
	ALServerCmdCommP.ALServerCmdPacket -> ALServerCmdPacketC;
}

