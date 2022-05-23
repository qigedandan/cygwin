#include "ProfileRoute.h"
interface ProfileRouteClientRadio
{
	command error_t pingStation(profile_route_info_t* routeInfo);
	command error_t ackRouteUpdate(profile_route_info_t* routeInfo);
	event void pingStationDone(error_t result);
	event void routeUpdate(profile_route_info_t* routeInfo);
}	

