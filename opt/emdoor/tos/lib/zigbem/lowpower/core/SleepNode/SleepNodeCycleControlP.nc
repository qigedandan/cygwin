
module SleepNodeCycleControlP
{
	provides interface SleepNodeCycleControl;

	uses interface SplitControl as RadioControl;

	uses interface ClockSync;
	uses interface SleepNodeCoreControl;

	/* cycle process */
	uses interface CycleNodeUnsync;
	uses interface CycleNodeSync;
}
implementation
{
	void cycleStarted()
	{
		ADBG(DBG_LEV, "cycleStarted()\n");

		if (call ClockSync.isSynchornized())
		{
			ADBG(DBG_LEV, "\n\n+++++++CycleNodeSync.begin()\n");
			call CycleNodeSync.begin();
		}
		else
		{
			ADBG(DBG_LEV, "\n\n+++++++CycleNodeUnsync.begin()\n");
			call CycleNodeUnsync.begin();
		}
	}

	void radioStarted()
	{
		ADBG(DBG_LEV, "radioStarted()\n");

		cycleStarted();
	}

	void radioStopped()
	{
		ADBG(DBG_LEV, "radioStopped()\n");

		signal SleepNodeCycleControl.end();
	}

	task void startRadio()
	{
		/* At first start radio */
		error_t result = call RadioControl.start();

		if (result == EALREADY)
		{
			radioStarted();
		}
		else if (result == EBUSY)
		{/* FIXME: should I try again?? */
			post startRadio();
		}
	}

	task void stopRadio()
	{/* At first start radio */
		error_t result;
		atomic
		{
			if (call SleepNodeCoreControl.isBusy())
			{
				ADBG(DBG_LEV, " (<>)()()() busy when stopRadio?!!!\n");
				return;
			}
		}

		ADBG(DBG_LEV, " (<>)()()() stopingRadio!!!\n");
		
		result = call RadioControl.stop();

		if (result == EALREADY)
		{
			radioStopped();
		}
		else if (result == EBUSY)
		{/* FIXME: should I try again?? */
			post stopRadio();
		}
	}

	void beginCycle()
	{
		post startRadio();
	}

	void endCycle()
	{/* end cycle */
		post stopRadio();
	}

	command error_t SleepNodeCycleControl.begin()
	{
		beginCycle();
		return SUCCESS;
	}

	command timerrtc_time_t SleepNodeCycleControl.getSleepTime()
	{
		if (call ClockSync.isSynchornized())
		{
			return call CycleNodeSync.getSleepTime();
		}
		else
		{
			return call CycleNodeUnsync.getSleepTime();
		}
	}
	
	default event void SleepNodeCycleControl.end() { }


	/*=======*/
	event void SleepNodeCoreControl.busy()
	{
	}
	
	event void SleepNodeCoreControl.free()
	{
		ADBG(DBG_LEV, "@@@@@SleepNodeCoreControl.free\n");
		endCycle();
	}

	/*=======*/
	event void RadioControl.startDone(error_t result)
	{
		if (result == SUCCESS)
		{
			radioStarted();
		}
		else
		{/* FIXME: should I try again?? */
			post startRadio();
		}
	}

	event void RadioControl.stopDone(error_t result)
	{
		if (result == SUCCESS)
		{
			radioStopped();
		}
		else
		{/* FIXME: should I try again?? */
			post stopRadio();
		}
	}

	/*===*/
	event void ClockSync.syncFired(bool unsyncBefore)
	{
	}
	
	event void ClockSync.requestSyncDone(error_t result)
	{
	}
	
	event void ClockSync.sourceBroadcastDone(error_t result)
	{
	}

	/*======*/
	event void CycleNodeUnsync.end(uint8_t result)
	{
	}
	
	event void CycleNodeSync.end(uint8_t result)
	{
	}
}

