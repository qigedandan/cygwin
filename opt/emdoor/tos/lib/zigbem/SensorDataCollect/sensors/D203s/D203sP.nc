//=============================================================================
//	Document:		D203sP.nc
//	Description:	模组文件，用于提供D203s远红外传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_D203s				ADC_CHANNEL_INFRARED

module D203sP
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as D203sControl;
		interface Read<int16_t> as D203sRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		
		P0_1 = 1;
		call D203sControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_D203s);        
     
		return call D203sRead.read();
    }

    event void D203sRead.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

