//=============================================================================
//	Document:		JNHB1004P.nc
//	Description:	模组文件，用于提供JNHB1004火焰传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_JNHB1004				ADC_CHANNEL_FIRE

module JNHB1004P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as JNHB1004Control;
		interface Read<int16_t> as JNHB1004Read;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call JNHB1004Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_JNHB1004);        
     
		return call JNHB1004Read.read();
    }

    event void JNHB1004Read.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

