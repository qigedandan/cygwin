
#include "OSARF.h"
#include "OSAComm.h"

module OSACommP
{
	provides interface OSAComm;
	provides interface StdControl;

	uses interface StdControl as SubControl;
	uses interface Send;
	uses interface Receive;
}
implementation
{
	message_t m_msg;
	bool m_sending = FALSE;


	/*===========================================================*/
	command error_t StdControl.start()
	{
		return call SubControl.start();
	}
	
	command error_t StdControl.stop()
	{
		return call SubControl.stop();
	}
	
	/*===========================================================*/
	command error_t OSAComm.sendCmd(uint16_t addr, osacomm_cmd_t *cmd, uint8_t cmddata_size)
	{
		/* Total payload size for message_t = cmd id + cmddata_size */
		uint8_t cmd_size = (sizeof(cmd->cmd) + cmddata_size);
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(&m_msg);

		ADBG(5, "OSAComm.sendCmd addr=0x%04x, cmddata_size=%d, cmd_size=%d\n", addr, (int)cmddata_size, (int)cmd_size);
		
		atomic {
			if (m_sending)
			{
				return EBUSY;
			}

			memset(&m_msg, 0, sizeof(m_msg));		
			memcpy(call Send.getPayload(&m_msg), cmd, cmd_size);
			header->type = OSACOMM_RF_TYPE;
			#ifdef STARNETWORK
			header->dest = 0x0001;
			#else
			header->dest = addr;
			#endif
			
			m_sending  = TRUE;
		}

		return call Send.send(&m_msg, cmd_size);
	}

	event void Send.sendDone(message_t* msg, error_t error)
	{
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(&m_msg);
		osacomm_cmd_t *cmd = (osacomm_cmd_t *)(call Send.getPayload(&m_msg));

		ADBG(5, "OSAComm.Send.sendDone error = %d, m_sending=%d\n", (int)error, (int)m_sending);
		
		if (m_sending)
		{
			signal OSAComm.sendCmdDone(header->dest,  cmd,	error);
			m_sending = FALSE;
		}
	}


	/*===========================================================*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		OSARF_HEADER_T *header = OSARF_HEADER_PTR(msg);
		osacomm_cmd_t *p_cmd = (osacomm_cmd_t *) call Receive.getPayload(msg, NULL);

		if (header->type == OSACOMM_RF_TYPE)
		{
			ADBG(6, "OSAComm.Receive.receive len=%d\n", (int)len);
			signal OSAComm.receivedCmd(header->src, header->dest, p_cmd);
		}

		return msg;
	}
	
	
	/*===========================================================*/
	default event void OSAComm.sendCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error) { }
	
	default event void OSAComm.receivedCmd(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd) { }
	
}

