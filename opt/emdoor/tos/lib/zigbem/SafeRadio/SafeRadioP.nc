
#include "SafeRadio.h"

generic module SafeRadioP()
{
	provides interface Init;
	provides interface AMSend;
	provides interface Receive;
	provides interface Packet;

	uses interface Timer<TMilli> as AckTimer;

	uses interface AMSend as SubAMSendData;
	uses interface AMSend as SubAMSendAck;
	uses interface Receive as SubReceiveData;
	uses interface Receive as SubReceiveAck;

	uses interface AMPacket;
	uses interface Packet as SubPacket;
	
	uses interface Timer<TMilli> as DelayTimer;
}
implementation
{
	#define SAFE_RADIO_PTR(msg)	((safe_radio_t *)(call SubPacket.getPayload(msg, NULL)))
	#define SAFE_RADIO_ACK_PTR(msg)	((safe_radio_ack_t *)(call SubPacket.getPayload(msg, NULL)))

	bool m_sending = FALSE;
	message_t m_receive_packet;
	uint8_t m_dsn;

	am_addr_t m_send_addr;
	message_t *m_send_msg = NULL;
	uint8_t m_send_len = 0;
	uint8_t m_send_retry = 0;
	error_t m_send_result;

	error_t doSend();
	task void sendDoneTask();
	task void resendTask();

	/*===================================*/
	error_t doSend()
	{/* FIXME: when send to the broadcast addr, you should....?? */
		error_t result;
	
		if (m_send_msg != NULL && m_send_len>0)
		{
			SAFE_RADIO_PTR(m_send_msg)->ack_req = TRUE;
			SAFE_RADIO_PTR(m_send_msg)->dsn = ++m_dsn; //tivacc:修改为++m_dsn，原来为为m_dsn
			
			result = call SubAMSendData.send(m_send_addr, m_send_msg, m_send_len);

			if (result != SUCCESS)
			{
				post resendTask();
				return FAIL;
			}
			
			call AckTimer.startOneShot(SAFE_RADIO_ACK_TIME);
		}
		
		return result;
	}
	
	task void sendDoneTask()
	{
		atomic
		{
			if (!m_sending)
			{
				return;
			}
		}

		call AckTimer.stop();

		m_sending = FALSE;
		signal AMSend.sendDone(m_send_msg, m_send_result);
	}

	event void DelayTimer.fired()
	{
		/*m_send_retry++;

		if (m_send_retry <= SAFE_RADIO_RETRY)
		{
			doSend();
		}
		else
		{
			m_send_result = FAIL;
			post sendDoneTask();
		}*/
	}
	

	task void resendTask()
	{
		call AckTimer.stop();
		m_send_retry++;

		if (m_send_retry <= SAFE_RADIO_RETRY)
		{
			doSend();
		}
		else
		{
			m_send_result = FAIL;
			post sendDoneTask();
		}
		/*call DelayTimer.startOneShot(500);*/
	}

	event void AckTimer.fired()
	{
		atomic
		{
			if (!m_sending)
			{
				return;
			}
		}

		/* fail */
		post resendTask();
	}
	
	command error_t AMSend.send(am_addr_t addr, message_t* msg, uint8_t len)
	{
		atomic
		{
			if (m_sending)
			{
				return FAIL;
			}

			m_sending = TRUE;

			m_send_addr = addr;
			m_send_msg = msg;
			m_send_len = len + sizeof(safe_radio_t);

			m_dsn++;
			m_send_retry = 0;
		}
				
		return doSend();
	}

	command error_t AMSend.cancel(message_t* msg)
	{
		return SUCCESS;
	}


	command uint8_t AMSend.maxPayloadLength()
	{
		return call SubAMSendData.maxPayloadLength() - sizeof(safe_radio_t);
	}
	command void* AMSend.getPayload(message_t* msg)
	{
		return ((uint8_t *)call SubAMSendData.getPayload(msg)) + sizeof(safe_radio_t);
	}

	default event void AMSend.sendDone(message_t* msg, error_t error)
	{
	}

	event void SubAMSendData.sendDone(message_t* msg, error_t error)
	{
		if (error == SUCCESS)
		{
			if (m_sending && m_send_addr == TOS_BCAST_ADDR)
			{
				m_send_result = error;
				post sendDoneTask();
			}
		}
		else
		{
			post resendTask();
		}
	}

	event message_t* SubReceiveAck.receive(message_t* msg, void* payload, uint8_t len)
	{
		atomic
		{
			if (m_sending)
			{
				if ((len == sizeof(safe_radio_ack_t)) && ((safe_radio_ack_t *)payload)->dsn == m_dsn)
				{
					m_send_result = SUCCESS;
					post sendDoneTask();
				}
			}
		}

		return msg;
	}

	/*===================================*/
	safe_radio_history_t m_receive_history[SAFE_RADIO_HISTORY_SIZE];

	int indexOfNode(uint16_t addr)
	{
		uint8_t i;

		/* find existed space */
		for (i=0; i < SAFE_RADIO_HISTORY_SIZE; ++i)
		{
			if (m_receive_history[i].addr == addr)
			{
				return i;
			}
		}

		/* find empty space */
		for (i=0; i < SAFE_RADIO_HISTORY_SIZE; ++i)
		{
			if (m_receive_history[i].addr == 0)
			{
				return i;
			}
		}

		return 0; /**/
	}

	bool checkValidNode(uint16_t addr, uint8_t dsn)
	{
		int index = indexOfNode(addr);

		if (m_receive_history[index].addr == addr)
		{
			if (m_receive_history[index].dsn == dsn)
			{
				return FALSE;
			}
		}

		m_receive_history[index].addr = addr;
		m_receive_history[index].dsn = dsn;
		return TRUE;
	}
	
	
	
	/*===================================*/
	message_t m_ack_packet;
	
	task void sendAckTask()
	{
		call SubAMSendAck.send(call AMPacket.destination(&m_ack_packet), &m_ack_packet, sizeof(safe_radio_ack_t));
	}

	event void SubAMSendAck.sendDone(message_t* msg, error_t error)
	{
	}
	

	event message_t* SubReceiveData.receive(message_t* msg, void* payload, uint8_t len)
	{
		atomic
		{
			/* FIXME, conflict when filling ack packet */
			if ( (len >= sizeof(safe_radio_t)))
			{
				SAFE_RADIO_ACK_PTR(&m_ack_packet)->dsn = SAFE_RADIO_PTR(msg)->dsn;
				SAFE_RADIO_ACK_PTR(&m_ack_packet)->src = call AMPacket.source(msg);
				call AMPacket.setDestination(&m_ack_packet, call AMPacket.source(msg));

				payload += sizeof(safe_radio_t);
				len -= sizeof(safe_radio_t);
				
				post sendAckTask();

				if (!checkValidNode(call AMPacket.source(msg), SAFE_RADIO_PTR(msg)->dsn))
				{/* should no signal receive when node dsn not valid */
					return msg;
				}
			}
		}


		return signal Receive.receive(msg, payload, len);
	}


	default event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		return msg;
	}
	
	command void* Receive.getPayload(message_t* msg, uint8_t* len)
	{
		return call SubReceiveData.getPayload(msg, len) + sizeof(safe_radio_t);
	}
	
	command uint8_t Receive.payloadLength(message_t* msg)
	{
		return call SubReceiveData.payloadLength(msg) - sizeof(safe_radio_t);
	}
	

	/*===================================*/
	command void Packet.clear(message_t* msg)
	{
		call SubPacket.clear(msg);
	}
	
	command uint8_t Packet.payloadLength(message_t* msg)
	{
		return call SubPacket.payloadLength(msg) - sizeof(safe_radio_t);
	}
	
	command void Packet.setPayloadLength(message_t* msg, uint8_t len)
	{
		call SubPacket.setPayloadLength(msg, len + sizeof(safe_radio_t));
	}
	
	command uint8_t Packet.maxPayloadLength()
	{
		return call SubPacket.maxPayloadLength() - sizeof(safe_radio_t);
	}
	
	command void* Packet.getPayload(message_t* msg, uint8_t* len)
	{
		void *payload = ((uint8_t *)(call SubPacket.getPayload(msg, len))) + sizeof(safe_radio_t);

		if (len != NULL)
		{
			len -= sizeof(safe_radio_t);
		}

		return payload;
	}
	/*===================================*/

	command error_t Init.init()
	{
		memset(&m_receive_history, 0, sizeof(m_receive_history));
		m_dsn = 0;
		call AckTimer.stop();
		
		return SUCCESS;
	}


	/*=================================*/
	
}

