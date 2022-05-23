#include "DebuggerStep.h"
#include "DebuggerLog.h"

module TimerRTCP
{
	provides interface Init;
	provides interface TimerRTC;
	uses interface Alarm<T32khz, uint32_t> as Alarm;

	uses interface Init as SubInit;
}
implementation
{
	/*======================*/

	#define MAX_TIME	(0xFFFFFFFF / 32)

	timerrtc_time_t m_current_time_counter = 0;

	timerrtc_time_t m_old_time = 0;	
	timerrtc_time_t m_current_time = 0;
	timerrtc_time_t m_update_rate = 1; /**/
	timerrtc_time_t m_this_update = 1;
	timerrtc_time_t m_alarm_time = 0;
	
	bool m_alarm_fired = FALSE;
	bool m_alarm_set = FALSE;

	uint32_t m_counter_value = 0;
	

	/*======================*/

	void setNextUpdate()
	{
		DBGER_STEP(4, 10);
		m_this_update = m_update_rate;

		if ((m_current_time < m_alarm_time)
		&&((m_current_time + m_update_rate) > m_alarm_time)
		)
		{
			m_this_update = m_alarm_time - m_current_time;
			if (m_this_update <= 0)
			{
				m_this_update = m_update_rate;
			}
		}

		//m_counter_value = call Alarm.getNow();
		call Alarm.start(m_this_update * 32);
		DBGER_STEP(4, 11);
	}

	bool checkAlarmFired()
	{
		DBGER_STEP(4, 20);
		if (m_alarm_set && !m_alarm_fired
		&& /*
			((
				(m_current_time >= m_alarm_time) && (m_old_time < m_alarm_time)
			)
			||
			(
				(m_current_time <= m_alarm_time) && (m_old_time > m_alarm_time)
			))*/
			(
			((m_current_time >= m_old_time) && (m_alarm_time >= m_old_time) && (m_alarm_time <= m_current_time))
			||
			((m_current_time < m_old_time) && ((m_alarm_time >= m_old_time) || (m_alarm_time <= m_current_time)))
			)
			
		)
		{
			DBGER_STEP(4, 21);
			m_alarm_fired = TRUE;
			return TRUE; /**/
		}

		DBGER_STEP(4, 22);

		return FALSE;
	}

	/*======================*/

	command error_t Init.init()
	{
		DBGER_STEP(4, 30);
		call SubInit.init();

		m_counter_value = call Alarm.getNow();
		setNextUpdate();

		DBGER_STEP(4, 31);

		return SUCCESS;
	}


	command timerrtc_time_t TimerRTC.getTime()
	{
		atomic return m_current_time;
	}
	
	command timerrtc_time_t TimerRTC.getAlarmTime()
	{
		atomic return m_alarm_time;
	}

	
	command void TimerRTC.setTime(timerrtc_time_t time)
	{
		DBGER_STEP(4, 40);
		atomic m_current_time= time % MAX_TIME;
		atomic m_current_time_counter = m_current_time*32;
	}


	command void TimerRTC.setUpdateRate(timerrtc_time_t time)
	{
		DBGER_STEP(4, 50);
		atomic m_update_rate = time;

		setNextUpdate();
	}

	
	command void TimerRTC.setAlarmTime(timerrtc_time_t time)
	{
		DBGER_STEP(4, 60);
		atomic {
			m_alarm_time = time % MAX_TIME;
			m_alarm_fired = FALSE;
			m_alarm_set = TRUE;
		}
	}

	
	command void TimerRTC.setAlarmPeriod(timerrtc_time_t period)
	{
		DBGER_STEP(4, 70);
		atomic {
			m_alarm_time = (m_current_time + period) % MAX_TIME;
			m_alarm_fired = FALSE;
			m_alarm_set = TRUE;
		}
	}
	

	
	default event void TimerRTC.alarmFired() {}
	default event void TimerRTC.updateFired() {}

	/*======================*/
	task void alarmTask()
	{
		DBGER_STEP(4, 80);
		signal TimerRTC.alarmFired();
	}
	
	async event void Alarm.fired()
	{
		DBGER_STEP(4, 90);
		atomic
		{
			uint32_t counter_value = call Alarm.getNow();

			m_old_time = m_current_time;
			
			if (counter_value >= m_counter_value)
			{
				//m_current_time += (counter_value - m_counter_value) / 32;
				m_current_time_counter += (counter_value - m_counter_value);
			}
			else
			{
				// FIXME, JUST FOR CC2430 24bit sleep timer 
				ADBG(10, "counter_value=%ld, m_counter_value=%ld, m_current_time=%ld\n", counter_value, m_counter_value, m_current_time);
				//m_current_time += (0xFFFFFF - m_counter_value + counter_value) / 32;
				m_current_time_counter += (0xFFFFFF - m_counter_value + counter_value);
			}

			m_counter_value = counter_value;
			m_current_time = m_current_time_counter / 32;
	
			//atomic m_current_time += m_this_update;
			ADBG(10, "m_counter_value=%ld, m_current_time=%ld, m_old_time=%ld, m_alarm_time=%ld\n", m_counter_value, m_current_time, m_old_time, m_alarm_time);

			setNextUpdate();
		}

		DBGER_STEP(4, 91);
	
		if (checkAlarmFired())
		{
			DBGER_STEP(4, 92);
			//post alarmTask();
			signal TimerRTC.alarmFired();
		}

		signal TimerRTC.updateFired();

		DBGER_LOG(0, "RTC %d", call TimerRTC.getTime());
	}


	command timerrtc_time_t TimerRTC.getUpdateRate()
	{
		return m_update_rate;
	}
}

