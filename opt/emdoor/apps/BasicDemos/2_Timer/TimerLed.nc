/*************************************************
*	FUNCTION NAME : TimerLed.nc
*	FUNCTION DESCRIPTION : ��ʱ�������������LED��
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration TimerLed
{
}
implementation
{
	components TimerLedM;  /* TimerLedģ���������ʵ�־������ */
	components MainC;      /* TinyOS��ģ�飬�������ڹ���ϵͳ���� */
	components LedsC;	   /* TinyOS �ṩ��LEDģ�� */

	/* TimerLedģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	*  ����ϵͳ����ʱ�����LedM��Boot�ӿ�
	*/
	TimerLedM.Boot -> MainC.Boot;
	
	/* LEDģ������п���LED��IO��tinyos�ṩ
	*  �Ľӿ������
	*/
	TimerLedM.Leds -> LedsC;

	/**
	*	ʹ��ϵͳ���뼶Timer����½���һ����ʱ��
	*	���ҽӿڹ�����TimerLedM����ģ��
	*/
	components new TimerMilliC() as Timer1;
	TimerLedM.Timer1 -> Timer1;	
	
	/**
		ʹ��ϵͳ���뼶Timer����½��ڶ�����ʱ��
	*/
	components new TimerMilliC() as Timer2;
	TimerLedM.Timer2 -> Timer2;
	
}
