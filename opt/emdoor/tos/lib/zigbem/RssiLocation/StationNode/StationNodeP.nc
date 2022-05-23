#include "RssiLocation.h"
module StationNodeP
{
	provides {
		interface StdControl;
		interface Init;
	}
	uses {
		interface Receive;
		interface Send;
		interface CC2420Packet;
		interface AMPacket;
		interface Timer<TMilli>;
		interface UartDebugControl;
		interface QuickRouteEngine;
	}
}
implementation
{
	message_t m_msg;
	location_info_t receive_buffer[LOCATION_INFO_RECEIVE_BUFFER_SIZE];
	location_info_t send_buffer[LOCATION_INFO_SEND_BUFFER_SIZE];	
	bool uploading;
	uint8_t buffer_head;
	uint8_t buffer_tail;
	uint8_t upload_len;	

	uint8_t getBufferSize()
	{
		uint8_t buffer_size;
		if(buffer_head <= buffer_tail)
		{
			buffer_size = buffer_tail - buffer_head;
		}
		else
		{
			buffer_size = buffer_tail + LOCATION_INFO_RECEIVE_BUFFER_SIZE - buffer_head;
		}

		return buffer_size;
	}

	task void uploadTask()
	{
		if(call Send.send(&m_msg, upload_len*sizeof(location_info_t)) != SUCCESS)
		{
			post uploadTask();
		}
	}

	uint8_t* data;
		
	task void prepareUploadTask()
	{	
		atomic uploading = TRUE;
		data = (uint8_t*)call Send.getPayload(&m_msg);
		
		upload_len = getBufferSize() < LOCATION_INFO_SEND_BUFFER_SIZE ? getBufferSize() : LOCATION_INFO_SEND_BUFFER_SIZE;

		if(upload_len<=0)
		{
			uploading = FALSE;
			return;
		}
		
		if(buffer_head <= buffer_tail)
		{
			memcpy(data, receive_buffer+buffer_head,  upload_len*sizeof(location_info_t));
		}
		else if(buffer_head + upload_len <= LOCATION_INFO_RECEIVE_BUFFER_SIZE)
		{
			memcpy(data, receive_buffer+buffer_head,  upload_len*sizeof(location_info_t));
		}
		else
		{
			memcpy(data, receive_buffer+buffer_head, (LOCATION_INFO_RECEIVE_BUFFER_SIZE-buffer_head)*sizeof(location_info_t));
			memcpy(data+LOCATION_INFO_RECEIVE_BUFFER_SIZE-buffer_head, receive_buffer, 
					(buffer_head + upload_len - LOCATION_INFO_RECEIVE_BUFFER_SIZE)*sizeof(location_info_t));
		}

		atomic buffer_head = (buffer_head + upload_len)%LOCATION_INFO_RECEIVE_BUFFER_SIZE;
		
		post uploadTask();
	}

	task void checkUploadTask()
	{
		if( getBufferSize() >= LOCATION_INFO_SEND_BUFFER_SIZE && uploading == FALSE)
		{
			ADBG(3000, "\r\ncheckUploadTaskDone prepare to send!\r\n");
			post prepareUploadTask();
		}
	}

	command error_t Init.init()
	{
		memset(receive_buffer, 0, sizeof(receive_buffer));
		memset(send_buffer, 0, sizeof(send_buffer));		
		uploading = FALSE;
		buffer_head = 0;
		buffer_tail = 0;
		upload_len = 0;

		call UartDebugControl.setLevelInput(TRUE);
		call QuickRouteEngine.enableRouteAutoUpdate(9000);
		
		return SUCCESS;
	}

	command error_t StdControl.start()
	{
		call Timer.startPeriodic(STATION_UPLOAD_INTERVAL);
		
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{
		return SUCCESS;
	}

	event void Timer.fired()
	{	
		ADBG(3000,"\r\nTimer fired\r\n");
		if(uploading == FALSE)
		{
			post prepareUploadTask();
		}
	}

	event void Send.sendDone(message_t* msg, error_t success)
	{
			
		uploading = FALSE;
		post checkUploadTask();		
	}

	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		location_info_t* info;
		// LED_BLUE_TOGGLE;	

		ADBG(3,"\r\nReceived data");
		
		if(len == sizeof(uint32_t))
		{
			info =  receive_buffer + buffer_tail;
			info -> id = call AMPacket.source(msg);
			info -> dsn = *((uint32_t*)payload);
			info -> rssi = call CC2420Packet.getRssi(msg);

			atomic buffer_tail = (buffer_tail+1)% LOCATION_INFO_RECEIVE_BUFFER_SIZE;

			ADBG(3000,"\r\nReceived data from node %d, len = %d, dsn=%ld, rssi = %d, buffer_head=%d, buffer_tail=%d",
			                        (int)info->id, (int) len, info->dsn, (int)info->rssi, (int)buffer_head, (int)buffer_tail);
			
			post checkUploadTask();			
		}

		return msg;
	}

	event void UartDebugControl.levelChanged(int new_level) { }	
}
	
