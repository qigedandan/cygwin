
generic module EEPROMP(typedef address_size_type @integer(), uint8_t i2c_addr, uint16_t size)
{
	provides interface EEPROM<address_size_type>;
	
	uses interface I2CPacket<TI2CBasicAddr> as I2C;
}
implementation
{
	enum
	{
		EEPROM_NONE,
		EEPROM_WRITE,
		EEPROM_READ,
	};
	
	uint8_t m_state = EEPROM_NONE;
	address_size_type m_addr = 0;
	uint8_t  *m_data = NULL;
	address_size_type m_len = 0;
	uint8_t m_write_buf[sizeof(address_size_type) + 1];
	uint8_t m_error = SUCCESS;

	command address_size_type EEPROM.getMaxAddress()
	{
		return (address_size_type)(size-1);
	}

	/*=========================================================*/
	task void writeDone()
	{
		atomic m_state = EEPROM_NONE;
		signal EEPROM.writeDone(m_error, m_addr, m_data, m_len);
	}
	
	task void writeNextByte()
	{
		if ((uint16_t)m_addr < size && m_len > 0)
		{
			atomic {
				uint8_t i;
				
				memcpy(m_write_buf, &m_addr, sizeof(address_size_type));
				m_write_buf[sizeof(address_size_type)] = *m_data;

				for (i=0; i < sizeof(m_write_buf); ++i)
				{
					ADBG(1, "EEPROM.writeNextByte m_addr=%d, m_wrtie_buf[%d]=0x%02x\n", (int)m_addr, (int)i, (int)m_write_buf[i]);
				}
				
				call I2C.write(0, i2c_addr, sizeof(address_size_type)+1, m_write_buf);
			}
		}
		else
		{
			post writeDone();
		}
	}
	
	command error_t EEPROM.write(address_size_type addr, uint8_t *data, address_size_type len)
	{
		atomic {
			if (m_state == EEPROM_WRITE || m_state == EEPROM_READ)
			{
				return EBUSY;
			}
			m_state = EEPROM_WRITE;
			m_addr = addr;
			m_data = data;
			m_len = len;
		}

		post writeNextByte();

		return SUCCESS;
	}
	
	
	async event void I2C.writeDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data)
	{
		if (m_state == EEPROM_WRITE)
		{
			if (error != SUCCESS)
			{/* Mark error happening, but continue next address to prevent endless loop */
				m_error = error;
			}
			
			/* move to next */
			m_addr++;
			m_data++;
			m_len--;

			{/* Wait a little for the EEPROM to save data */
 				uint16_t i =0;
				while (i++ < 0x1FFF);
			}
			post writeNextByte();
		}
	}

	/*=========================================================*/

	uint8_t readByte(address_size_type addr, uint8_t *data)
	{
		if (addr >= size)
		{
			return 1;
		}
		call I2C.write(0, i2c_addr, sizeof(address_size_type), (uint8_t*)(&addr));
		call I2C.read(0, i2c_addr, 1, data);

		return 0;
	}

	task void readDone()
	{
		atomic m_state = EEPROM_NONE;
		signal EEPROM.readDone(m_error, m_addr, m_data, m_len);
	}
	
	command error_t EEPROM.read(address_size_type addr, uint8_t *data, address_size_type len)
	{
		address_size_type i = 0;
		
		atomic {
			if (m_state == EEPROM_WRITE || m_state == EEPROM_READ)
			{
				return EBUSY;
			}
			m_state = EEPROM_READ;
			m_addr = addr;
			m_data = data;
			m_len = len;
		}

		for (i=0; i < len; ++i)
		{
			if (readByte(addr+i, data+i) != 0)
			{
				m_error = FAIL;
			}
		}

		post readDone();
	}
	async event void I2C.readDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data)
	{
	}

	default event void EEPROM.writeDone(error_t error, address_size_type addr, uint8_t *data, address_size_type len) {}
	default event void EEPROM.readDone(error_t error, address_size_type addr, uint8_t *data, address_size_type len) {}

}

