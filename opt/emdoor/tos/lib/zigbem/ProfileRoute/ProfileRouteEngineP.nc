#include "ProfileRoute.h"

module ProfileRouteEngineP
{
	provides {
		interface Init;
		interface StdControl;
		interface RouteSelect;
		interface RootControl;
	}
	uses {
		interface ProfileRouteFlash;
		interface ProfileRouteClientControl;
		interface AMPacket;
		interface Packet;
	}
}
implementation
{
	profile_route_info_t routeTable;
	uint16_t currentParent;
	uint8_t currentIndex;
	uint8_t firstIndex;
	bool all_route_fail = FALSE;
	bool isRoot = FALSE;

	enum {
		ROUTE_INVALID = 0xff
	};

	uint8_t i;

	error_t findNextHop(uint16_t* nextHop, uint8_t resend)
	{
		if(resend ==0) 
		{
			//firstIndex = currentIndex;
			currentIndex = firstIndex;
			if(routeTable.len!=0)
			{				
				*nextHop = routeTable.addr[firstIndex];
				return SUCCESS;
			}else{
				return FAIL;
			}
		}else{ 
			if(all_route_fail == TRUE) // if all routes are unreachable, then return FAIL
			{
				return FAIL;
			}
			currentIndex = (currentIndex+1) % routeTable.len;
			if (currentIndex == firstIndex)
			{
				all_route_fail = TRUE;
				return FAIL;
			}
			else
			{
				*nextHop = routeTable.addr[currentIndex];
				return SUCCESS;
			}
		}
	}			

	command error_t Init.init()
	{
		call ProfileRouteFlash.Read(&routeTable);
		currentParent = ROUTE_INVALID;
		firstIndex = 0;
		return SUCCESS;
	}

	command error_t StdControl.start()
	{
		if(!isRoot)
		{
			ADBG(1000, "I am not Root!startConfig...\r\n");
			return call ProfileRouteClientControl.startConfig();
		}
		
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{		
	}

	command error_t RootControl.setRoot()
	{
		isRoot = TRUE;
		return SUCCESS;		
	}

	command error_t RootControl.unsetRoot()
	{
		isRoot = FALSE;
		return SUCCESS;
	}

	command bool RootControl.isRoot()
	{
		return isRoot;
	}

	command bool RouteSelect.isActive()
	{
		return routeTable.len;
	}

	command error_t RouteSelect.selectRoute(message_t* msg, uint8_t resend)
	{
		if(findNextHop(&currentParent, resend) == SUCCESS) {			
			call AMPacket.setDestination(msg, currentParent);
		}else{
			call AMPacket.setDestination(msg, 0xffff);
		}
		
		return SUCCESS;
	}

	command error_t RouteSelect.initializeFields(message_t* msg)
	{
		profile_route_header_t* header = (profile_route_header_t*) call Packet.getPayload(msg, NULL);

		header->originaddr = call AMPacket.address();

		return SUCCESS;
	}

	command uint8_t* RouteSelect.getBuffer(message_t* Msg, uint16_t* len) {
	}

	event void ProfileRouteClientControl.routeUpdate() 
	{
		uint8_t i;
		call ProfileRouteFlash.Read(&routeTable);
		ADBG(1000, "\r\nReceived routeInfo from server\r\n routeTableLength = %d\r\n", (int)routeTable.len);
		for(i=0; i < routeTable.len; i++)
		{
			ADBG(1000, "the %d th nextHop is:%d\r\n", (int)(i+1), (int)routeTable.addr[i]);
		}
		currentParent = ROUTE_INVALID;
		firstIndex = 0;
	}

	event void ProfileRouteClientControl.configEnd()
	{
	}
}
	
	
