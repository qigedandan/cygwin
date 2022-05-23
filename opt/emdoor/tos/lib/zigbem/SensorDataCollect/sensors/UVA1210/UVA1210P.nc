//=============================================================================
//	Document:		UVA1210P.nc
//	Description:	模组文件，用于提供UVA1210紫外线传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_UVA1210				ADC_CHANNEL_UV

module UVA1210P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as UVA1210Control;
		interface Read<int16_t> as UVA1210Read;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call UVA1210Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_UVA1210);        
     
		return call UVA1210Read.read();
    }

    event void UVA1210Read.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

