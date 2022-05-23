module SHTxxP
{
	provides interface SensorData;	
	uses interface SHTxxData;
}
implementation
{	
	uint8_t* m_value;
	uint8_t m_len;
	
	command error_t SensorData.read(uint8_t* p_value)
	{	
		m_value = p_value;
		return call SHTxxData.read();
	}

	event void SHTxxData.readDone(error_t result,uint16_t temperature,uint16_t humidity)
	{
		su16(m_value, 0, temperature);
		su16(m_value, 2, humidity);
		m_len = 4;

		signal SensorData.readDone(m_value, m_len, result);
	}

	default event void SensorData.readDone(uint8_t* p_value, uint8_t length, error_t result) {}
}
	
