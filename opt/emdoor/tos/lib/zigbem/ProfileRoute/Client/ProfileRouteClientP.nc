
module ProfileRouteClientP
{
	provides interface ProfileRouteClientControl;
	uses {
		interface ProfileRouteClientRadio;
		interface ProfileRouteFlash;
		interface Timer<TMilli>;
	}
}
implementation
{
	profile_route_info_t routeInfo;
	uint8_t ping_tries = 0;

	enum
	{
		PING_STATION_MAX_TRIES = 3,
		PING_STATION_TIMEOUT = 3000,
	};
	
	command error_t ProfileRouteClientControl.startConfig()
	{
		call ProfileRouteFlash.Read(&routeInfo);
		if(call ProfileRouteClientRadio.pingStation(&routeInfo) == SUCCESS)
		{
			ping_tries ++;
			call Timer.startOneShot(PING_STATION_TIMEOUT);
			return SUCCESS;
		}

		return FAIL;
	}

	event void Timer.fired()
	{
		error_t result;
		if(ping_tries <PING_STATION_MAX_TRIES) {
		
			result = call ProfileRouteClientRadio.pingStation(&routeInfo); 
		
			if(result== SUCCESS)
			{
				ping_tries ++;
			}
			call Timer.startOneShot(PING_STATION_TIMEOUT);
		}else{
			signal ProfileRouteClientControl.configEnd();
		}
	}

	event void ProfileRouteClientRadio.pingStationDone(error_t result)
	{
		ADBG(1000,"Received pingAck from BaseStation\r\n");
		if(result == SUCCESS)
		{
			call Timer.stop();
		}
	}

	task void ackRouteInfoTask()
	{
		call ProfileRouteFlash.Read(&routeInfo);
		call ProfileRouteClientRadio.ackRouteUpdate(&routeInfo);
	}

	event void ProfileRouteClientRadio.routeUpdate(profile_route_info_t* ConfigRouteInfo)
	{
		memcpy(&routeInfo, ConfigRouteInfo, sizeof(profile_route_info_t));
		call ProfileRouteFlash.Write(&routeInfo);
		signal ProfileRouteClientControl.routeUpdate();
		post ackRouteInfoTask();
	}
}
	
	
