#include "RssiLocation.h"
configuration StationNodeC
{
	provides interface StdControl;
}
implementation
{
	components MainC, StationNodeP;
	components ActiveMessageC;
	components new TimerMilliC() as UpdateTimer;
	components new AMReceiverC(AM_LOCATION_BROADCAST_MSG);
	components CC2420PacketC;
	components QuickRouteC;

	StdControl = StationNodeP;

	MainC.SoftwareInit -> StationNodeP;

	StationNodeP.Receive -> AMReceiverC;
	StationNodeP.Send -> QuickRouteC;
	StationNodeP.AMPacket -> ActiveMessageC;
	StationNodeP.Timer -> UpdateTimer;
	StationNodeP.CC2420Packet -> CC2420PacketC;

	components UartDebugControlC;
	StationNodeP.UartDebugControl -> UartDebugControlC; 

	components QuickRouteEngineC;
	StationNodeP.QuickRouteEngine -> QuickRouteEngineC;
}

