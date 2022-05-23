/*************************************************
*	FUNCTION NAME : RelaySlaveC.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

configuration RelaySlaveC
{
}
implementation
{
	components RelaySlaveM;
	/* LEDģ������Boot�ӿ���ϵͳBoot�ӿ�
	*  ��������ϵͳ����ʱ�����RelayM��Boot�ӿ�
	*/
	components MainC;  							//TinyOS2��ģ�飬�������ڹ���ϵͳ���� 	
	RelaySlaveM.Boot -> MainC.Boot;
	
	/*�������*/	
	components HplCC2430DmaUart0C;
	RelaySlaveM.UartStdControl -> HplCC2430DmaUart0C;
	RelaySlaveM.UartStream -> HplCC2430DmaUart0C;
	
	/*���Ϣ���*/
	components ActiveMessageC;
	RelaySlaveM.RFControl -> ActiveMessageC;
	RelaySlaveM.Packet -> ActiveMessageC;	
	RelaySlaveM.AMPacket -> ActiveMessageC;
		
	/**ʹ��ϵͳ���뼶Timer����½���һ����ʱ��
	*	���ҽӿڹ�����TimerRelayM����ģ��
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
