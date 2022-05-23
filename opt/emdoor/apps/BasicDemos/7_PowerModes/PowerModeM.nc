/*************************************************
*	FUNCTION NAME : PowerModeM.nc
*	FUNCTION DESCRIPTION :ģʽʾ������
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/*������Լ���*/
#define DBG_LEV 1000
module PowerModeM
{
	uses {
		interface Boot;
		interface Timer<TMilli>;
		interface Alarm<T32khz, uint32_t> as SleepAlarm; //Sleep Timer
	}
}
implementation
{
	/*��������ģʽ*/
	#define SET_POWER_MODE(mode) { \
		SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) |mode; \ 
	}

	uint8_t power_mode;

	void before_sleep()
	{
		if(power_mode == CC2430_SLEEP_POWERMODE_1)
		{
			ADBG(DBG_LEV, "\r\nPowermode 1\r\n(Wait 3 sec)\r\n");
		}
		else if(power_mode == CC2430_SLEEP_POWERMODE_2)
		{
			ADBG(DBG_LEV, "\r\nPowermode 2\r\n(Wait 3 sec)\r\n");
		}
	}

	void after_wakeup()
	{
		if(power_mode == CC2430_SLEEP_POWERMODE_1)
		{
			ADBG(DBG_LEV, "\r\n�ڵ��˳�Powermode 1\r\n3������Powermode2\r\n");
			call Timer.startOneShot(3000);
		}
		else if(power_mode == CC2430_SLEEP_POWERMODE_2)
		{
			ADBG(DBG_LEV, "\r\n�ڵ��˳�Powermode 2\r\n����\r\n");
		}
	}

	void sleep(uint8_t mode)
	{
		SET_POWER_MODE(mode);

		before_sleep();

		call SleepAlarm.start(3*32768); //��������ʱ��

		__nesc_enable_interrupt(); 			//���ж�

		PCON = 0x01; 					//��������ģʽ

		after_wakeup(); 				//��ʱ����ʱ��������MCU ���ѣ�����ִ������Ĵ���
	}

	task void initialTask()
	{
		power_mode = CC2430_SLEEP_POWERMODE_0;
		
		call Timer.startOneShot(3000);
	}		

	event void Boot.booted()
	{
		ADBG(DBG_LEV, "\r\n###############################################\r\n");
		ADBG(DBG_LEV, "   [POWERMODE DEMO] �ڵ��������\r\n");
		ADBG(DBG_LEV, "###############################################\r\n");

		ADBG(DBG_LEV, "\r\n�ڵ㵱ǰ����PowerMode 0\r\n3 ������PowerMode 1\r\n");
		post initialTask();		
	}

	event void Timer.fired()
	{		
		power_mode ++;
		sleep(power_mode);
	}

	async event void SleepAlarm.fired()
	{		
	}
	
}
