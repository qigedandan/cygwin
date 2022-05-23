#include "QuickRoute.h"

module QuickRouteP
{
	provides interface StdControl;
	provides interface Intercept;

	uses interface Receive as ReceiveData;
	uses interface Receive as ReceiveDataForward;
	uses interface QuickRouteForward;
	uses interface RootControl;
}

implementation
{
	command error_t StdControl.start()
	{
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{
		return SUCCESS;
	}


	event message_t* ReceiveData.receive(message_t* msg, void* payload, uint8_t len)
	{
		if (signal Intercept.forward(msg,(uint8_t *)payload+sizeof(quickroute_data_header_t), len-sizeof(quickroute_data_header_t)))
		{
			call QuickRouteForward.forward(msg);
		}
		
		return msg;
	}

	event message_t* ReceiveDataForward.receive(message_t* msg, void* payload, uint8_t len)
	{
		/* may be bug when the payload len less than sizeof(quickroute_data_header_t) */
		if (signal Intercept.forward(msg, (uint8_t *)payload+sizeof(quickroute_data_header_t), len-sizeof(quickroute_data_header_t)))
		{
			call QuickRouteForward.forward(msg);
		}
		
		return msg;
	}

	default event bool Intercept.forward(message_t* msg, void* payload, uint16_t len)
	{
		return (!call RootControl.isRoot());
	}
}
	
	
