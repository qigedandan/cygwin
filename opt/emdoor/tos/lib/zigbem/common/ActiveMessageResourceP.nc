
generic module ActiveMessageResourceP()
{
	provides interface AMSend[uint8_t id];

	uses interface ActiveMessageResource;
	uses interface AMSend as SubAMSend[uint8_t id];
}
implementation
{
	norace am_addr_t m_addr = 0x0000;
	norace message_t *m_msg = NULL;
	norace uint8_t m_len = 0;
	norace uint8_t m_id = 0;

	/*==*/

	command error_t AMSend.send[uint8_t id](am_addr_t addr, message_t* msg, uint8_t len)
	{
		m_addr = addr;
		m_msg = msg;
		m_len = len;
		m_id = id;

		ADBG(10, "[ActiveMessageResource] AMSend.send addr=0x%04x, id=%d\n", m_addr, (int)id);
		
		return call ActiveMessageResource.request();
	}

	task void grantFailTask()
	{
		signal AMSend.sendDone[m_id](m_msg, FAIL);
	}
	

	event void ActiveMessageResource.granted(bool success)
	{
		ADBG(10, "[ActiveMessageResource]  granted  success=%d, id=%d\n", (int)success, (int)m_id);
		if (success)
		{
			if (call  SubAMSend.send[m_id](m_addr, m_msg, m_len) == SUCCESS)
			{
				return;
			}
			
			ADBG(10, "[ActiveMessageResource]  SubAMSend.send fail\n");
		}

		/* fail process! */
		post grantFailTask();
	}

	/*==*/
	
	command error_t AMSend.cancel[uint8_t id](message_t* msg)
	{
		return call SubAMSend.cancel[id](msg);
	}

	default event void AMSend.sendDone[uint8_t id](message_t* msg, error_t error) {}

	command uint8_t AMSend.maxPayloadLength[uint8_t id]()
	{
		return call SubAMSend.maxPayloadLength[id]();
	}
	
	command void* AMSend.getPayload[uint8_t id](message_t* msg)
	{
		return call SubAMSend.getPayload[id](msg);
	}

	event void SubAMSend.sendDone[uint8_t id](message_t* msg, error_t error)
	{
		signal AMSend.sendDone[id](msg, error);
	}
}

