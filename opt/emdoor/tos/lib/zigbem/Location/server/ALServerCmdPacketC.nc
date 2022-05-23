
configuration ALServerCmdPacketC
{
	provides interface ALServerCmdPacket;
}
implementation
{
	components ALServerCmdPacketP;
	ALServerCmdPacket = ALServerCmdPacketP;
}

