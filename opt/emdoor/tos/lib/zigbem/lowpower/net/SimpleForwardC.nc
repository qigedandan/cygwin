
generic configuration SimpleForwardC(uint8_t SIZE)
{
	provides interface SimpleForward;
	provides interface Intercept;
	provides interface CoreControl;
}
implementation
{
	components new SimpleForwardP(SIZE);
	SimpleForward = SimpleForwardP;
	Intercept = SimpleForwardP;

	components new CoreControlC();
	CoreControl = CoreControlC;
	SimpleForwardP.CoreControlOwner -> CoreControlC;

	components ActiveMessageC;
	SimpleForwardP.AMPacket -> ActiveMessageC;
	SimpleForwardP.Packet -> ActiveMessageC;
	
	//components new AMSenderC(113);
	//SimpleForwardP.AMSend -> AMSenderC;

	components new ActiveMessageResourceC();
	SimpleForwardP.AMSend -> ActiveMessageResourceC.AMSend[113];

	components new AMReceiverC(113);
	SimpleForwardP.Receive -> AMReceiverC;
}

