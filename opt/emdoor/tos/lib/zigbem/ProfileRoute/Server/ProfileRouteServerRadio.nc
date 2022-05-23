#include "ProfileRoute.h"
interface ProfileRouteServerRadio
{
	command error_t ackPing(uint16_t nodeId);
	command error_t sendRoute(profile_route_info_t* routeInfo);
	event void ping(profile_route_info_t* routeInfo, uint16_t nodeId);
	event void routeUpdateAcked(profile_route_info_t* routeInfo);
}

