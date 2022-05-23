//=============================================================================
//	Document:		MPS500gP.nc
//	Description:	模组文件，用于提供MPS500g医用气压传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_MPS500g					ADC_CHANNEL_MEDICAL_PRESSURE

module MPS500gP
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as MPS500gControl;
		interface Read<int16_t> as MPS500gRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call MPS500gControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_MPS500g);        
       	return call MPS500gRead.read();
   	}

	event void MPS500gRead.readDone(error_t result, int16_t val)
   	{
   		su16(m_value, 0, val);
   		m_len = 2;

		signal SensorData.readDone(m_value, m_len, result);
   	}

   	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}

