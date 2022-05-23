#include "ProfileRoute.h"

module ProfileRouteServerP
{
	provides interface ProfileRouteServerControl;

	uses {
		interface ProfileRouteServerCmd;
		interface ProfileRouteServerRadio;
		interface StdControl as CmdCommControl;
	}
}

implementation
{
	
	profile_route_info_t profileRouteInfo;
	
	command error_t ProfileRouteServerControl.start()
	{
		return call CmdCommControl.start();
	}
	
	event void ProfileRouteServerCmd.ping()
	{			
		call ProfileRouteServerCmd.pingAck();		
	}

	event void ProfileRouteServerCmd.setRouteInfo(profile_route_info_t* routeInfo)
	{			
		memcpy(&profileRouteInfo, routeInfo, sizeof(profile_route_info_t));
		call ProfileRouteServerRadio.sendRoute(&profileRouteInfo);	
	}

	event void ProfileRouteServerRadio.routeUpdateAcked(profile_route_info_t* routeInfo)
	{
		
		memcpy(&profileRouteInfo, routeInfo, sizeof(profile_route_info_t));
		call ProfileRouteServerCmd.updateRouteInfo(&profileRouteInfo);
		
	}

	event void ProfileRouteServerRadio.ping(profile_route_info_t* routeInfo, uint16_t nodeId)
	{
		ADBG(5,"\r\nPing......\r\n the client node is: %d\r\n", (int)nodeId);

		memcpy(&profileRouteInfo, routeInfo, sizeof(profile_route_info_t));

		call ProfileRouteServerCmd.updateRouteInfo(&profileRouteInfo);		
		call ProfileRouteServerRadio.ackPing(nodeId);
	}
		
}
	
	
