/*************************************************
*	FUNCTION NAME : SetRFChannelC.nc
*	FUNCTION DESCRIPTION : 发射信道设备
*	FUCNTION DATE :2010/10/19
*	FUNCTION AUTHOR: EMDOOR
**/

configuration SetRFChannelC
{
}
implementation
{
	components SetRFChannelM;
	components MainC;
	SetRFChannelM.Boot -> MainC;

	components LedsC;
	SetRFChannelM.Leds -> LedsC;
	
	components ActiveMessageC;

	SetRFChannelM.RFControl -> ActiveMessageC;
	SetRFChannelM.AMPacket -> ActiveMessageC;
	SetRFChannelM.Packet -> ActiveMessageC;

	#define AM_DATA_TYPE 124
	SetRFChannelM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	SetRFChannelM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];

	components CC2420ControlC;

	SetRFChannelM.CC2420Config -> CC2420ControlC;

	components PlatformSerialC;

	SetRFChannelM.UartStdControl -> PlatformSerialC;
	SetRFChannelM.UartStream -> PlatformSerialC;
}

	