#include "ProfileRoute.h"
#include "message.h"
module ProfileRouteServerRadioP
{
	provides interface ProfileRouteServerRadio;

	uses {
		interface AMSend as AckPingSend;
		interface AMSend as RouteInfoSend;
		interface Receive as PingReceive;
		interface Receive as AckRouteReceive;
		interface Packet;
		interface AMPacket;
	}
}
implementation
{
	message_t msg;
	profile_route_info_t mRouteInfo;

	command error_t ProfileRouteServerRadio.ackPing(uint16_t nodeId)
	{
		ack_ping_packet_t* ackPacket = (ack_ping_packet_t*)call Packet.getPayload(&msg, NULL);
		ackPacket->addr = call AMPacket.address();
		ackPacket->cmd = ACK_PING_CMD;

		return call AckPingSend.send(nodeId, &msg, sizeof(ack_ping_packet_t));
	}

	event void AckPingSend.sendDone(message_t* msg, error_t err)
	{
	}

	event message_t*  PingReceive.receive(message_t* msg, void* payload, uint8_t len)
	{
		memcpy(&mRouteInfo, payload, sizeof(profile_route_info_t));
		
		if( mRouteInfo.node != call AMPacket.source(msg) )
		{
			mRouteInfo.node = call AMPacket.source(msg) ;
		}

		if((mRouteInfo.len == 0x0f)&&(mRouteInfo.addr[0] == 0xffff ))
		{
			mRouteInfo.len = 0 ;
		}
		
		ADBG(2,"\r\nReceived ping from node %d\r\n", (int)call AMPacket.source(msg));
		signal ProfileRouteServerRadio.ping(&mRouteInfo, call AMPacket.source(msg));
		return msg;
	}

	event message_t* AckRouteReceive.receive(message_t* msg, void*payload, uint8_t len)
	{
		memcpy(&mRouteInfo, payload, sizeof(profile_route_info_t));

		if( mRouteInfo.node != call AMPacket.source(msg) )
		{
			mRouteInfo.node = call AMPacket.source(msg) ;
		}

		if((mRouteInfo.len == 0x0f)&&(mRouteInfo.addr[0] == 0xffff ))
		{
			mRouteInfo.len = 0 ;
		}

		signal ProfileRouteServerRadio.routeUpdateAcked(&mRouteInfo);
		return msg;
	}

	command error_t  ProfileRouteServerRadio.sendRoute(profile_route_info_t*routeInfo)
	{
		uint8_t* payload = (uint8_t*)call Packet.getPayload(&msg, NULL);
		memcpy(payload, routeInfo, sizeof(profile_route_info_t));
		ADBG(2,"\r\n Station send route update information\r\n");
		return call RouteInfoSend.send(routeInfo->node, &msg, sizeof(profile_route_info_t));
	}

	event void RouteInfoSend.sendDone(message_t* msg, error_t err)
	{
	}
	
}
		
