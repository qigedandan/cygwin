#include "ProfileRoute.h"

configuration ProfileRouteC
{
	provides {
		interface StdControl;
		interface RouteSelect;
		interface RootControl;
		interface Send;
		interface Receive;		
		interface Intercept;
		interface Packet;
		interface ProfileRouteInfo;
	}
}
implementation
{
	components ProfileRouteEngineP;
	components new ProfileForwardEngineP(4);
	components MainC;
	components ActiveMessageC;
	components ProfileRouteFlashC;
	components ProfileRouteClientC;
	components new ActiveMessageResourceC() as SendMineC;
	components new AMReceiverC(MINE_DATA_TYPE) as MineReceiveC;
	components new ActiveMessageResourceC() as ForwardC;
	components new AMReceiverC(FORWARD_DATA_TYPE) as ForwardReceiveC;

	StdControl = ProfileRouteEngineP;
	RouteSelect = ProfileRouteEngineP;
	RootControl = ProfileRouteEngineP;

	Send = ProfileForwardEngineP;
	Receive = ProfileForwardEngineP.Receive;	
	Intercept = ProfileForwardEngineP.Intercept;
	Packet = ProfileForwardEngineP;
	ProfileRouteInfo = ProfileForwardEngineP;

	MainC.SoftwareInit -> ProfileRouteEngineP;

	ProfileRouteEngineP.ProfileRouteFlash -> ProfileRouteFlashC;
	ProfileRouteEngineP.Packet -> ActiveMessageC;
	ProfileRouteEngineP.AMPacket -> ActiveMessageC;
	ProfileRouteEngineP.ProfileRouteClientControl -> ProfileRouteClientC;	


	ProfileForwardEngineP.AMSend -> ForwardC.AMSend[FORWARD_DATA_TYPE];
	ProfileForwardEngineP.SubReceive -> ForwardReceiveC.Receive;
	ProfileForwardEngineP.SendMine -> SendMineC.AMSend[MINE_DATA_TYPE];
	ProfileForwardEngineP.ReceiveMine -> MineReceiveC.Receive;
	ProfileForwardEngineP.SubPacket -> ActiveMessageC;
	ProfileForwardEngineP.AMPacket -> ActiveMessageC;
	ProfileForwardEngineP.RouteSelect -> ProfileRouteEngineP;
	ProfileForwardEngineP.RootControl -> ProfileRouteEngineP;
	ProfileForwardEngineP.PacketAcknowledgements -> ActiveMessageC;
	
}

