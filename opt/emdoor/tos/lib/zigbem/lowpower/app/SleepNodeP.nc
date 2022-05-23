
module SleepNodeP
{
	provides interface SleepNode;

	uses interface SleepNodeCycleControl;
	uses interface UnsleepClock;
}
implementation
{
	task void wakeupProcess()
	{
		ADBG(DBG_LEV, "\n\n-->wakeupProcess()\n");
		DBGER_STEP(2, 10);
		call SleepNodeCycleControl.begin();
	}

	command void SleepNode.start()
	{
		DBGER_STEP(2, 20);
		post wakeupProcess();
	}

	event void UnsleepClock.cpuWakeup()
	{
		DBGER_STEP(2, 30);
		post wakeupProcess();
	}

	event void SleepNodeCycleControl.end()
	{
		DBGER_STEP(2, 40);
		call UnsleepClock.sleepCpu( call SleepNodeCycleControl.getSleepTime() );
	}
}

