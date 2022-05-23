#include "ProfileRoute.h"

module ProfileRouteFlashP
{
	provides interface ProfileRouteFlash;
	uses interface HalFlash;
}
implementation
{
	#define PROFILE_ROUTE_INFO_ADDR  0x1e000

	command void ProfileRouteFlash.Write(profile_route_info_t* route_info)
	{
		call HalFlash.erase((uint8_t*)PROFILE_ROUTE_INFO_ADDR);
		call HalFlash.write((uint8_t*)PROFILE_ROUTE_INFO_ADDR, (uint8_t*)route_info, sizeof(profile_route_info_t));
	}

	command void ProfileRouteFlash.Read(profile_route_info_t* route_info)
	{
		call HalFlash.read( route_info, (uint8_t*)PROFILE_ROUTE_INFO_ADDR, sizeof(profile_route_info_t));

		route_info->len = route_info->len % PROFILEROUTE_MAX;
	}
}

