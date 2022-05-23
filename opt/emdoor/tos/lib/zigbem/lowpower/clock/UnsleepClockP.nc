#include "DebuggerStep.h"
module UnsleepClockP
{
	provides interface UnsleepClock;
	uses interface TimerRTC;
	uses interface PowerControl;
}
implementation
{
	timerrtc_time_t m_default_sleep_update_rate = 1000;
	timerrtc_time_t m_default_wakeup_update_rate = 1;
	bool m_sleeping = FALSE;


	void process()
	{
		DBGER_STEP(3, 10);
		if (m_sleeping == TRUE)
		{
			DBGER_STEP(3, 11);
			call PowerControl.sleep();
		}
		DBGER_STEP(3, 12);
	}

	command timerrtc_time_t UnsleepClock.getClockTime()
	{
		DBGER_STEP(3, 20);
		return call TimerRTC.getTime();
	}
	
	command void UnsleepClock.setClockTime(timerrtc_time_t time)
	{
		DBGER_STEP(3, 30);
		call TimerRTC.setTime(time);
	}
	
	command error_t UnsleepClock.sleepCpu(timerrtc_time_t time)
	{
		DBGER_STEP(3, 40);
		call TimerRTC.setAlarmPeriod(time);
		call TimerRTC.setUpdateRate(m_default_sleep_update_rate);
		
		atomic m_sleeping = TRUE;
		process();

		ADBG(DBG_LEV, "UnsleepClock.sleepCpu time=%ld\n##########################\n\n", time);
		
		return SUCCESS;
	}


	event void TimerRTC.updateFired()
	{
		DBGER_STEP(3, 50);
		process();
		/*
		if (m_sleeping)
		{
			ADBG(DBG_LEV, "*TIME=%ld, ALARM=%ld\n", call TimerRTC.getTime(), call TimerRTC.getAlarmTime());
		}*/
	}

	task void wakeupTask()
	{
		DBGER_STEP(3, 60);
		signal UnsleepClock.cpuWakeup();
	}

	event void TimerRTC.alarmFired()
	{
		DBGER_STEP(3, 70);
	/*
		if (m_sleeping)
		{
			ADBG(DBG_LEV, "*TimerRTC.alarmFired()\n");
		}*/
		atomic m_sleeping = FALSE;

		call TimerRTC.setUpdateRate(m_default_wakeup_update_rate);

		post wakeupTask();

		DBGER_STEP(3, 71);
	}
	
	default event void UnsleepClock.cpuWakeup() {}
}

