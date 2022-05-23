#include "OSARF.h"

module OSARFReceiveP
{
	provides interface StdControl;
	provides interface Receive;  /* Receive Data only */
	provides interface Receive as ReceiveAll;  /* Receive any message received include ACK message */

	uses interface OSARF;
	uses interface ActiveMessageAddress;
}
implementation
{
	enum
	{
		RECEIVE_BUF_SIZE = 5,
	};

	message_t m_msg[RECEIVE_BUF_SIZE];
	uint8_t m_msg_head = 0;
	uint8_t m_msg_tail= 0;

	message_t m_ack_msg;

	/*================================*/
	command error_t StdControl.start()
	{
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{
		return SUCCESS;
	}

	/*================================*/

	task void signalReceive()
	{
		message_t *p_msg = NULL;
		atomic {
			if (m_msg_head != m_msg_tail)
			{
				p_msg = & m_msg[m_msg_head];
				m_msg_head = (m_msg_head + 1) % RECEIVE_BUF_SIZE;
			}
		}

		if (p_msg != NULL)
		{
			OSARF_HEADER_T *header = OSARF_HEADER_PTR(p_msg);
			signal Receive.receive(p_msg, p_msg->data, header->length - MAC_HEADER_SIZE);
			post signalReceive();
		}
	}

	void addReceive(message_t *msg)
	{
		atomic {
			memcpy( & (m_msg[m_msg_tail]), msg, sizeof(message_t));
			m_msg_tail = (m_msg_tail + 1) % RECEIVE_BUF_SIZE;
		}

		post signalReceive();
	}

	/*================================*/

	int ackManual(uint16_t addr, uint8_t dsn)
	{
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(&m_ack_msg);

		ADBG(4, "ACK MANUAL addr=0x%04x, dsn=0x%02x \n", addr, (int)dsn);
			
		header->fcf = ( ( IEEE154_TYPE_DATA << IEEE154_FCF_FRAME_TYPE ) |
			     ( 1 << IEEE154_FCF_INTRAPAN ) |
			     ( IEEE154_ADDR_SHORT << IEEE154_FCF_DEST_ADDR_MODE ) |
			     ( IEEE154_ADDR_SHORT << IEEE154_FCF_SRC_ADDR_MODE ) );
			     
		header->destpan = call ActiveMessageAddress.amGroup(); /* FIXME: because now the amGroup() return uint8_t, but destpan is uint16_t  */
		header->dsn = dsn;  
		header->src =call ActiveMessageAddress.amAddress();
		#ifdef STARNETWORK
		header->dest = 0x0001;
		#else
		header->dest = addr;
		#endif
		header->type = OSARF_ACK_MANUAL_TYPE;


		/* calculate the length */
		header->length = 0 + MAC_HEADER_SIZE + MAC_FOOTER_SIZE;

		if (call OSARF.sendPacket((uint8_t *)(&m_ack_msg)) != SUCCESS)
		{
			ADBG(4, "ACK MANUAL send fail!");
		}	
		
		return 0;
	}

	/*================================*/
	  


	command void* Receive.getPayload(message_t* msg, uint8_t* len)
	{
		if (len != NULL)
		{
			*len = call Receive.payloadLength(msg);
		}

		return msg->data;
	}

	command uint8_t Receive.payloadLength(message_t* msg)
	{
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(msg);
		return header->length - MAC_HEADER_SIZE - MAC_FOOTER_SIZE;
	}

	command void* ReceiveAll.getPayload(message_t* msg, uint8_t* len)
	{
		return call Receive.getPayload(msg, len);
	}

	command uint8_t ReceiveAll.payloadLength(message_t* msg)
	{
		call Receive.payloadLength(msg);
	}
  
	event uint8_t * OSARF.receivedPacket(uint8_t * packet)
	{
		message_t *p_msg = (message_t *)packet;
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(p_msg);
		OSARF_METADATA_T* metadata = OSARF_METADATA_PTR( p_msg );
		
		signal ReceiveAll.receive(p_msg, p_msg->data, header->length - MAC_HEADER_SIZE);

		if (header->fcf & (1<<IEEE154_FCF_ACK_REQ))
		{
			#ifdef OSARF_ACK_MANUAL
			ackManual(header->src, header->dsn);  /* ack manual */
			#else
			RFST = _CC2430_ISACK; /* ack throught CC2430 */
			#endif
		}

		
		if ((( header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7) ==  IEEE154_TYPE_DATA
		&&  (header->type != OSARF_ACK_MANUAL_TYPE)
		)
		{
			uint8_t* ack_buf = (uint8_t *)header;
		       metadata->rssi = ack_buf[ header->length - 1 ];
		       metadata->lqi = ack_buf[ header->length ] & 0x7f;
			//signal Receive.receive(p_msg, p_msg->data, header->length - MAC_HEADER_SIZE);
			addReceive(p_msg);
			
		}
		
		return packet;
	}

	async event void OSARF.sendPacketDone(uint8_t * packet, error_t result)
	{
		if (packet == (uint8_t *)&m_ack_msg)
		{
			ADBG(4, "ACK MANUAL OSARF.sendPacketDone result=%d!", (int)result);
		}
	}
	default event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
	}

	default event message_t* ReceiveAll.receive(message_t* msg, void* payload, uint8_t len)
	{
	}

	
	async event void ActiveMessageAddress.changed()
	{
	
	}
}



