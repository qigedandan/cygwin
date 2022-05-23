//=============================================================================
//	Document:		OTP538uP.nc
//	Description:	模组文件，用于提供OTP538u红外热电堆传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_OTP538u				ADC_CHANNEL_THERMOPILE

module OTP538uP
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as OTP538uControl;
		interface Read<int16_t> as OTP538uRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call OTP538uControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_OTP538u);        
     
		return call OTP538uRead.read();
    }

    event void OTP538uRead.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

