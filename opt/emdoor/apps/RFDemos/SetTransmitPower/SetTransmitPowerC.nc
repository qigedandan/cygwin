/*************************************************
*	FUNCTION NAME : SetTransmintPowerC.nc
*	FUNCTION DESCRIPTION : 射频通信发射功率设置
*	FUCNTION DATE :2010/10/18
*	FUNCTION AUTHOR: EMDOOR
**/

configuration SetTransmitPowerC{

}
implementation
{
	components SetTransmitPowerM;
	components MainC;
	SetTransmitPowerM.Boot -> MainC;
	
	components LedsC;
	SetTransmitPowerM.Leds -> LedsC;

	components ActiveMessageC;

	SetTransmitPowerM.RFControl -> ActiveMessageC;
	SetTransmitPowerM.AMPacket -> ActiveMessageC;
	SetTransmitPowerM.Packet -> ActiveMessageC;

	#define AM_DATA_TYPE 124
	SetTransmitPowerM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	SetTransmitPowerM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];

	components CC2420TransmitC;

	SetTransmitPowerM.GlobalTXPower -> CC2420TransmitC;

	components PlatformSerialC;

	SetTransmitPowerM.UartStdControl -> PlatformSerialC;
	SetTransmitPowerM.UartStream -> PlatformSerialC;
}

	