//=============================================================================
//	Document:		SensorCollectionP.nc
//	Description:	模组文件，用于提供传感器模块的接口
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Sensor.h"

module SensorCollectionP
{
	provides interface SensorCollection;
	uses interface SensorData[sensor_id_t id];	
}
implementation
{
	bool m_sensor_running = FALSE;

	uint8_t* p_data;
	uint8_t m_sensor_offset = 0;
	uint8_t m_sensor_len = 0;
	sensor_id_t m_sensors;

	error_t sensorNow();
	task void sensorStart();
	task void sensorFinish();
	
	command error_t SensorCollection.startSensor(uint8_t* data, sensor_id_t sensor)
	{
		if(m_sensor_running == TRUE)
		{
			return FAIL;
		}
		p_data = data;
		m_sensor_offset = 0;
		m_sensor_len = 0;
		m_sensors = sensor;
		post sensorStart();
		
		return SUCCESS;		
	}
	
	error_t sensorNow()
	{
		error_t result = -1;
		ADBG(10, "Measure Sensor Now...\r\n");
		
		result = call SensorData.read[m_sensors](p_data+m_sensor_offset);		
		return result;
	}

	task void sensorFinish()
	{
		m_sensor_running = FALSE;
		signal SensorCollection.sensorDone(p_data, m_sensor_len, SUCCESS);
	}

	task void sensorStart()
	{
		m_sensor_running = TRUE;
		sensorNow();		
	}

	event void SensorData.readDone[sensor_id_t id](uint8_t* p_value, uint8_t len, error_t result)
	{	
		ADBG(10, " SensorData Done\r\n");
		m_sensor_len += len;
		m_sensor_offset += len;
		
		post sensorFinish();
	}
		
	default event void SensorCollection.sensorDone(uint8_t* data, uint8_t len, error_t result) { }

	default command error_t SensorData.read[sensor_id_t id](uint8_t* p_value)
	{
		return FAIL;
	}
}
