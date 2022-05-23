#include "RssiLocation.h"
module MobileNodeP
{
	provides {
		interface StdControl;
		interface Init;
	}
	uses {
		interface AMSend as BCastSend;
		interface Packet;		
		interface Alarm<T32khz, uint32_t> as Alarm;
		interface Init as SubInit;
		interface PowerControl;
		interface UartDebugControl;
		interface SplitControl as RadioControl;
	}
}
implementation
{
	message_t m_msg;

	location_beacon_t m_beacon;

	int err_check = 0;

	void err_check_inc()
	{
		err_check++;
		if (err_check > 50)
		{
			WDCTL = 0x0B;  /* reset the CPU in the smallest period */
		}
	}

	void err_check_reset()
	{
		err_check= 0;
	}
	
	task void BroadCastTask()
	{
		uint32_t* packet = (uint32_t*) call Packet.getPayload(&m_msg,NULL);
		memcpy(packet, &m_beacon, sizeof(m_beacon));
		ADBG(3000, "\r\nPrepare to send, dsn=%ld\r\n", m_beacon.dsn);
		if(call BCastSend.send(TOS_BCAST_ADDR, &m_msg, sizeof(m_beacon))!= SUCCESS)
		{
			post BroadCastTask();
		}
	}		

	command error_t Init.init()
	{
		call UartDebugControl.setLevelInput(TRUE);
		call SubInit.init();
		
		memset(&m_beacon, 0, sizeof(m_beacon));

		return SUCCESS;
	}

	command error_t StdControl.start()
	{
		call Alarm.start((uint32_t)MOBILE_BROADCAST_INTERVAL*32);
		return SUCCESS;
	}
	
	command error_t StdControl.stop()
	{
		return SUCCESS;
	}

	task void startRadio()
	{
		/*At first start radio*/
		error_t result = call RadioControl.start();
		
		if( result == EBUSY)
		{
			err_check_inc();
			post startRadio();
		}
		else
		{
			err_check_reset();
		}
	}

	task void stopRadio()
	{
		error_t result = call RadioControl.stop();

		if(result == EBUSY)
		{
			err_check_inc();
			post stopRadio();
		}
		else
		{
			err_check_reset();
		}

		if (err_check > 50)
		{/* some BUG??? */
			WDCTL = 0x0B;  /* reset the CPU in the smallest period */
			return;
		}
	}

	event void RadioControl.startDone(error_t result)
	{
		if(result != SUCCESS)
		{
			err_check_inc();
			post startRadio();
		}
		else
		{
			err_check_reset();
		}

		m_beacon.dsn++;
		
		post BroadCastTask();
		ADBG(3000,"\r\nAlarm fired!\r\n");
	}

	event void RadioControl.stopDone(error_t result)
	{
		if(result != SUCCESS)
		{
			err_check_inc();
			post stopRadio();
			return;
		}
		else
		{
			err_check_reset();
		}

		call PowerControl.sleep();
	}
		
	async event void Alarm.fired()
	{
		// LED_BLUE_TOGGLE;
		post startRadio();
	}	

	event void BCastSend.sendDone(message_t* msg, error_t error)
	{
		call Alarm.start((uint32_t)MOBILE_BROADCAST_INTERVAL*32);
		ADBG(3000,"\r\nBroadCastDone!\r\n");
		post stopRadio();

	}

	event void UartDebugControl.levelChanged(int new_level) { }
}

