/*************************************************
*	FUNCTION NAME : RSSISampleM.nc
*	FUNCTION DESCRIPTION : RSSI �ɼ�
*	FUCNTION DATE :2010/10/18
*	FUNCTION AUTHOR: EMDOOR
**/

configuration RSSISampleC
{
}
implementation
{
	components RSSISampleM;
	components MainC; //Main���
	RSSISampleM.Boot -> MainC;
	
	components LedsC;
	RSSISampleM.Leds -> LedsC;

	/*���Ϣ���*/
	components ActiveMessageC;

	RSSISampleM.Packet -> ActiveMessageC;
	RSSISampleM.AMPacket -> ActiveMessageC;
	RSSISampleM.RFControl -> ActiveMessageC;

	#define AM_DATA_TYPE  123
	RSSISampleM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	RSSISampleM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];

	components CC2420PacketC;

	RSSISampleM.CC2420Packet -> CC2420PacketC;

	components new TimerMilliC();

	RSSISampleM.Timer -> TimerMilliC;
}
