
configuration AtpCmdPacketC
{
	provides interface AtpCmdPacket;
}
implementation
{
	components AtpCmdPacketP;
	AtpCmdPacket = AtpCmdPacketP;
}

