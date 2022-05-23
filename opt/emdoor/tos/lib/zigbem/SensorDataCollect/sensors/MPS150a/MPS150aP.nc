//=============================================================================
//	Document:		MPS150aP.nc
//	Description:	模组文件，用于提供MPS150a气压传感器的驱动程序接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

#define ADC_CHANNEL_MPS150a					ADC_CHANNEL_AIR_PRESSURE

module MPS150aP
{
	provides interface SensorData;
	uses 
	{
		interface AdcControl as MPS150aControl;
		interface Read<int16_t> as MPS150aRead;
	}
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		call MPS150aControl.enable(ADC_REF_AVDD, ADC_14_BIT, ADC_CHANNEL_MPS150a);        
        return call MPS150aRead.read();
    }

    event void MPS150aRead.readDone(error_t result, int16_t val)
    {
    	su16(m_value, 0, val);
    	m_len = 2;

    	signal SensorData.readDone(m_value, m_len, result);
    }

    default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result) {}
}
