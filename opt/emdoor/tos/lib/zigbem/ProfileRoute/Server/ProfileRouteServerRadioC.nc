#include "ProfileRoute.h"

configuration ProfileRouteServerRadioC
{
	provides interface ProfileRouteServerRadio;
}
implementation
{
	components ProfileRouteServerRadioP;
	components ActiveMessageC;

	ProfileRouteServerRadio = ProfileRouteServerRadioP;

	components new ActiveMessageResourceC() as AckPingSendC;
	components new AMReceiverC(PING_BASESTATION_TYPE) as PingStationReceiverC;
	components new ActiveMessageResourceC() as RouteInfoSendC;
	components new AMReceiverC(ACK_ROUTE_UPDATE_TYPE) as AckUpdateReceiverC;

	ProfileRouteServerRadioP.AckPingSend -> AckPingSendC.AMSend[ACK_PING_TYPE];
	ProfileRouteServerRadioP.RouteInfoSend -> RouteInfoSendC.AMSend[ROUTE_UPDATE_TYPE];
	ProfileRouteServerRadioP.PingReceive -> PingStationReceiverC.Receive;
	ProfileRouteServerRadioP.AckRouteReceive -> AckUpdateReceiverC.Receive;
	ProfileRouteServerRadioP.Packet -> ActiveMessageC;
	ProfileRouteServerRadioP.AMPacket -> ActiveMessageC;
}
	
