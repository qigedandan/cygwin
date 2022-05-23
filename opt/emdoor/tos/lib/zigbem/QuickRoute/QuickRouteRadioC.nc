
configuration QuickRouteRadioC
{
	provides interface AMSend as AMSendData;
	provides interface Receive as ReceiveData;

	provides interface AMSend as AMSendForward;
	provides interface Receive as ReceiveForward;

	provides interface Packet;
}
implementation
{
	components new SafeRadioC(AM_QUICK_ROUTE_DATA_MSG, AM_QUICK_ROUTE_DATA_MSG+1) as SafeRadioDataC;
	AMSendData = SafeRadioDataC;
	ReceiveData = SafeRadioDataC;

	Packet = SafeRadioDataC;

	components new SafeRadioC(AM_QUICK_ROUTE_DATA_FORWARD_MSG, AM_QUICK_ROUTE_DATA_FORWARD_MSG+1) as SafeRadioForwardC;
	AMSendForward = SafeRadioForwardC;
	ReceiveForward = SafeRadioForwardC;

	
}

