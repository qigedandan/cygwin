/*************************************************
*	FUNCTION NAME : LedSlaveC.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

configuration LedSlaveC
{
}
implementation
{
	components LedSlaveM;
	/* LEDģ������Boot�ӿ���ϵͳBoot�ӿ�
	*  ��������ϵͳ����ʱ�����LedM��Boot�ӿ�
	*/
	components MainC;  							//TinyOS2��ģ�飬�������ڹ���ϵͳ���� 	
	LedSlaveM.Boot -> MainC.Boot;
	
	/*�������*/	
	components HplCC2430DmaUart0C;
	LedSlaveM.UartStdControl -> HplCC2430DmaUart0C;
	LedSlaveM.UartStream -> HplCC2430DmaUart0C;
	
	/*���Ϣ���*/
	components ActiveMessageC;
	LedSlaveM.RFControl -> ActiveMessageC;
	LedSlaveM.Packet -> ActiveMessageC;	
	LedSlaveM.AMPacket -> ActiveMessageC;
		
	/**ʹ��ϵͳ���뼶Timer����½���һ����ʱ��
	*	���ҽӿڹ�����TimerLedM����ģ��
	*/
	components new TimerMilliC() as Timer;
	LedSlaveM.Timer -> Timer;
	
	//���ڶ�ʱ�ϴ�������Ϣ�Ķ�ʱ��
	components new TimerMilliC() as Timer1;
	LedSlaveM.Timer1 -> Timer1;
	
	components LedsC;
	LedSlaveM.Leds -> LedsC;

	#define AM_DATA_TYPE 220
	LedSlaveM.AMSend -> ActiveMessageC.AMSend[AM_DATA_TYPE];
	LedSlaveM.Receive -> ActiveMessageC.Receive[AM_DATA_TYPE];
}
