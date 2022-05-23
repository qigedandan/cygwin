//=============================================================================
//	Document:		HDSZP.nc
//	Description:	ģ���ļ��������ṩHDSZ�𶯴���������������ӿ�
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_HDSZ				ADC_CHANNEL_VIBRATION

module HDSZP
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as HDSZControl;
		interface Read<int16_t> as HDSZRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call HDSZControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_VIBRATION);        
     
		return call HDSZRead.read();
    }

    event void HDSZRead.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;
   		signal SensorData.readDone(m_value, m_len, result);
  	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

