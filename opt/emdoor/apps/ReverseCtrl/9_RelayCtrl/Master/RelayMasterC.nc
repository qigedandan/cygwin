/*************************************************
*	FUNCTION NAME : LedMasterC.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/


configuration RelayMasterC
{
}
implementation
{
	/* LEDģ������Boot�ӿ���ϵͳBoot�ӿ�
	*  ��������ϵͳ����ʱ�����LedM��Boot�ӿ�
	*/
	components MainC;  							//TinyOS2��ģ�飬�������ڹ���ϵͳ���� 
	components RelayMasterM;
	RelayMasterM.Boot -> MainC.Boot;

	/* LEDģ������п��ƴ�����tinyos�ṩ
	*  �Ľӿ������
	*/
	components HplCC2430DmaUart0C;
	RelayMasterM.UartStdControl -> HplCC2430DmaUart0C;
	RelayMasterM.UartStream -> HplCC2430DmaUart0C;
	
	/*���Ϣ���*/
	components ActiveMessageC;
	RelayMasterM.RFControl -> ActiveMessageC;
	RelayMasterM.Packet -> ActiveMessageC;
	RelayMasterM.AMPacket -> ActiveMessageC;
		
	/**ʹ��ϵͳ���뼶Timer����½���һ����ʱ��
	*	���ҽӿڹ�����TimerLedM����ģ��
	*/
	components new TimerMilliC() as Timer;
	RelayMasterM.Timer -> Timer;
	components new TimerMilliC() as Timer1;
	RelayMasterM.Timer1 -> Timer1;		
	

	#define AM_DATA_TYPE 220
	RelayMasterM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	RelayMasterM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
