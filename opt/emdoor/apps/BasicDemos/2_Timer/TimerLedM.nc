/*************************************************
*	FUNCTION NAME : TimerLedM.nc
*	FUNCTION DESCRIPTION : ��ʱ�������������LED��
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#define DBG_LEV 5
module TimerLedM
{
	uses interface Boot;
	uses interface Leds;

	/* TimerΪϵͳ�ӿ�TMilliָ���˶�ʱ���ľ���Ϊ���� */
	uses interface Timer<TMilli> as Timer1;  /* as�ؼ���Ϊ�ӿڱ��� */
	uses interface Timer<TMilli> as Timer2;
}
implementation
{
	/** ����:  �л���ɫLED�� */
	task void ToggleLedGreen()
	{
		call Leds.YellowLedToggle();
	}

	/**  �����¼�����������TimerLed.nc�Ѿ�������MainC.Boot�ӿ�
		ϵͳ���������ô˺���
	*/
	event void Boot.booted()
	{
		/** ��ʱ��1: ����������ÿ��1s����һ�� */
		call Timer1.startPeriodic(1000);
		/** ��ʱ��2: ����������ÿ��3s����һ��*/
		call Timer2.startPeriodic(5000);
	}

	/** ��ʱ��1���¼������� */
	event void Timer1.fired()
	{
		/** �¼�������ֱ���л���ɫLED�� */
		ADBG(5, "led blue toggle.\r\n");
		call Leds.BlueLedToggle();;
	}

	/** ��ʱ��2���¼������� */
	event void Timer2.fired()
	{
		
		ADBG(5, "led yellow toggle.\r\n");
		post ToggleLedGreen();
	}
}

