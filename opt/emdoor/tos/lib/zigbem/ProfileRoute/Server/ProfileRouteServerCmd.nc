#include "ProfileRoute.h"

interface ProfileRouteServerCmd
{
	event void ping();
	event void setRouteInfo(profile_route_info_t *routeInfo);

	command error_t pingAck();
	command error_t updateRouteInfo(profile_route_info_t *routeInfo);
	command error_t pingRouteInfo(profile_route_info_t* routeInfo);
}

