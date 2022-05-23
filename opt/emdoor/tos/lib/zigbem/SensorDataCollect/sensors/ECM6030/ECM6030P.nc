//=============================================================================
//	Document:		ECM6030P.nc
//	Description:	模组文件，用于提供ECM6030驻极体电容式麦克风的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_ECM6030				ADC_CHANNEL_DECIBEL

module ECM6030P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as ECM6030Control;
		interface Read<int16_t> as ECM6030Read;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call ECM6030Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_RAIN);        
     
		return call ECM6030Read.read();
    }

    event void ECM6030Read.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

