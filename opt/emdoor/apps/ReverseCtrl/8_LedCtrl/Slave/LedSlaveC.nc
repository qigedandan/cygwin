/*************************************************
*	FUNCTION NAME : LedSlaveC.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

configuration LedSlaveC
{
}
implementation
{
	components LedSlaveM;
	/* LED模块程序的Boot接口与系统Boot接口
	*  关联这样系统启动时会调用LedM的Boot接口
	*/
	components MainC;  							//TinyOS2主模块，这里用于关联系统启动 	
	LedSlaveM.Boot -> MainC.Boot;
	
	/*串口相关*/	
	components HplCC2430DmaUart0C;
	LedSlaveM.UartStdControl -> HplCC2430DmaUart0C;
	LedSlaveM.UartStream -> HplCC2430DmaUart0C;
	
	/*活动消息组件*/
	components ActiveMessageC;
	LedSlaveM.RFControl -> ActiveMessageC;
	LedSlaveM.Packet -> ActiveMessageC;	
	LedSlaveM.AMPacket -> ActiveMessageC;
		
	/**使用系统毫秒级Timer组件新建第一个定时器
	*	并且接口关联到TimerLedM处理模块
	*/
	components new TimerMilliC() as Timer;
	LedSlaveM.Timer -> Timer;
	
	//用于定时上传自身信息的定时器
	components new TimerMilliC() as Timer1;
	LedSlaveM.Timer1 -> Timer1;
	
	components LedsC;
	LedSlaveM.Leds -> LedsC;

	#define AM_DATA_TYPE 220
	LedSlaveM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	LedSlaveM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
