//=============================================================================
//	Document:		GL4548P.nc
//	Description:	模组文件，用于提供GL4548光敏电阻的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_GL4548					ADC_CHANNEL_ILLUMINATION

module GL4548P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as GL4548Control;
		interface Read<int16_t> as GL4548Read;
	}
}

implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call GL4548Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_GL4548);        
        return call GL4548Read.read();
    }

    event void GL4548Read.readDone(error_t result, int16_t val)
    {
    	ADBG(1000, "GL4548Read.readDone result=%d, val=%d\n", (int)result, val);
    	su16(m_value, 0, val);
    	m_len = 2;

    	signal SensorData.readDone(m_value, m_len, result);
    }

    default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}
