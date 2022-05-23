
configuration OSAServerCmdPacketC
{
	provides interface OSAServerCmdPacket;
}
implementation
{
	components OSAServerCmdPacketP;
	OSAServerCmdPacket = OSAServerCmdPacketP;
}

