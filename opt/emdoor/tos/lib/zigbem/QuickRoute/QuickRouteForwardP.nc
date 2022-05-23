#include "QuickRoute.h"

module QuickRouteForwardP
{
	provides {
		interface QuickRouteForward;
	}

	uses {
		interface Packet;
		interface AMPacket;
		
		interface Send as SubSend;
		
		interface SmartQueue as SendQueue;

		interface Timer<TMilli> as ForwardTimer;

		interface QuickRouteEngine;
		interface QuickRouteEngineEvent;

		interface CoreControlOwner;

		interface Packet as DataPacket;
	}
}
implementation
{
	#define FORWARD_DELAY 50
	
	bool m_forwarding = FALSE;
	MESSAGE_PM0_T m_send_msg;                 // The msg being sent, if any
	
	#define MSG_SIZE(payload_len) ((payload_len) + sizeof(message_header_t) + sizeof(message_footer_t) + sizeof(message_metadata_t))

	/*================================*/
	void copy_msg_in(uint8_t *dst, message_t *src)
	{//copy into queue
		uint8_t payload_length = call Packet.payloadLength(src);
		uint8_t offset = 0;
		//header
		memcpy(dst+offset, src->header, sizeof(message_header_t));
		offset += sizeof(message_header_t);

		//payload
		if (payload_length > 0)
		{
			memcpy(dst+offset, src->data, payload_length);
			offset += payload_length;
		}

		//footer
		memcpy(dst+offset, src->footer, sizeof(message_footer_t));
		offset += sizeof(message_footer_t);

		//metadata
		memcpy(dst+offset, src->metadata, sizeof(message_metadata_t));
		offset += sizeof(message_metadata_t);
	}

	void copy_msg_out(message_t *dst, uint8_t *src)
	{
		uint8_t payload_length = 0;
		uint8_t offset = 0;
		//header
		memcpy(dst->header, src+offset, sizeof(message_header_t));
		offset += sizeof(message_header_t);

		//payload
		payload_length = call Packet.payloadLength(dst);
		if (payload_length > 0)
		{
			memcpy(dst->data, src+offset, payload_length);
			offset += payload_length;
		}

		//footer
		memcpy(dst->footer, src+offset, sizeof(message_footer_t));
		offset += sizeof(message_footer_t);
        
		//metadata
		memcpy(dst->metadata, src+offset, sizeof(message_metadata_t));
		offset += sizeof(message_metadata_t);
	}
	
	/*================================*/
	task void forwardNext()
	{
		atomic
		{
			if (m_forwarding)
			{
				return;
			}
		}
	
		if (call SendQueue.isEmpty() == FALSE)
		{
			uint8_t *queued_msg = (uint8_t *)call SendQueue.head();
			
			memset(&m_send_msg, 0, sizeof(m_send_msg));
			copy_msg_out(&m_send_msg, queued_msg);

			if (call SubSend.send(&m_send_msg, call DataPacket.payloadLength(&m_send_msg))
			== SUCCESS
			)
			{/* sending now !*/
				atomic m_forwarding = TRUE;
			}
			else
			{/* fail because busy?? */
				call SendQueue.dequeue();  //really? drop it now???
				post forwardNext();
			}
		}
		else
		{
			call CoreControlOwner.setFree(0);
		}
	}
	

	error_t forwardMessage(message_t *msg)
	{
		ADBG(DBG_LEV, "forwardMessage src=%d\n", call AMPacket.source(msg));

		atomic
		{
			uint8_t *dst;
			uint8_t len = call Packet.payloadLength(msg);
			quickroute_data_header_t *data_header = (quickroute_data_header_t *)call DataPacket.getPayload(msg, NULL);

			if (!call QuickRouteEngine.forwardProcess(msg))
			{
				return FAIL;
			}

			ADBG(1000, "QuickRouteForwardP. forwardMessage orgi=%d, second_addr=%d\n", data_header->second_addr, data_header->orgi_addr);
			
			
			if (!call SendQueue.canStore( MSG_SIZE(len) ))
			{
				return FAIL;
			}

			dst = call SendQueue.enqueue( MSG_SIZE(len) );

			call Packet.setPayloadLength(msg, len);
			copy_msg_in(dst, msg);

			post forwardNext();
		}

		return SUCCESS;
	}

	event void SubSend.sendDone(message_t* msg, error_t error)
	{
		ADBG(DBG_LEV, "QuickRouteForward Send.sendDone result=%d\n", (int)error);
		atomic m_forwarding = FALSE;

		//clear sent message
		call SendQueue.dequeue();

		post forwardNext();
		//call ForwardTimer.startOneShot(FORWARD_DELAY);
	}

	
	/*================================*/
	
	command error_t QuickRouteForward.forward(message_t *msg)
	{
		call CoreControlOwner.setBusy(0);
		
		forwardMessage(msg);
	}

	event void ForwardTimer.fired()
	{
		post forwardNext();
	}

	/*=========================*/
	event void QuickRouteEngineEvent.routeUpdateDone(error_t result)
	{
	}

	event void QuickRouteEngineEvent.routeFail()
	{
		if (call SendQueue.nbElements() < 100  )/* when no enough size, broadcast my fail route?*/
		{
			call QuickRouteEngine.broadcastFailRoute();
		}
	}
}	

	
