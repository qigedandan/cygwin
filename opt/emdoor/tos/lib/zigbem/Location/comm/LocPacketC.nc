
configuration LocPacketC
{
	provides interface LocPacket;
	provides interface SplitControl as RFControl;
}
implementation
{
	components LocPacketP;
	
	LocPacket = LocPacketP.LocPacket;
	
	components ActiveMessageC;	
	RFControl  = ActiveMessageC.SplitControl;

	//LocPacketP.Send	-> ActiveMessageC.AMSend[110];
	//LocPacketP.Receive	-> ActiveMessageC.Receive[110];

	
	components new ActiveMessageResourceC();
	LocPacketP.Send	-> ActiveMessageResourceC.AMSend[110];

	components new AMReceiverC(110);
	LocPacketP.Receive	-> AMReceiverC;

	components CC2420PacketC;
	LocPacketP.CC2420PacketBody -> CC2420PacketC;
	LocPacketP.Packet -> ActiveMessageC;
	
}
