#include "OSALogger.h"

generic module OSALoggerP(int32_t size)
{
	provides interface OSALogger;
}
implementation
{
	uint8_t m_data[size];
	int32_t m_count = 0;
	int32_t m_offset = 0;

	
	command error_t OSALogger.clear()
	{
		atomic {
			m_count = 0;
			m_offset = 0;
		}

		return SUCCESS;
	}
	
	command int32_t OSALogger.count()
	{
		atomic {
			return m_count;
		}
	}
	
	command int32_t OSALogger.maxCount()
	{
		return size;
	}

	
	command bool OSALogger.canStore(int32_t len)
	{
		atomic {
			return (m_count + len <= size);
		}
	}
	
	command int32_t OSALogger.readPosition()
	{
		atomic {
			return m_offset;
		}
	}

	
	command error_t OSALogger.write(uint8_t *data, int32_t len)
	{
		ADBG(5, "OSALogger.write m_count=%ld, len=%ld\n", m_count, len);
		atomic {
			if (m_count + len > size)
			{/* full */
				return FAIL;
			}

			memcpy(m_data+m_count, data, len);
			m_count += len;

			return SUCCESS;
		}
	}

	
	command int32_t OSALogger.read(uint8_t *data, int32_t len)
	{
		atomic {
			if (m_offset >= m_count)
			{
				return 0;  /* fail, no data for you */
			}

			if (m_offset + len >= m_count)
			{/* to many size specify, decrease it */
				len = m_count - m_offset;
			}

			memcpy(data, m_data+m_offset, len);
			m_offset += len;
			
			return len;
		}
	}

	command uint8_t * OSALogger.get(int32_t *len)
	{/* The same as read, except copy file */
		atomic {
			uint8_t *data = NULL;
			
			ADBG(5, "OSALogger.get ENTER m_offset=%ld, m_count=%ld, len=%ld\n", m_offset, m_count, *len);
				
			if (m_offset >= m_count)
			{
				*len = 0;
				return NULL;  /* fail, no data for you */
			}

			if ((m_offset + *len) >= m_count)
			{/* to many size specify, decrease it */
				*len = m_count - m_offset;
			}

			data = m_data + m_offset;
			m_offset += *len;
			
			ADBG(5, "OSALogger.get EXIT m_offset=%ld, m_count=%ld, len=%ld\n", m_offset, m_count, *len);
			
			return data;
		}

	}
	
	command error_t OSALogger.seek(int32_t offset, int start_pos)
	{
		atomic {
			if (start_pos == OSALOGGER_SEEK_SET)
			{
				m_offset = 0;
			}
			else if (start_pos == OSALOGGER_SEEK_END)
			{
				m_offset = m_count-1;
			}

			m_offset += offset;
			
			if (m_offset < 0)
			{
				m_offset = 0;
			}
			else if (m_offset > m_count)
			{
				m_offset = m_count;
			}

			return SUCCESS;
		}
	}
}

