#include "EMSleepNode.h"
#include "QuickRoute.h"
#include "Sensor.h"

#define DBG_LEV 1000
module EMSleepNodeC
{
	uses {
		interface Boot;
		interface AMPacket;
		interface Packet;

		/* Sensor data */
		interface SensorCollection;

		/* Quick Route */
		interface Send;
		interface QuickRouteEngine;

		/* Sleep control */
		interface SleepNodeCycleControl;
		interface UnsleepClock;
		interface CycleNodeSyncData;
		interface ClockSync;

		/* Uart debug control */
		interface UartDebugControl;

		interface McuSleepControl;
	}
}
implementation
{
	message_t m_sensor_msg;
	uint8_t m_sensor_length = 0;
	uint8_t* p_sensor_payload;

	task void processBegin();
	task void processEnd();
	task void sensorDataTask();
	task void sendDataTask();

	event void Boot.booted()
	{
		quickroute_data_header_t *data_header;
		ADBG(DBG_LEV, "\r\n============ Boot.booted ==========\r\n");


		call UartDebugControl.setLevelInput(TRUE);

		/* route header */
		data_header = (quickroute_data_header_t *)call Packet.getPayload(&m_sensor_msg, NULL);
		data_header->sensor_type = EM_NODE_TYPE;
		
		/* sensor payload */
		p_sensor_payload = call Send.getPayload(&m_sensor_msg);
		
		post processBegin();
	}

	/*================ Sleep Control ==============*/
	task void processBegin()
	{
		ADBG(DBG_LEV, "processBegin()\n");
		call SleepNodeCycleControl.begin();
	}

	task void processEnd()
	{
		ADBG(DBG_LEV, "processEnd()\n");
		call CycleNodeSyncData.readDataFinished();
	}
	
	event void UnsleepClock.cpuWakeup()
	{
		post processBegin();
	}
	
	event void SleepNodeCycleControl.end()
	{
		ADBG(DBG_LEV, "SleepNodeCycleControl.end()\n");
		call UnsleepClock.sleepCpu( call SleepNodeCycleControl.getSleepTime() );
	}
	
	event void CycleNodeSyncData.readDataFired()
	{
		ADBG(DBG_LEV, "CycleNodeSyncData.readDataFired\n");
		
		post sensorDataTask();
	}	
	/*================ Sleep Control ==============*/

	/*================ Sensor Control ==============*/
	task void sensorDataTask()
	{
		error_t result;
				
		result = call SensorCollection.startSensor(p_sensor_payload,SENSOR_ID_ILLUMINATION);
		if(result != SUCCESS) //数据采集错误，等待下一次处理
		{
			ADBG(DBG_LEV, "SensorCollection.startSensor result=%d\n", (int)result);
			post processEnd();
		}
	}

	event void SensorCollection.sensorDone(uint8_t* data, uint8_t len, error_t result)
	{
		ADBG(DBG_LEV, "Sensor data done, data len = %d, result=%d", (int)len, (int)result);
		if(result == SUCCESS)
		{
			m_sensor_length = len;
			post sendDataTask();
		}
		else
		{
			post processEnd();
		}
	}
	/*================ Sensor Control ==============*/

	/*================ Send Control ==============*/
	task void sendDataTask()
	{
		
		if (call Send.send(&m_sensor_msg, m_sensor_length) != SUCCESS)
		{
			post processEnd();
		}
	}
	
	event void Send.sendDone(message_t* msg, error_t err)
	{
		ADBG(4000, "EMSleepNode Send.sendDone err=%d\n", (int)err);
		post processEnd();
	}
	
	/*================ Send Control ==============*/
	
	/*======= Uart Debug control ==========*/
	event void UartDebugControl.levelChanged(int new_level)
	{
	}

	/*=================*/
	event void McuSleepControl.beforeSleep()
	{
		// LED_BLUE_OFF;
		// LED_YELLOW_OFF;
	}	

	event void McuSleepControl.afterWakeup()
	{
	}

	/*=================*/
	event void ClockSync.syncFired(bool unsyncBefore)
	{
	}
	
	event void ClockSync.requestSyncDone(error_t result)
	{
	}
	
	event void ClockSync.sourceBroadcastDone(error_t result)
	{
	}
	
}
	
