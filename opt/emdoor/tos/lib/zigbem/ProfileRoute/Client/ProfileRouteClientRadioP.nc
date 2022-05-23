#include "ProfileRoute.h"
#include "message.h"

module ProfileRouteClientRadioP
{
	provides interface ProfileRouteClientRadio;
	uses {
		interface AMSend as PingSend;
		interface AMSend as AckUpdateSend;
		interface Receive as PingStationDoneReceive;
		interface Receive as RouteUpdateReceive;
		interface Packet;
	}
}
implementation
{	
	message_t  msg;
	command error_t ProfileRouteClientRadio.pingStation(profile_route_info_t* routeInfo)
	{
		uint8_t* payload = (uint8_t*)call Packet.getPayload(&msg, NULL);
		memcpy(payload, routeInfo, sizeof(profile_route_info_t));

		ADBG(2, "\r\nSend ping station packet....\r\n");
		return call PingSend.send(PROFILEROUTE_SERVER_ADDR, &msg, sizeof(profile_route_info_t));
	}

	event void PingSend.sendDone(message_t* msg, error_t err)
	{
	}

	event  message_t* PingStationDoneReceive.receive(message_t* msg, void* payload, uint8_t len)
	{
		ack_ping_packet_t* packet = (ack_ping_packet_t*)payload;

		ADBG(2,"received pingAck msg from Station!\r\n len=%d, cmd = %d",(int)len, (int)packet->cmd);
		
		if(len == sizeof(ack_ping_packet_t) && packet->cmd == ACK_PING_CMD)
		{
			signal ProfileRouteClientRadio.pingStationDone(SUCCESS);
		}else{
			signal ProfileRouteClientRadio.pingStationDone(FAIL);
		}
		return msg;
	}

	event message_t*  RouteUpdateReceive.receive(message_t* msg, void* payload, uint8_t len)
	{
		
		profile_route_info_t routeInfo;
		memcpy(&routeInfo, payload, sizeof(profile_route_info_t));
		signal ProfileRouteClientRadio.routeUpdate(&routeInfo);

		return msg;
	}

	command error_t ProfileRouteClientRadio.ackRouteUpdate(profile_route_info_t* routeInfo)
	{
		
		uint8_t* payload = (uint8_t*)call Packet.getPayload(&msg, NULL);
		memcpy(payload, routeInfo, sizeof(profile_route_info_t));

		return call AckUpdateSend.send(PROFILEROUTE_SERVER_ADDR,  &msg, sizeof(profile_route_info_t));
	}

	event void AckUpdateSend.sendDone(message_t* msg, error_t err)
	{
	}
}

	
