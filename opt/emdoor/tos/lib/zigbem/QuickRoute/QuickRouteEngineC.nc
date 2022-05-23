#include "QuickRoute.h"

configuration QuickRouteEngineC
{
	provides {
		interface RootControl;
		interface QuickRouteEngine;
		interface QuickRouteEngineEvent;
	}
}
implementation
{
	components QuickRouteEngineP;

	RootControl = QuickRouteEngineP;
	QuickRouteEngine = QuickRouteEngineP;
	QuickRouteEngineEvent = QuickRouteEngineP;

	components MainC;
	MainC.SoftwareInit -> QuickRouteEngineP;
	
	components new ActiveMessageResourceC() as RouteBeaconSendC;
	QuickRouteEngineP.RouteBeaconSend -> RouteBeaconSendC.AMSend[AM_QUICK_ROUTE_BEACON_MSG];
	components new AMReceiverC(AM_QUICK_ROUTE_BEACON_MSG) as RouteBeaconReceiveC;
	QuickRouteEngineP.RouteBeaconReceive -> RouteBeaconReceiveC;

	components new ActiveMessageResourceC() as RouteRequestSendC;
	QuickRouteEngineP.RouteRequestSend -> RouteRequestSendC.AMSend[AM_QUICK_ROUTE_REQUEST_MSG];
	components new AMReceiverC(AM_QUICK_ROUTE_REQUEST_MSG) as RouteRequestReceiveC;
	QuickRouteEngineP.RouteRequestReceive -> RouteRequestReceiveC;

	components ActiveMessageC;
	QuickRouteEngineP.Packet -> ActiveMessageC;
	QuickRouteEngineP.AMPacket -> ActiveMessageC;

	components QuickRouteRadioC;
	QuickRouteEngineP.DataPacket -> QuickRouteRadioC;

	components CC2420PacketC;
	QuickRouteEngineP.CC2420Packet -> CC2420PacketC;

	components new TimerMilliC();
	QuickRouteEngineP.RouteUpdateTimeout -> TimerMilliC;

	components new TimerMilliC() as TimerAutoUpdateC;
	QuickRouteEngineP.RouteAutoUpdateTimer -> TimerAutoUpdateC;

	components RandomLfsrC as RandomC;
	QuickRouteEngineP.Random -> RandomC;
}

	
