
generic module SimpleForwardP(uint8_t SIZE)
{
	provides interface SimpleForward;
	provides interface Intercept;

	uses interface AMSend;
	uses interface AMPacket;
	uses interface Packet;

	uses interface Receive;

	uses interface CoreControlOwner;
}
implementation
{
	typedef struct
	{
		uint8_t len;
		message_t msg;
	} forward_t;

	forward_t m_forward_msg[SIZE];
	uint8_t m_head = 0;
	uint8_t m_tail = 0;

	bool m_forwarding = FALSE;

	enum
	{
		CORE_CONTROL_SIMPLE_FORWARD,
	};

	uint16_t getForwardAddress()
	{
		if (call AMPacket.address() > 1)
		{
			return call AMPacket.address() - 1;
		}

		return 0xFFFF;
	}

	task void forwardNext()
	{
		atomic
		{
			if (m_forwarding)
			{
				return;
			}
		}
	
		if (m_head != m_tail)
		{
			uint16_t addr = getForwardAddress();
			
			if (addr != 0xFFFF)
			{				
				atomic m_forwarding = TRUE;
				if (call AMSend.send(addr, &m_forward_msg[m_head].msg, m_forward_msg[m_head].len) != SUCCESS)
				{
					post forwardNext();
				}
			}
			else
			{
				post forwardNext();
			}

			m_head = (m_head + 1) % SIZE;
		}
		else
		{
			call CoreControlOwner.setFree(CORE_CONTROL_SIMPLE_FORWARD);
		}
	}
	

	error_t forwardMessage(message_t *msg, uint8_t len)
	{
		ADBG(DBG_LEV, "forwardMessage src=%d\n", call AMPacket.source(msg));
		call CoreControlOwner.setBusy(CORE_CONTROL_SIMPLE_FORWARD);
		
		atomic
		{	
			m_forward_msg[m_tail].len = len;
			memcpy(&(m_forward_msg[m_tail].msg), msg, sizeof(message_t));

			m_tail = (m_tail + 1) % SIZE;

			post forwardNext();
		}

		return SUCCESS;
	}

	command uint16_t SimpleForward.getNextAddress()
	{
		return getForwardAddress();
	}

	command error_t SimpleForward.forward(message_t *msg, uint8_t len)
	{
		return forwardMessage(msg, len);
	}


	event void AMSend.sendDone(message_t* msg, error_t error)
	{
		atomic m_forwarding = FALSE;

		ADBG(DBG_LEV, "forwardMessage result=%d\n", (int)error);
		
		post forwardNext();
	}

	/*===*/

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		if (signal Intercept.forward(msg, payload, len))
		{
			forwardMessage(msg, len);
		}

		return msg;
	}
	
	/*===*/
	
	default event bool Intercept.forward(message_t* msg, void* payload, uint16_t len)
	{
		return TRUE;
	}
}

