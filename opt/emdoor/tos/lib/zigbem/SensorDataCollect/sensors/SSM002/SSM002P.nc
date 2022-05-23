//=============================================================================
//	Document:		SSM002P.nc
//	Description:	ģ���ļ��������ṩSSM002��δ���������������ӿ�
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_SSM002				ADC_CHANNEL_RAIN

module SSM002P
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as SSM002Control;
		interface Read<int16_t> as SSM002Read;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call SSM002Control.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_RAIN);        
     
		return call SSM002Read.read();
    }

    event void SSM002Read.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

