

module OSAServerCmdCommP
{
	provides interface StdControl;
	provides interface OSAServerCmdComm;

	uses interface StdControl as UartStdControl;
	uses interface UartStream;
	uses interface OSAServerCmdPacket;
}
implementation
{
	enum
	{
		/* 2K buffer for the UART */
		OSASERVER_CMD_COMM_BUF_SIZE	= 2*1024,
	};

	#define OSASERVER_CMD_COMM_INC_BUF(v)	{ (v) =  ((v) + 1) % OSASERVER_CMD_COMM_BUF_SIZE; }

	uint16_t m_send_buf_head = 0;
	uint16_t m_send_buf_tail = 0;
	
	uint8_t m_send_buf[OSASERVER_CMD_COMM_BUF_SIZE];

	uint16_t m_packet_len = 0;
	uint8_t m_packet_buf[sizeof(osaserver_cmd_packet_t)+1];

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
			if (OSASERVER_CMD_COMM_BUF_SIZE - m_send_buf_tail < len)
			{/* Not enough free space to copy in one time, split into two part */
				one_len = OSASERVER_CMD_COMM_BUF_SIZE - m_send_buf_tail;
			}

			memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
			m_send_buf_tail = (m_send_buf_tail + one_len) % OSASERVER_CMD_COMM_BUF_SIZE;
			buf += one_len;
			len -= one_len;
			
			/* copy the next part */
			if (len > 0)
			{
				one_len = len;
				memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
				m_send_buf_tail = (m_send_buf_tail + one_len) % OSASERVER_CMD_COMM_BUF_SIZE;
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
					one_len = OSASERVER_CMD_COMM_BUF_SIZE - m_send_buf_head;
				}
				else
				{
					one_len = m_send_buf_tail - m_send_buf_head;
				}

				*from = m_send_buf_head;
				*len = one_len;
			
				/* move head pointer */
				m_send_buf_head = (m_send_buf_head + one_len) % OSASERVER_CMD_COMM_BUF_SIZE;
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
	command error_t OSAServerCmdComm.sendCmdPacket(osaserver_cmd_packet_t *packet)
	{
		/* fill into the buffer now */
		atomic {
			/* generate packet stream */
			call OSAServerCmdPacket.generatePacket(packet, m_packet_buf, &m_packet_len);
			
			/* add to buffer */
			addToBuffer(m_packet_buf, m_packet_len);
		}
		
		return SUCCESS;
	}

	
	event void OSAServerCmdPacket.receivedPacket(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmdComm.receivedCmdPacket(packet, SUCCESS);
	}


	task void signalSendCmdPacketDone()
	{
	}
	default event void OSAServerCmdComm.sendCmdPacketDone(osaserver_cmd_packet_t *packet, error_t error) {}
	

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
					ADBG(5, "sendNextBuffer from=0x%04x, len=0x%04x\n", from, len);
					call UartStream.send(m_send_buf+from, len);
				}
			}
		}
	}

	async event void UartStream.sendDone( uint8_t* buf, uint16_t len, error_t error )
	{
		atomic {
			m_sending = FALSE;
			post sendNextBuffer();
		}
	}
	
	
	async event void UartStream.receivedByte( uint8_t byte )
	{
		call OSAServerCmdPacket.receiveNext(&byte, 1);
	}


	async event void UartStream.receiveDone( uint8_t* buf, uint16_t len, error_t error )
	{
	}
	


}


