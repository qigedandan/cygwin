/*************************************************
*	FUNCTION NAME : PowerModeM.nc
*	FUNCTION DESCRIPTION :模式示例程序
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/*定义调试级别*/
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
	/*设置休眠模式*/
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
			ADBG(DBG_LEV, "\r\n节点退出Powermode 1\r\n3秒后进入Powermode2\r\n");
			call Timer.startOneShot(3000);
		}
		else if(power_mode == CC2430_SLEEP_POWERMODE_2)
		{
			ADBG(DBG_LEV, "\r\n节点退出Powermode 2\r\n结束\r\n");
		}
	}

	void sleep(uint8_t mode)
	{
		SET_POWER_MODE(mode);

		before_sleep();

		call SleepAlarm.start(3*32768); //设置休眠时间

		__nesc_enable_interrupt(); 			//开中断

		PCON = 0x01; 					//进入休眠模式

		after_wakeup(); 				//定时器定时结束，将MCU 唤醒，继续执行下面的代码
	}

	task void initialTask()
	{
		power_mode = CC2430_SLEEP_POWERMODE_0;
		
		call Timer.startOneShot(3000);
	}		

	event void Boot.booted()
	{
		ADBG(DBG_LEV, "\r\n###############################################\r\n");
		ADBG(DBG_LEV, "   [POWERMODE DEMO] 节点启动完毕\r\n");
		ADBG(DBG_LEV, "###############################################\r\n");

		ADBG(DBG_LEV, "\r\n节点当前处于PowerMode 0\r\n3 秒后进入PowerMode 1\r\n");
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
