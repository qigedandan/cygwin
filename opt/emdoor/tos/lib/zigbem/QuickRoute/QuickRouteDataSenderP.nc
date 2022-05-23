#include "QuickRoute.h"

module QuickRouteDataSenderP
{
	provides {
		interface Send;
	}

	uses {
		interface Send as SubSend;

		interface Packet;
		interface AMPacket;
		interface CC2420Packet;

		interface QuickRouteEngine;
	}
}
implementation
{
	/*=== Send ===*/
	command error_t Send.send(message_t* msg, uint8_t len)
	{
		ADBG(100, "QuickRouteDataSenderP. Send.send \n");

		call QuickRouteEngine.initializeFields(msg);
		call AMPacket.setType(msg, AM_QUICK_ROUTE_DATA_MSG);
		call Packet.setPayloadLength(msg, len+sizeof(quickroute_data_header_t));
		
		return call SubSend.send(msg, call Packet.payloadLength(msg));
	}
	
	command error_t Send.cancel(message_t* msg)
	{
		return SUCCESS;
	}

	command uint8_t Send.maxPayloadLength()
	{
		return call SubSend.maxPayloadLength() - sizeof(quickroute_data_header_t);
	}

	command void *Send.getPayload(message_t* msg)
	{
		return ((uint8_t *)call Packet.getPayload(msg, NULL)) + sizeof(quickroute_data_header_t);
	}

	default event void Send.sendDone(message_t* msg, error_t error) {}

	/*============*/
	event void SubSend.sendDone(message_t* msg, error_t error)
	{
		signal Send.sendDone(msg, error);
	}
}	


