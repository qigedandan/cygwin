//=============================================================================
//	Document:		MQ2P.nc
//	Description:	模组文件，用于提供MQ2可燃气体传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_MQ2					ADC_CHANNEL_SMOKE

module MQ2P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as MQ2Control;
		interface Read<int16_t> as MQ2Read;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call MQ2Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_SMOKE);        
     
		return call MQ2Read.read();
    }

    event void MQ2Read.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

