/*************************************************
*	FUNCTION NAME : P2PC.nc
*	FUNCTION DESCRIPTION : ��Ե���Ƶͨ��
*	FUCNTION DATE :2010/10/18
*	FUNCTION AUTHOR: EMDOOR
**/

configuration P2PC
{
}
implementation
{
	components P2PM;
	components MainC;
	P2PM.Boot -> MainC.Boot;
	
	components LedsC;
	P2PM.Leds -> LedsC;

	/* �����շ����*/
	components PlatformSerialC;
	P2PM.UartStdControl -> PlatformSerialC;
	P2PM.UartStream -> PlatformSerialC;

	/*���Ϣ���*/
	components ActiveMessageC;
	P2PM.RFControl -> ActiveMessageC;
	P2PM.AMPacket -> ActiveMessageC;
	P2PM.Packet -> ActiveMessageC;

	#define AM_DATA_TYPE 220

	P2PM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	P2PM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
