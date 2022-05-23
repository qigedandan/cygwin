/*************************************************
*	FUNCTION NAME : TimerLed.nc
*	FUNCTION DESCRIPTION : 定时器间隔点亮两个LED灯
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration TimerLed
{
}
implementation
{
	components TimerLedM;  /* TimerLed模块程序，用于实现具体代码 */
	components MainC;      /* TinyOS主模块，这里用于关联系统启动 */
	components LedsC;	   /* TinyOS 提供的LED模块 */

	/* TimerLed模块程序的Boot接口与系统Boot接口关联
	*  这样系统启动时会调用LedM的Boot接口
	*/
	TimerLedM.Boot -> MainC.Boot;
	
	/* LED模块程序中控制LED的IO与tinyos提供
	*  的接口相关联
	*/
	TimerLedM.Leds -> LedsC;

	/**
	*	使用系统毫秒级Timer组件新建第一个定时器
	*	并且接口关联到TimerLedM处理模块
	*/
	components new TimerMilliC() as Timer1;
	TimerLedM.Timer1 -> Timer1;	
	
	/**
		使用系统毫秒级Timer组件新建第二个定时器
	*/
	components new TimerMilliC() as Timer2;
	TimerLedM.Timer2 -> Timer2;
	
}
