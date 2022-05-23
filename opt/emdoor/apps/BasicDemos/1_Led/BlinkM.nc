/*************************************************
*	FUNCTION NAME : BlinkM.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
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
			
			call Leds.YellowLedOn();		//黄色LED亮
			call Leds.RedLedOff();		//红色LED亮
			
			for(i=0;i<1000;i++)
				for(j=0;j<500;j++);
				
			call Leds.YellowLedOff();	//黄色LED灭
			call Leds.RedLedOn();		//红色LED亮
		}
	}

	/**  启动事件处理函数，在LED.nc已经关联到MainC.Boot接口
		系统启动后会调用此函数
	*/
	event void Boot.booted() {		
		post DemoLed();
	}	
}

