configuration QuickRouteDataSenderC
{
	provides interface Send;
}
implementation
{
	components QuickRouteDataSenderP;
	components new QuickRouteSenderC(AM_QUICK_ROUTE_DATA_MSG);

	Send = QuickRouteDataSenderP;

	components QuickRouteRadioC;
	QuickRouteSenderC.AMSend -> QuickRouteRadioC.AMSendData;
	
	QuickRouteDataSenderP.Packet -> QuickRouteRadioC;
	QuickRouteDataSenderP.SubSend -> QuickRouteSenderC;

	components ActiveMessageC;
	QuickRouteDataSenderP.AMPacket -> ActiveMessageC;

	components CC2420PacketC;
	QuickRouteDataSenderP.CC2420Packet -> CC2420PacketC;

	components QuickRouteEngineC;
	QuickRouteDataSenderP.QuickRouteEngine -> QuickRouteEngineC;
}

	
