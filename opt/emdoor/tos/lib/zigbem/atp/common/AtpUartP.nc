

generic module AtpUartP(uint16_t BUFFER_SIZE)
{
	provides interface StdControl;
	provides interface AtpUart;

	uses interface StdControl as UartStdControl;
	uses interface UartStream;
}
implementation
{
	#define ATP_UART_INC_BUF(v)	{ (v) =  ((v) + 1) % BUFFER_SIZE; }

	uint16_t m_send_buf_head = 0;
	uint16_t m_send_buf_tail = 0;
	
	uint8_t m_send_buf[BUFFER_SIZE];


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
	/* Buffer Control Send data */
	command error_t AtpUart.sendData(uint8_t *buf, uint16_t len)
	{
		atomic {
			uint16_t one_len = len;

			/* copy the first part */
			if (BUFFER_SIZE - m_send_buf_tail < len)
			{/* Not enough free space to copy in one time, split into two part */
				one_len = BUFFER_SIZE - m_send_buf_tail;
			}

			memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
			m_send_buf_tail = (m_send_buf_tail + one_len) % BUFFER_SIZE;
			buf += one_len;
			len -= one_len;
			
			/* copy the next part */
			if (len > 0)
			{
				one_len = len;
				memcpy(m_send_buf+m_send_buf_tail, buf, one_len);
				m_send_buf_tail = (m_send_buf_tail + one_len) % BUFFER_SIZE;
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
					one_len = BUFFER_SIZE - m_send_buf_head;
				}
				else
				{
					one_len = m_send_buf_tail - m_send_buf_head;
				}

				*from = m_send_buf_head;
				*len = one_len;
			
				/* move head pointer */
				m_send_buf_head = (m_send_buf_head + one_len) % BUFFER_SIZE;
			}
			else
			{/* No data */
				*from = 0;
				*len = 0;
			}
		}
	}
	
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
		signal AtpUart.receivedByte(byte);
	}


	async event void UartStream.receiveDone( uint8_t* buf, uint16_t len, error_t error )
	{
	}
	


}


