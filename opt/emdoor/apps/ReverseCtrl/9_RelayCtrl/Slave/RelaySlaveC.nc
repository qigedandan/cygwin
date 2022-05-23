/*************************************************
*	FUNCTION NAME : RelaySlaveC.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

configuration RelaySlaveC
{
}
implementation
{
	components RelaySlaveM;
	/* LED模块程序的Boot接口与系统Boot接口
	*  关联这样系统启动时会调用RelayM的Boot接口
	*/
	components MainC;  							//TinyOS2主模块，这里用于关联系统启动 	
	RelaySlaveM.Boot -> MainC.Boot;
	
	/*串口相关*/	
	components HplCC2430DmaUart0C;
	RelaySlaveM.UartStdControl -> HplCC2430DmaUart0C;
	RelaySlaveM.UartStream -> HplCC2430DmaUart0C;
	
	/*活动消息组件*/
	components ActiveMessageC;
	RelaySlaveM.RFControl -> ActiveMessageC;
	RelaySlaveM.Packet -> ActiveMessageC;	
	RelaySlaveM.AMPacket -> ActiveMessageC;
		
	/**使用系统毫秒级Timer组件新建第一个定时器
	*	并且接口关联到TimerRelayM处理模块
	*/
	components new TimerMilliC() as Timer;
	RelaySlaveM.Timer -> Timer;

	components new TimerMilliC() as Timer1;
	RelaySlaveM.Timer1 -> Timer1;	
	
	components RelayC;
	RelaySlaveM.Relay -> RelayC;

	#define AM_DATA_TYPE 220
	RelaySlaveM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	RelaySlaveM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
