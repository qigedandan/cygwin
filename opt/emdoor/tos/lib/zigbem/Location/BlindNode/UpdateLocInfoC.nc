
configuration UpdateLocInfoC
{
	provides interface UpdateLocInfo;
	provides interface SplitControl as RFControl;
}
implementation
{    
	components LocPacketC,UpdateLocInfoP;

	RFControl = LocPacketC.RFControl;
	UpdateLocInfo = UpdateLocInfoP;
	UpdateLocInfoP.LocPacket -> LocPacketC;
}
