#include "StaticMultiHopRoute.h"
generic module RoutingEngineP(uint8_t network_size)
{
	provides {
		interface Init;
		interface StdControl;
		interface RouteSelect;
		interface RootControl;
	}
	uses {
		interface Packet;
		interface AMPacket;
	}
}
implementation
{
	uint16_t currentParent;
	
	bool isRoot = FALSE;
	uint8_t i_index, j_index, current_i_index, current_j_index;

	enum {
		ROUTE_INVALID = 0xff,
		BASE_STATION = 1,
	};
	
	uint16_t routeTable[network_size][network_size];

	void InitializeRouteTable()
	{
		uint8_t i, j;
		for( i = 0; i < network_size; i++)
		{
			for( j = 0; j < network_size; j++)
			{
				routeTable[i][j] = network_size*i + j +2;
			}
		}
	}	

	task void findIndex()
	{
		uint8_t i, j;
		bool found = FALSE;
		for(i=0; i<network_size && !found; i++)
		{
			i_index = i;
			for(j = 0; j < network_size && !found; j++)
			{
				j_index = j;
				if(call AMPacket.address() == routeTable[i][j])
				{
					found = TRUE;
				}
			}
		}
	}

	void selectParent(bool resend)
	{

		if(i_index <=0 )
		{
			currentParent = BASE_STATION;
		}
		else
		{
			if(resend == 0)
			{
				current_i_index = i_index;
				current_j_index = j_index;
				currentParent = routeTable[i_index -1][j_index];
			}
			else {
			       if(currentParent != BASE_STATION) {
					current_j_index = (current_j_index+1)%network_size;
				}
				if(current_j_index == j_index)
				{
					if(currentParent != BASE_STATION) {
						currentParent = BASE_STATION;
					}else {
						currentParent = routeTable[i_index -1][j_index];
					}
				}
				else
				{					
					currentParent = routeTable[current_i_index-1][current_j_index];
				}
			}				
		}
	}

	command error_t Init.init()
	{
		currentParent = ROUTE_INVALID;
		InitializeRouteTable();
		post findIndex();
		return SUCCESS;
	}

	command error_t StdControl.start()
	{
		if(!isRoot)
		{
			selectParent(FALSE);
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
		return TRUE;
	}

	command error_t RouteSelect.selectRoute(message_t* msg, uint8_t resend)
	{
		if(resend || (currentParent == ROUTE_INVALID) )
		{
			selectParent(resend);
		}

		call AMPacket.setDestination(msg, currentParent);
	}

	command error_t RouteSelect.initializeFields(message_t* msg)
	{
		static_multihop_route_header_t* header = (static_multihop_route_header_t*) call Packet.getPayload(msg, NULL);

		header-> originaddr = call AMPacket.address();

		return SUCCESS;
	}

	command uint8_t* RouteSelect.getBuffer(message_t* msg, uint16_t* len)
	{
	}
}

