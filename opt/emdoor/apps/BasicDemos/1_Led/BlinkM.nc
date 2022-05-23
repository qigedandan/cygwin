/*************************************************
*	FUNCTION NAME : BlinkM.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

module BlinkM {	
	uses interface Leds;
	uses interface Boot;
}
implementation {
	task void DemoLed()	{
		int i,j;
		
		while(1) {
			for(i=0;i<1000;i++)
				for(j=0;j<500;j++);
			
			call Leds.YellowLedOn();		//��ɫLED��
			call Leds.RedLedOff();		//��ɫLED��
			
			for(i=0;i<1000;i++)
				for(j=0;j<500;j++);
				
			call Leds.YellowLedOff();	//��ɫLED��
			call Leds.RedLedOn();		//��ɫLED��
		}
	}

	/**  �����¼�����������LED.nc�Ѿ�������MainC.Boot�ӿ�
		ϵͳ���������ô˺���
	*/
	event void Boot.booted() {		
		post DemoLed();
	}	
}

