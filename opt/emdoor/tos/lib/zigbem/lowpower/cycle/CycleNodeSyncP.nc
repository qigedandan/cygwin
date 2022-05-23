
module CycleNodeSyncP
{
	provides interface CycleNodeSync;
	provides interface CycleNodeSyncData;

	uses interface ClockSync;
	uses interface UnsleepClock;

	uses interface Timer<TMilli> as SyncTimer;
	uses interface CoreControlOwner;
}
implementation
{
#ifndef SLEEPNODE_SYNC_SLEEP
#define SLEEPNODE_SYNC_SLEEP		20000
#endif

#ifndef SLEEPNODE_SYNC_WAKEUP
#define SLEEPNODE_SYNC_WAKEUP	10000
#endif

#define SLEEPNODE_SYNC_CYCLE		(SLEEPNODE_SYNC_SLEEP + SLEEPNODE_SYNC_WAKEUP)

#define SLEEPNODE_SYNC_WAIT_LEN	1000
#define SLEEPNODE_SYNC_WAIT_END	SLEEPNODE_SYNC_WAIT_LEN
		
#define SLEEPNODE_SYNC_TIME_LEN	1000
#define SLEEPNODE_SYNC_TIME_END	(SLEEPNODE_SYNC_WAIT_END + SLEEPNODE_SYNC_TIME_LEN)

#define SLEEPNODE_SYNC_ROUTE_LEN	1000
#define SLEEPNODE_SYNC_ROUTE_END (SLEEPNODE_SYNC_TIME_END + SLEEPNODE_SYNC_ROUTE_LEN)

#define SLEEPNODE_SYNC_DATA_LEN	(SLEEPNODE_SYNC_WAKEUP-SLEEPNODE_SYNC_ROUTE_LEN-SLEEPNODE_SYNC_TIME_LEN-SLEEPNODE_SYNC_WAIT_LEN)
#define SLEEPNODE_SYNC_DATA_END (SLEEPNODE_SYNC_ROUTE_END + SLEEPNODE_SYNC_DATA_LEN)

	enum
	{
		CORE_CONTROL_DATA,
		CORE_CONTROL_TIME,
	};

	enum
	{
		SYNC_DATA_NON,
		SYNC_DATA_STARTED,
		SYNC_DATA_END,
	};

	uint8_t m_data_status = SYNC_DATA_NON;
	
	
	/*=======================*/
	/*Synchornized*/
	void syncEnd()
	{
		call CoreControlOwner.setFree(CORE_CONTROL_TIME);
	}
	
	task void syncProcess()
	{
		atomic
		{
			timerrtc_time_t cycle_time = call UnsleepClock.getClockTime() % SLEEPNODE_SYNC_CYCLE;
			uint32_t stage_time = 0;

			ADBG(4000, "\n -- syncProcess()##clock =%ld, cycle time = %ld\n", call UnsleepClock.getClockTime(), cycle_time);

			if (cycle_time < SLEEPNODE_SYNC_WAIT_END)
			{
				ADBG(4000, "##SLEEPNODE_SYNC_WAIT_END\n");
				//
				stage_time= SLEEPNODE_SYNC_WAIT_END - cycle_time;
			}
			else if (cycle_time < SLEEPNODE_SYNC_TIME_END)
			{
				ADBG(4000, "##SLEEPNODE_SYNC_TIME_END\n");
				stage_time= SLEEPNODE_SYNC_TIME_END - cycle_time;
			}
			else if (cycle_time < SLEEPNODE_SYNC_ROUTE_END)
			{
				ADBG(4000, "##SLEEPNODE_SYNC_ROUTE_END\n");
				stage_time= SLEEPNODE_SYNC_ROUTE_END - cycle_time + TOS_NODE_ID*100;
			}
			else if (cycle_time < SLEEPNODE_SYNC_DATA_END)
			{
				ADBG(4000, "##SLEEPNODE_SYNC_DATA_END\n");
				stage_time= SLEEPNODE_SYNC_DATA_END - cycle_time;

				if (m_data_status == SYNC_DATA_NON)
				{
					m_data_status = SYNC_DATA_STARTED;
					call CoreControlOwner.setBusy(CORE_CONTROL_DATA);
					signal CycleNodeSyncData.readDataFired();
				}
			}

			if (cycle_time < SLEEPNODE_SYNC_DATA_END)
			{
				ADBG(4000, "##stage_time=%ld\n", stage_time);
				if (stage_time <= 10)
				{/* min time to process */
					stage_time = 10;
				}
				
				call SyncTimer.startOneShot(stage_time);
			}
			else
			{/* end of the cycle */
				syncEnd();
			}
		}
	}

	event void SyncTimer.fired()
	{
		post syncProcess();
	}



	/*=======================*/
	event void ClockSync.syncFired(bool unsyncBefore)
	{
	}

	event void ClockSync.requestSyncDone(error_t result)
	{
	}
	
	event void ClockSync.sourceBroadcastDone(error_t result)
	{
	}
	
	/*=======================*/

	event void UnsleepClock.cpuWakeup()
	{
	}
	
	/*=======================*/
	command void CycleNodeSync.begin()
	{
		/* preprocess */
		m_data_status = SYNC_DATA_NON;

		/*  */
	
		call CoreControlOwner.setBusy(CORE_CONTROL_TIME);

		post syncProcess();
	}
	
	command void CycleNodeSyncData.readDataFinished()
	{
		m_data_status = SYNC_DATA_END;
		call CoreControlOwner.setFree(CORE_CONTROL_DATA);
	}

	command timerrtc_time_t CycleNodeSync.getSleepTime()
	{
		/* return the rest of the total cycle time to sleep */
		atomic
		{
			timerrtc_time_t cycle_time = call UnsleepClock.getClockTime() % SLEEPNODE_SYNC_CYCLE;

			ADBG(DBG_LEV, "CycleNodeSync.getSleepTime SLEEPNODE_SYNC_CYCLE=%ld, cycle_time = %ld, SLEEPNODE_SYNC_CYCLE - cycle_time=%ld\n", SLEEPNODE_SYNC_CYCLE, cycle_time, SLEEPNODE_SYNC_CYCLE - cycle_time);
			
			return SLEEPNODE_SYNC_CYCLE - cycle_time;
		}
	}
	
	default event void CycleNodeSyncData.readDataFired() {}
	default event void CycleNodeSync.end(uint8_t result) {}
	
}

