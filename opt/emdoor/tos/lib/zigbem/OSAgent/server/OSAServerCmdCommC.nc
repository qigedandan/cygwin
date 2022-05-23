

configuration OSAServerCmdCommC
{
	provides interface StdControl;
	provides interface OSAServerCmdComm;
}
implementation
{
	components OSAServerCmdCommP;
	components PlatformSerialC;
	components OSAServerCmdPacketC;

	StdControl = OSAServerCmdCommP;
	OSAServerCmdComm = OSAServerCmdCommP;

	OSAServerCmdCommP.UartStdControl -> PlatformSerialC;
	OSAServerCmdCommP.UartStream -> PlatformSerialC;
	OSAServerCmdCommP.OSAServerCmdPacket -> OSAServerCmdPacketC;
}

