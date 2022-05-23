#include "RssiLocation.h"

configuration ServerNodeC
{
	provides interface StdControl;
}
implementation
{
	components ServerNodeP, ActiveMessageC;
	components AtpCmdCommC;
	components QuickRouteC;
	//	components new AMReceiverC(AM_LOCATION_INFO_UPLOAD_MSG);
	
	StdControl = ServerNodeP;

	ServerNodeP.Send -> QuickRouteC;
	ServerNodeP.Intercept -> QuickRouteC;
	ServerNodeP.RootControl -> QuickRouteC;
	
	ServerNodeP.AMPacket -> ActiveMessageC;
	ServerNodeP.Packet -> ActiveMessageC;

	ServerNodeP.AtpCmdCommControl -> AtpCmdCommC.StdControl;
	ServerNodeP.AtpCmdComm -> AtpCmdCommC.AtpCmdComm;
}
	
