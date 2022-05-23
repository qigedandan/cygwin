#include "EmRouter.h"
#include "QuickRoute.h"

#define DBG_LEV 200

module EmRouterC
{
	uses {
		interface Boot;
		interface SplitControl as RFControl;
		interface AMPacket;
		interface Packet;
		interface SensorCollection;
		
		interface Send;		
		interface Timer<TMilli> as SensorTimer;

		interface UartDebugControl;

		interface StdControl as SystemHeartControl;
	}
}
implementation
{
	message_t m_sensor_msg;
	uint8_t m_sensor_length = 0;
	uint8_t* p_sensor_payload;
	uint sensor_retry = 0;
	bool m_sensoring = FALSE;
		
	task void sensorDataTask()
	{
		error_t result;
		result = call SensorCollection.startSensor(p_sensor_payload,SENSOR_ID_ILLUMINATION);
		/*if(result != SUCCESS)
		{	
			if (sensor_retry++ < 3)
			{
				post sensorDataTask();
			}
			else
			{
				atomic m_sensoring = FALSE;
			}
		}*/
	}

	event void Boot.booted()
	{
		quickroute_data_header_t *data_header;
		ADBG(DBG_LEV, "\r\n============ Boot.booted ==========\r\n");

		/* Enable system monitor... */
		call SystemHeartControl.start();

		call UartDebugControl.setLevelInput(TRUE);

		/* route header */
		data_header = (quickroute_data_header_t *)call Packet.getPayload(&m_sensor_msg, NULL);
		data_header->sensor_type = SENSOR_ID_ILLUMINATION;
		
		/* sensor payload */
		p_sensor_payload = call Send.getPayload(&m_sensor_msg);
		
		call RFControl.start();
	}

	event void RFControl.startDone(error_t err)
	{
		call SensorTimer.startPeriodic(CONFIG_SENSOR_RATE);
	}

	event void RFControl.stopDone(error_t err)
	{
	}

	event void SensorTimer.fired()
	{
		ADBG(DBG_LEV, "\n\n====== SensorTimer fired======\r\n");
		atomic
		{
			if (m_sensoring) return;
			m_sensoring = TRUE;
		}
		sensor_retry = 0;
		post sensorDataTask();
	}

	task void sendMsgTask() 
	{
		uint8_t i;
		// LED_BLUE_TOGGLE;

		ADBG(1000, "sensor payload:");
		for (i=0; i < m_sensor_length; ++i)
		{
			ADBG(1000, "%02x ", (int)p_sensor_payload[i]);
		}		
		
		//if (call Send.send(&m_sensor_msg, m_sensor_length+sizeof(quickroute_data_header_t)) != SUCCESS)
		if (call Send.send(&m_sensor_msg, m_sensor_length) != SUCCESS)
		{
			atomic m_sensoring = FALSE;
		}
	}

	event void SensorCollection.sensorDone(uint8_t* data, uint8_t len, error_t result)
	{
		ADBG(10, "Sensor data done, data len = %d, result=%d", (int)len, (int)result);
		if(result == SUCCESS)
		{
			m_sensor_length = len;
			post sendMsgTask();
		}
		else
		{
			atomic m_sensoring = FALSE;
		}
	}

	event void Send.sendDone(message_t* msg, error_t err)
	{
		atomic m_sensoring = FALSE;
	}

	event void UartDebugControl.levelChanged(int new_level)
	{
	}
}

