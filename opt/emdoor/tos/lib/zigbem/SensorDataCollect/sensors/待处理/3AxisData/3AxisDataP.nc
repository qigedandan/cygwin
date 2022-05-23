#include "Sensor.h"

module 3AxisDataP
{
	provides interface SensorData;
	uses {
		interface AdcControl as 3AxisControl;
		interface Read<int16_t> as 3AxisRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call 3AxisControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_RAIN);        
     
		return call 3AxisRead.read();
    }

    event void 3AxisRead.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

