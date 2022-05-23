#include "ProfileRoute.h"

interface ProfileRouteFlash
{
	command void Write(profile_route_info_t* route_info);

	command void Read(profile_route_info_t* route_info);
}

