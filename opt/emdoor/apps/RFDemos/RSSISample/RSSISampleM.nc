/*************************************************
*	FUNCTION NAME : RSSISampleM.nc
*	FUNCTION DESCRIPTION : RSSI 采集
*	FUCNTION DATE :2010/10/18
*	FUNCTION AUTHOR: EMDOOR
**/

#define DBG_LEV 1000

module RSSISampleM
{
	uses {
		interface Boot;
		interface Timer<TMilli>;
		interface AMSend;
		interface Receive;
		interface Packet;
		interface AMPacket;
		interface CC2420Packet;
		interface SplitControl as RFControl;
		interface Leds;
	}
}
implementation
{
	message_t m_msg;
	uint16_t count = 0;

	task void sendTask()
	{
		uint16_t* packet = (uint16_t*)call Packet.getPayload(&m_msg, NULL);
		packet[0] = count++;

		ADBG(DBG_LEV, "\r\n\r\n* Sending... from[%d], to [%d], len = [%d]\r\n",
			ADBG_N(call AMPacket.address()),
			ADBG_N(1),
			ADBG_N(sizeof(uint16_t))
		);
		
		call AMSend.send(1, &m_msg, sizeof(uint16_t));

		call Leds.BlueLedToggle();
		// LED_BLUE_TOGGLE;
	}

	event void Boot.booted()
	{
		/*开启射频*/
		call RFControl.start();

		call Leds.YellowLedOff();
		call Leds.BlueLedOff();
		// LED_YELLOW_OFF;
		// LED_BLUE_OFF;
		
		ADBG(DBG_LEV, "\r\n###############################################\r\n");
		ADBG(DBG_LEV, "   [RSSISAMPLE DEMO] My Address = 0x%x, Group = 0x%x\r\n", ADBG_N(call AMPacket.address()), ADBG_N(TOS_IEEE_PANID));
		ADBG(DBG_LEV, "###############################################\r\n");

		if(call AMPacket.address() == 1)
		{
			ADBG(DBG_LEV, "\r\n* Prepare to Receive:\r\n");
		}
		else
		{
			ADBG(DBG_LEV, "\r\n* Prepare to Send:\r\n");
		}
	}

	/** 实现接口RFControl 接口中的事件*/
	event void RFControl.startDone(error_t result)
	{
		/**
			启动 定时器定时发送，
			1号节点收，其他节点发送到1号节点
		*/
		if(call AMPacket.address() != 1) 
		{
			call Timer.startPeriodic(2000);
		}
	}

	event void RFControl.stopDone(error_t result)
	{
	}

	event void Timer.fired()
	{
		/*定时器定时完成，准备发送数据*/
		post sendTask();
	}
		
	/*发送完处理*/
	event void AMSend.sendDone(message_t* msg, error_t success)
	{
		ADBG(DBG_LEV, "* Sent%s!\r\n", (success == SUCCESS) ? "OK" : "FAIL");		
	}

	/*射频接收数据*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{	
		int rssi = call CC2420Packet.getRssi(msg);
		ADBG(DBG_LEV, "\r\n*Receive, len = [%d], RSSI:[%d]",
			ADBG_N(len),
			ADBG_N(rssi)
		);
		
		call Leds.YellowLedToggle();
		// LED_YELLOW_TOGGLE;		
	}
}	
		
	
