

generic module ClockSyncP(uint8_t is_source)
{
	provides interface ClockSync;
	
	uses interface UnsleepClock;

	uses interface Packet;
	
	uses interface AMSend as AMSendTime;
	uses interface AMSend as AMSendRequest;
	
	uses interface Receive as ReceiveTime;
	uses interface Receive as ReceiveRequest;

	uses interface CoreControlOwner;
}
implementation
{
	uint8_t m_sync_dsn = CLOCKSYNC_INVALID_DSN;
	MESSAGE_PM0_T m_cmd_msg;
	MESSAGE_PM0_T m_req_msg;

	enum
	{
		CORE_CONTROL_BROADCAST,
		CORE_CONTROL_REQUEST,
	};

	/*=============*/
	/* End process */
	void broadcastBegin()
	{
		call CoreControlOwner.setBusy(CORE_CONTROL_BROADCAST);
	}
	
	void broadcastEnd(error_t result)
	{
		if (is_source)
		{
			signal ClockSync.sourceBroadcastDone(result);
		}

		call CoreControlOwner.setFree(CORE_CONTROL_BROADCAST);
		ADBG(DBG_LEV, "broadcastEnd() result=%d\n", (int)result);
	}


	void requestBegin()
	{
		call CoreControlOwner.setBusy(CORE_CONTROL_REQUEST);
	}	
	
	void requestEnd(error_t result)
	{
		signal ClockSync.requestSyncDone(result);
		call CoreControlOwner.setFree(CORE_CONTROL_REQUEST);
	}

	
	/*=============*/
	/* source */
	
	task void broadcastTime()
	{
		ADBG(DBG_LEV, "broadcastTime()\n");
		
		CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_cmd_msg, NULL))->time = call UnsleepClock.getClockTime();
		
		if (call AMSendTime.send(AM_BROADCAST_ADDR, &m_cmd_msg, sizeof(clocksync_packet_t)) != SUCCESS)
		{
			broadcastEnd(FAIL);
		}
	}

	
	void receivePacketRequest(clocksync_packet_t *packet)
	{
		ADBG(DBG_LEV, "receive request packet\n");
		
		if (call ClockSync.isSynchornized())
		{
			broadcastBegin();
			
			/* broadcast my message now */
			memset(&m_cmd_msg, 0, sizeof(m_cmd_msg));
			CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_cmd_msg, NULL))->dsn = m_sync_dsn;
			post broadcastTime();
		}
	}


	command error_t ClockSync.sourceBroadcast()
	{/* the source node will call this every to sync time of the network */
		if (is_source)
		{
			broadcastBegin();
			
			m_sync_dsn++;
			if (m_sync_dsn == CLOCKSYNC_INVALID_DSN)
			{
				m_sync_dsn++;
			}

			memset(&m_cmd_msg, 0, sizeof(m_cmd_msg));
			CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_cmd_msg, NULL))->dsn = m_sync_dsn;
			post broadcastTime();
		}
		return SUCCESS;
	}


	event void AMSendTime.sendDone(message_t* msg, error_t error)
	{
		ADBG(DBG_LEV, "AMSendTime.sendDone error=%d\n", (int)error);
		if (msg == &m_cmd_msg)
		{
		}

		broadcastEnd(error);
	}

	event message_t* ReceiveRequest.receive(message_t* msg, void* payload, uint8_t len)
	{
		//ADBG(DBG_LEV, "Receive.receive message\n");

		/* packet processing */
		
		receivePacketRequest(CLOCKSYNC_PACKET_PTR(payload));
		
		return msg;
	}
	
	/*=============*/
	/* node */
	bool m_unsync_before = TRUE;
	task void syncFired()
	{
		signal ClockSync.syncFired(m_unsync_before);
	}
	
	task void broadcastRequest()
	{
		ADBG(DBG_LEV, "\n\n\nbroadcastRequest()\n");

		memset(&m_req_msg, 0, sizeof(m_req_msg));
		
		CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_req_msg, NULL))->dsn = m_sync_dsn;
		CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_req_msg, NULL))->time = call UnsleepClock.getClockTime();

		if (call AMSendRequest.send(AM_BROADCAST_ADDR, &m_req_msg, sizeof(clocksync_packet_t)) != SUCCESS)
		{
			signal ClockSync.requestSyncDone(FAIL);
		}
	}
	

	void updateFromTimePacket(clocksync_packet_t *packet)
	{
		if (packet->dsn != CLOCKSYNC_INVALID_DSN
		&& packet->dsn != m_sync_dsn)
		{
			atomic m_unsync_before = (!call ClockSync.isSynchornized());
			m_sync_dsn = packet->dsn;
			call UnsleepClock.setClockTime(packet->time + CLOCKSYNC_ADJ_TIME);

			/* broadcast my message now */
			
			broadcastBegin();
			
			CLOCKSYNC_PACKET_PTR(call Packet.getPayload(&m_cmd_msg, NULL))->dsn = m_sync_dsn;
			post broadcastTime();

			post syncFired();
		}
	}

	void receivePacketTime(clocksync_packet_t *packet)
	{
		if (!is_source)
		{/* sync source does not receive any sync message!  */
			/* check DSN */
			updateFromTimePacket(packet);
		}
	}

	
	command error_t ClockSync.requestSync()
	{
		requestBegin();
		
		post broadcastRequest();
		return SUCCESS;
	}

	event void AMSendRequest.sendDone(message_t* msg, error_t error)
	{
		ADBG(DBG_LEV, "AMSendRequest.sendDone error=%d\n", (int)error);
		if (msg == &m_req_msg)
		{
			
		}
		
		requestEnd(error);
	}


	event message_t* ReceiveTime.receive(message_t* msg, void* payload, uint8_t len)
	{
		ADBG(DBG_LEV, "ReceiveTime.receive\n");

		/* packet processing */
		receivePacketTime(CLOCKSYNC_PACKET_PTR(payload));	
		
		return msg;
	}

	/*=============*/

	command error_t ClockSync.start()
	{
		return SUCCESS;
	}
	
	command error_t ClockSync.stop()
	{
		return SUCCESS;
	}
	
	

	command bool ClockSync.isSynchornized()
	{
		/* used for test */
		if (m_sync_dsn != CLOCKSYNC_INVALID_DSN)
		{
			// LED_BLUE_ON;
		}
		else
		{
			// LED_BLUE_OFF;
		}
		
		atomic return (m_sync_dsn != CLOCKSYNC_INVALID_DSN);
	}
	


	event void UnsleepClock.cpuWakeup()
	{
	}
	
	/*=============*/
	

	/*=============*/

	default event void ClockSync.syncFired(bool unsyncBefore) {}
	default event void ClockSync.requestSyncDone(error_t result) {}
	default event void ClockSync.sourceBroadcastDone(error_t result) {}
}

