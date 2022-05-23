//=============================================================================
//	Document:		DecibelAppM.nc
//	Description:	模组文件，用于提供分贝传感器节点的驱动程序组件
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Node.h"

#define DBG_LEV 9

module DecibelAppM
{
	uses {
		interface Boot;								//tinyos-2.x\tos\interfaces\Boot.nc 
		interface Timer<TMilli> as SensorTimer;		//tinyos-2.x\tos\lib\timer\Timer.nc
		interface SensorCollection;
		interface StdControl as WsnControl;			//tinyos-2.x\tos\interfaces\StdControl.nc
    	interface Send;								//tinyos-2.x\tos\interfaces\Send.nc

    	interface Intercept;						//tinyos-2.x\tos\interfaces\Intercept.nc
    	interface Intercept as Snoop;
    	interface AMPacket;							//tinyos-2.x\tos\interfaces\AMPacket.nc
	}
}
implementation
{
	message_t m_sensor_msg;
	uint8_t m_sensor_offset = 0;
	uint8_t* p_sensor_payload;
	
	task void sensorDataTask()
	{
		int i;
		error_t result = 0;
		error_t catch = 0;
		for(i = 0; i < 30; i++)
		{
			catch = call SensorCollection.startSensor(p_sensor_payload,SENSOR_ID_DECIBEL);
			if(result < catch)
			{
				result = catch;
			}
		}
		if(result != SUCCESS)
		{	
			ADBG(1000, "\r\n !!!!sensor data error\r\n");
			post sensorDataTask();
		}	
	}

	event void Boot.booted()
	{
		ADBG(1000, "\r\n============ Boot.booted ==========\r\n");
		
		p_sensor_payload = call Send.getPayload(&m_sensor_msg);
		call WsnControl.start();
		
		call SensorTimer.stop();
		call SensorTimer.startPeriodic(CONFIG_SENSOR_RATE);
	}

	event void SensorTimer.fired()
	{	
		ADBG(1000,"\r\n====== SensorTimer fired======\r\n");
		post sensorDataTask();
	}

	task void sendMsgTask() 
	{
       if (m_sensor_offset > 0)
       {/* get length of total payload */
       		m_sensor_offset += 1;
       }
		//call AMPacket.setGroup(&m_sensor_msg, TOS_IEEE_GROUP);
		call AMPacket.setGroup(&m_sensor_msg, SENSOR_ID_DECIBEL);
		call Send.send( &m_sensor_msg, m_sensor_offset);
	}

	event void SensorCollection.sensorDone(uint8_t* data, uint8_t length, error_t result)
	{
		if(result == SUCCESS)
		{
			m_sensor_offset = length;
			post sendMsgTask();
		}
	}

	event void Send.sendDone(message_t *msg, error_t result)
    {
        ADBG(10, "\n**Main Send.sendDone\n");
    }

    event bool Intercept.forward(message_t * msg, void *payload, uint16_t len)
    {
        return TRUE;
    }
    event bool Snoop.forward(message_t * msg, void *payload, uint16_t len)
    {
        return TRUE;
    }
}

