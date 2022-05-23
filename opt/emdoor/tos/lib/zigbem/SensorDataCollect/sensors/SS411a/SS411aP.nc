#include "Sensor.h"

module SS411aP
{
	provides interface SensorData;
	uses interface SS411aData;
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{	
		m_value = p_value;
		return call SS411aData.read();
	}

	event void SS411aData.readDone(error_t result, uint16_t val)
	{
		su16(m_value, 0, val);
		m_len = 2;

		signal SensorData.readDone(m_value, m_len, result);
	}

	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) { }
}

