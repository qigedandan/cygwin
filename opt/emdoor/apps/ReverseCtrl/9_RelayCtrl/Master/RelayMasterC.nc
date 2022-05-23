/*************************************************
*	FUNCTION NAME : LedMasterC.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/


configuration RelayMasterC
{
}
implementation
{
	/* LED模块程序的Boot接口与系统Boot接口
	*  关联这样系统启动时会调用LedM的Boot接口
	*/
	components MainC;  							//TinyOS2主模块，这里用于关联系统启动 
	components RelayMasterM;
	RelayMasterM.Boot -> MainC.Boot;

	/* LED模块程序中控制串口与tinyos提供
	*  的接口相关联
	*/
	components HplCC2430DmaUart0C;
	RelayMasterM.UartStdControl -> HplCC2430DmaUart0C;
	RelayMasterM.UartStream -> HplCC2430DmaUart0C;
	
	/*活动消息组件*/
	components ActiveMessageC;
	RelayMasterM.RFControl -> ActiveMessageC;
	RelayMasterM.Packet -> ActiveMessageC;
	RelayMasterM.AMPacket -> ActiveMessageC;
		
	/**使用系统毫秒级Timer组件新建第一个定时器
	*	并且接口关联到TimerLedM处理模块
	*/
	components new TimerMilliC() as Timer;
	RelayMasterM.Timer -> Timer;
	components new TimerMilliC() as Timer1;
	RelayMasterM.Timer1 -> Timer1;		
	

	#define AM_DATA_TYPE 220
	RelayMasterM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	RelayMasterM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
