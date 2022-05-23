#include "AM.h"
#include "ProfileRoute.h"

generic module ProfileForwardEngineP(uint8_t SIZE)
{
	provides {		
		interface Send;
		interface Receive;		
		interface Packet;
		interface Intercept;
		interface ProfileRouteInfo;
	}

	uses {
		interface AMSend;
		interface AMSend as SendMine;
		interface Packet as SubPacket;
		interface AMPacket;
		interface PacketAcknowledgements;
		interface Receive as SubReceive;
		interface Receive as ReceiveMine;
		interface RouteSelect;
		interface RootControl;
	}
}
implementation
{
	typedef struct
	{
		uint8_t len;
		message_t msg;
	}forward_t;

	forward_t m_forward_msg[SIZE];
	uint8_t m_head = 0;
	uint8_t m_tail = 0;

	bool m_forwarding = FALSE;


	task void forwardNext()
	{
		atomic
		{
			if(m_forwarding)
			{
				ADBG(1000, "m_forwarding TRUE, return\r\n");
				return;
			}
		}

		if(m_head != m_tail)
		{
			call RouteSelect.selectRoute(&m_forward_msg[m_head].msg, 0);
			call PacketAcknowledgements.requestAck(&m_forward_msg[m_head].msg);
			if(call AMSend.send(call AMPacket.destination(&m_forward_msg[m_head].msg), 
				&m_forward_msg[m_head].msg,
				call SubPacket.payloadLength(&m_forward_msg[m_head].msg))== SUCCESS) 
			{
				ADBG(1000, "Call AMSend SUCCESS,Sending\r\n");				
				
			}else{
				ADBG(1000, "Call AMSend FAIL, return\r\n");	
				return;
			}

			m_forwarding = TRUE;
		}
	}

	message_t* forwardMessage(message_t* msg, uint8_t len)
	{
		atomic
		{
			m_forward_msg[m_tail].len = len;
			memcpy(&(m_forward_msg[m_tail].msg), msg, sizeof(message_t));

			ADBG(1000, "Forward msg from node %d\r\n", (int)call ProfileRouteInfo.getOriginaddr(msg));
			m_tail = (m_tail + 1) % SIZE;

			post forwardNext();
		}

		return msg;
	}
	
	command error_t Send.send(message_t* pMsg, uint8_t len)
	{
		if(call RootControl.isRoot()) {
			return FAIL;
		}

		len += sizeof(profile_route_header_t);

		call RouteSelect.initializeFields(pMsg);

		ADBG(1000, "\r\n Send packet, route initialize Done, originAddr =%d, len=%d\r\n", (int)call ProfileRouteInfo.getOriginaddr(pMsg), (int)len);

		if(call RouteSelect.selectRoute(pMsg, 0) != SUCCESS)
		{
			return FAIL;
		}

		ADBG(1000, "\r\n the next hop is:%d\r\n", (int)call AMPacket.destination(pMsg));

		call PacketAcknowledgements.requestAck(pMsg);

		if(call SendMine.send(call AMPacket.destination(pMsg), pMsg, len) != SUCCESS)
		{
			return FAIL;
		}

		return SUCCESS;
	}

	command void* Send.getPayload(message_t* msg)
	{
		return call Packet.getPayload(msg, NULL);
	}

	command uint8_t  Send.maxPayloadLength()
	{
		return call Packet.maxPayloadLength();
	}
	
	command error_t Send.cancel(message_t* msg)
	{
		return FAIL;
	}

	command void* Receive.getPayload(message_t* msg, uint8_t* len)
	{
		return call Packet.getPayload(msg, len);
	}

	command uint8_t Receive.payloadLength(message_t* msg)
	{
		return call Packet.payloadLength(msg);
	}	

	event message_t* SubReceive.receive(message_t* msg, void* payload, uint8_t len) {
		uint8_t id = call ProfileRouteInfo.getType(msg);
		payload += sizeof(profile_route_header_t);
		len -= sizeof(profile_route_header_t);

		ADBG(1000,"\r\nReceived msg from node %d\r\n", (int)call ProfileRouteInfo.getOriginaddr(msg));

		if(call RootControl.isRoot())
		{
			return signal Receive.receive(msg, payload, len);
		}
		else if(call AMPacket.destination(msg) != call AMPacket.address())
		{
			return msg;
		}
		else if(signal Intercept.forward(msg, payload, len))
		{
			return forwardMessage(msg, len);
		}
		else
		{
			return msg;
		}
		
	}

	event message_t* ReceiveMine.receive(message_t* msg, void* payload, uint8_t len) {
		uint8_t id = call ProfileRouteInfo.getType(msg);
		payload += sizeof(profile_route_header_t);
		len -= sizeof(profile_route_header_t);

		ADBG(1000,"\r\nReceived msg from node %d\r\n", (int)call ProfileRouteInfo.getOriginaddr(msg));
		
		if(call RootControl.isRoot())
		{
			return signal Receive.receive(msg, payload, len);
		}
		else if(call AMPacket.destination(msg) != call AMPacket.address())
		{
			return msg;
		}
		else if(signal Intercept.forward(msg, payload, len))
		{
			return forwardMessage(msg, len);
		}
		else
		{
			return msg;
		}
		
	}

	event void AMSend.sendDone(message_t* msg, error_t success)
	{
		ADBG(1000, "AMSend send Done, success = %d\r\n", (int)success);
		if(!(call PacketAcknowledgements.wasAcked(msg))&& call AMPacket.destination(msg) != 0xffff)
		{
			call RouteSelect.selectRoute(msg, 1);
			call PacketAcknowledgements.requestAck(msg);
			if(call AMSend.send(call AMPacket.destination(msg), msg, call SubPacket.payloadLength(msg))== SUCCESS)
			{
				return;
			}else{
				m_forwarding = FALSE;
				m_head = (m_head + 1) % SIZE;
				post forwardNext();		
				return;
			}
		}
		m_forwarding = FALSE;

		m_head = (m_head + 1) % SIZE;
		post forwardNext();		
	}

	event void SendMine.sendDone(message_t* msg, error_t success)
	{
		ADBG(1000, "SendMine send Done, success = %d\r\n", (int)success);
		if(!(call PacketAcknowledgements.wasAcked(msg)) && call AMPacket.destination(msg) != 0xffff)
		{
			call RouteSelect.selectRoute(msg,1);
			call PacketAcknowledgements.requestAck(msg);
			if(call SendMine.send(call AMPacket.destination(msg), msg, call SubPacket.payloadLength(msg))== SUCCESS)
			{
				return;
			}else{
				signal Send.sendDone(msg, FAIL);
			}			
		}

		signal Send.sendDone(msg, success);
	}
		

/***
 *      Paclet commands
 */
	command void  Packet.clear(message_t* msg)
	{
	}

	command uint8_t  Packet.payloadLength(message_t* msg) 
	{
		return (call SubPacket.payloadLength(msg) -sizeof(profile_route_header_t));
	}

	command void Packet.setPayloadLength(message_t* msg, uint8_t len)
	{
		call SubPacket.setPayloadLength(msg, len+sizeof(profile_route_header_t));
	}

	command uint8_t Packet.maxPayloadLength() 
	{
		return (call SubPacket.maxPayloadLength() - sizeof(profile_route_header_t));
	}

	command void* Packet.getPayload(message_t* msg, uint8_t* len)
	{
		void* rval = call SubPacket.getPayload(msg,len);

		if(len != NULL)
		{
			*len -= sizeof(profile_route_header_t);
		}
		rval += sizeof(profile_route_header_t);

		return rval;
	}
/***
 * ProfileRouteInfo commands
 */
 	command uint8_t ProfileRouteInfo.getType(message_t* msg)
 	{
 		profile_route_header_t* header = (profile_route_header_t*)call SubPacket.getPayload(msg, NULL);

 		return header->id;
 	}

 	command uint8_t ProfileRouteInfo.getSensorType(message_t* msg)
 	{
 		profile_route_header_t* header = (profile_route_header_t*)call SubPacket.getPayload(msg, NULL);

		return header->sensorType;
	}

	command uint16_t ProfileRouteInfo.getOriginaddr(message_t* msg)
	{
		profile_route_header_t* header = (profile_route_header_t*)call SubPacket.getPayload(msg, NULL);

		return header->originaddr;
	}

	default event void Send.sendDone(message_t* msg, error_t success) { }

	default event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		return msg;
	}	

	default event bool Intercept.forward(message_t* msg, void* payload, uint16_t len)
	{
		return 1;
	}
	
}
	
