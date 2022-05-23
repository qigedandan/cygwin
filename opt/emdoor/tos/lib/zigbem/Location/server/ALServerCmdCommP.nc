

module ALServerCmdCommP
{
	provides interface StdControl;
	provides interface ALServerCmdComm;

	uses interface StdControl as UartStdControl;
	uses interface UartStream;
	uses interface ALServerCmdPacket;
}
implementation
{
	enum
	{
		/* 2K buffer for the UART */
		ALSERVER_CMD_COMM_BUF_SIZE	= 2*1024,
	};

	#define ALSERVER_CMD_COMM_INC_BUF(v)	{ (v) =  ((v) + 1) % ALSERVER_CMD_COMM_BUF_SIZE; }

	uint16_t m_send_buf_head = 0;
	uint16_t m_send_buf_tail = 0;
	
	uint8_t m_send_buf[ALSERVER_CMD_COMM_BUF_SIZE];

	uint16_t m_packet_len = 0;
	uint8_t m_packet_buf[sizeof(alserver_cmd_packet_t)+1];

	uint8_t m_sending = FALSE;

	task void sendNextBuffer();

	/*============================================================*/
	command error_t StdControl.start()
	{
		return call UartStdControl.start();
	}

	command error_t StdControl.stop()
	{
		return call UartStdControl.stop();
	}

	/*============================================================*/
	/* Buffer Control */
	void addToBuffer(uint8_t *buf, uint16_t len)
	{
		atomic {
			uint16_t one_len = len;

			/* copy the first part */
			if (ALSERVER_CMD_COMM_BUF_SIZE - m_send_buf_tail < len)
			{/* Not enough free space to copy in one time, split into two part */
				one_len = ALSERVER_CMD_COMM_BUF_SIZE - m_send_buf_tail;
			}

			memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
			m_send_buf_tail = (m_send_buf_tail + one_len) % ALSERVER_CMD_COMM_BUF_SIZE;
			buf += one_len;
			len -= one_len;
			
			/* copy the next part */
			if (len > 0)
			{
				one_len = len;
				memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
				m_send_buf_tail = (m_send_buf_tail + one_len) % ALSERVER_CMD_COMM_BUF_SIZE;
				buf += one_len;
				len -= one_len;
			}
		}
		post sendNextBuffer();
	}

	
	void prepareSendBuffer(uint16_t *from, uint16_t *len)
	{/* prepare a continous buffer with data to send */
		atomic {
			if (m_send_buf_tail != m_send_buf_head)
			{
				uint16_t one_len;
				
				if (m_send_buf_tail < m_send_buf_head)
				{
					one_len = ALSERVER_CMD_COMM_BUF_SIZE - m_send_buf_head;
				}
				else
				{
					one_len = m_send_buf_tail - m_send_buf_head;
				}

				*from = m_send_buf_head;
				*len = one_len;
			
				/* move head pointer */
				m_send_buf_head = (m_send_buf_head + one_len) % ALSERVER_CMD_COMM_BUF_SIZE;
			}
			else
			{/* No data */
				*from = 0;
				*len = 0;
			}
		}
	}
	
	/*============================================================*/
	/* Packet Control */
	command error_t ALServerCmdComm.sendCmdPacket(alserver_cmd_packet_t *packet)
	{
		/* fill into the buffer now */
		atomic {
			/* generate packet stream */
			call ALServerCmdPacket.generatePacket(packet, m_packet_buf, &m_packet_len);
			
			//ADBG(300, "m_packet_len=%d\n", (int)m_packet_len);
			/* add to buffer */
			addToBuffer(m_packet_buf, m_packet_len);
		}
		
		return SUCCESS;
	}

	
	event void ALServerCmdPacket.receivedPacket(alserver_cmd_packet_t *packet)
	{
		signal ALServerCmdComm.receivedCmdPacket(packet, SUCCESS);
	}


	task void signalSendCmdPacketDone()
	{
	}
	default event void ALServerCmdComm.sendCmdPacketDone(alserver_cmd_packet_t *packet, error_t error) {}
	

	/*============================================================*/
	/* Uart Control */

	task void sendNextBuffer()
	{
		uint16_t from, len;
		atomic {
			if (!m_sending)
			{
				prepareSendBuffer(&from, &len);
				
				if (len > 0)
				{
					m_sending = TRUE;
					ADBG(50, "sendNextBuffer from=0x%04x, len=0x%04x\n", from, len);
					call UartStream.send(m_send_buf+from, len);
				}
			}
		}
	}

	async event void UartStream.sendDone( uint8_t* buf, uint16_t len, error_t error )
	{
		atomic {
			if (m_sending)
			{
				m_sending = FALSE;
				ADBG(50, "UartStream.sendDone\n");
				post sendNextBuffer();
			}
		}
	}
	
	
	async event void UartStream.receivedByte( uint8_t byte )
	{
		call ALServerCmdPacket.receiveNext(&byte, 1);
	}


	async event void UartStream.receiveDone( uint8_t* buf, uint16_t len, error_t error )
	{
	}
	


}


