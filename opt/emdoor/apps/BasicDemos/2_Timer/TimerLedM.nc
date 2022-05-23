/*************************************************
*	FUNCTION NAME : TimerLedM.nc
*	FUNCTION DESCRIPTION : 定时器间隔点亮两个LED灯
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#define DBG_LEV 5
module TimerLedM
{
	uses interface Boot;
	uses interface Leds;

	/* Timer为系统接口TMilli指明了定时器的精度为毫秒 */
	uses interface Timer<TMilli> as Timer1;  /* as关键字为接口别名 */
	uses interface Timer<TMilli> as Timer2;
}
implementation
{
	/** 任务:  切换黄色LED灯 */
	task void ToggleLedGreen()
	{
		call Leds.YellowLedToggle();
	}

	/**  启动事件处理函数，在TimerLed.nc已经关联到MainC.Boot接口
		系统启动后会调用此函数
	*/
	event void Boot.booted()
	{
		/** 定时器1: 持续工作，每隔1s触发一次 */
		call Timer1.startPeriodic(1000);
		/** 定时器2: 持续工作，每隔3s触发一次*/
		call Timer2.startPeriodic(5000);
	}

	/** 定时器1的事件处理函数 */
	event void Timer1.fired()
	{
		/** 事件处理中直接切换蓝色LED灯 */
		ADBG(5, "led blue toggle.\r\n");
		call Leds.BlueLedToggle();;
	}

	/** 定时器2的事件处理函数 */
	event void Timer2.fired()
	{
		
		ADBG(5, "led yellow toggle.\r\n");
		post ToggleLedGreen();
	}
}

