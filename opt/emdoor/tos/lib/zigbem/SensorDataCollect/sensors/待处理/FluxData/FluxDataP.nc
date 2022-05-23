#include "Sensor.h"

module FluxDataP
{
	provides interface SensorData;
	uses interface CaptureSensor as FluxSensor;
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		return call FluxSensor.read();
    	}

    	event void FluxSensor.readDone(error_t result, uint16_t val)
    	{
    		su16(m_value, 0, val);
    		m_len = 2;

    		ADBG(1000, "FluxSensor.readDone value=[%d]\n", (int)val);

    		signal SensorData.readDone(m_value, m_len, result);
    	}

    	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

