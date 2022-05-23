//=============================================================================
//	Document:		DS18B20P.nc
//	Description:	ģ���ļ��������ṩDS18B20�¶ȴ���������������ӿ�
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

module DS18B20P
{
	provides interface SensorData;
	uses interface DS18B20Data;
}
implementation
{
	uint8_t* m_value;
	uint8_t m_len;

	command error_t SensorData.read(uint8_t* p_value)
	{
		m_value = p_value;
		return call DS18B20Data.read();
	}

	event void DS18B20Data.readDone(error_t result, uint16_t raw_temperature)
	{
		su16(m_value, 0, raw_temperature);
		m_len = 2;
		signal SensorData.readDone(m_value, m_len, result);
	}

	default event void SensorData.readDone(uint8_t* p_value, uint8_t len, error_t result){ }
}

