#include "ProfileRoute.h"
configuration ProfileRouteClientRadioC
{
	provides interface ProfileRouteClientRadio;
}
implementation
{
	components ProfileRouteClientRadioP;
	components ActiveMessageC;

	ProfileRouteClientRadio = ProfileRouteClientRadioP;

	components new ActiveMessageResourceC() as PingSendC;
	components new AMReceiverC(ACK_PING_TYPE) as AckPingReceiverC;
	components new ActiveMessageResourceC() as AckUpdateSendC;
	components new AMReceiverC(ROUTE_UPDATE_TYPE) as RouteUpdateReceiverC;

	ProfileRouteClientRadioP.PingSend -> PingSendC.AMSend[PING_BASESTATION_TYPE];
	ProfileRouteClientRadioP.AckUpdateSend ->  AckUpdateSendC.AMSend[ACK_ROUTE_UPDATE_TYPE];
	ProfileRouteClientRadioP.PingStationDoneReceive -> AckPingReceiverC.Receive;
	ProfileRouteClientRadioP.RouteUpdateReceive -> RouteUpdateReceiverC.Receive;
	ProfileRouteClientRadioP.Packet -> ActiveMessageC;
}

	