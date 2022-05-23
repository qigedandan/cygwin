
#include <strings.h>

module UartInputP
{
	provides interface UartInput;

	uses interface StdControl as UartStdControl;
	uses interface UartStream;
}
implementation
{
	enum
	{
		INPUT_BUF_SIZE = 30,
		SCANF_END_CHAR = 13,  /* ENTER key */
	};

	char m_format_buf[5];  /* only a small format string... :( */
	uint8_t m_buf_count = 0;
	uint8_t m_buf[INPUT_BUF_SIZE+1];
	void *m_value = NULL;
	bool m_scanfing = FALSE;

	command error_t UartInput.scanf(char *format, void *value)
	{
		atomic {
			if (m_scanfing == TRUE)
			{
				return EBUSY;
			}
			m_scanfing = TRUE;

			memcpy(m_format_buf, format, sizeof(m_format_buf));
			m_value = value;
			m_buf_count = 0;
		}

		call UartStdControl.start();
		
		return SUCCESS;
	}

	task void doScanfDone()
	{
		m_scanfing = FALSE;

		m_buf[m_buf_count % INPUT_BUF_SIZE] = '\0';  /* end of char */

		sscanf(m_buf, m_format_buf, m_value);
		
		signal UartInput.scanfDone(m_value, SUCCESS);
	}
	
	async event void UartStream.receivedByte( uint8_t byte )
	{
		if (m_scanfing)
		{
			if ((byte == SCANF_END_CHAR  &&  m_buf_count > 0)
			|| (m_buf_count >= INPUT_BUF_SIZE)
			)
			{
				post doScanfDone();
			}
			else
			{
				m_buf[m_buf_count++] = byte;

				/* echo this char.. */
				call UartStream.send(&byte, sizeof(byte));
			}
		}
	}

	
	async event void UartStream.receiveDone( uint8_t* buf, uint16_t len, error_t error ) {}
	async event void UartStream.sendDone( uint8_t* buf, uint16_t len, error_t error ) {}
	
	default event void UartInput.scanfDone(void *value, error_t error) {}
}

