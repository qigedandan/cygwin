
interface ProfileRouteClientControl
{
	command error_t startConfig();
	event void routeUpdate();
	event void configEnd();
}

