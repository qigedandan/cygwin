/*************************************************
*	FUNCTION NAME : LedMasterC.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/


configuration LedMasterC
{
}
implementation
{
	/* LEDģ������Boot�ӿ���ϵͳBoot�ӿ�
	*  ��������ϵͳ����ʱ�����LedM��Boot�ӿ�
	*/
	components MainC;  							//TinyOS2��ģ�飬�������ڹ���ϵͳ���� 
	components LedMasterM;
	LedMasterM.Boot -> MainC.Boot;

	/* LEDģ������п��ƴ�����tinyos�ṩ
	*  �Ľӿ������
	*/
	components HplCC2430DmaUart0C;
	LedMasterM.UartStdControl -> HplCC2430DmaUart0C;
	LedMasterM.UartStream -> HplCC2430DmaUart0C;
	
	/*���Ϣ���*/
	components ActiveMessageC;
	LedMasterM.RFControl -> ActiveMessageC;
	LedMasterM.Packet -> ActiveMessageC;
	LedMasterM.AMPacket -> ActiveMessageC;
		
	/**ʹ��ϵͳ���뼶Timer����½���һ����ʱ��
	*	���ҽӿڹ�����TimerLedM����ģ��
	*/
	components new TimerMilliC() as Timer;
	LedMasterM.Timer -> Timer;
	components new TimerMilliC() as Timer1;
	LedMasterM.Timer1 -> Timer1;		
	
	#define AM_DATA_TYPE 220
	LedMasterM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	LedMasterM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
