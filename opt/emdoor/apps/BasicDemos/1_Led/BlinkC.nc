/*************************************************
*	FUNCTION NAME : BlinkC.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/


configuration BlinkC
{
}
implementation
{
	components BlinkM;  						//LED模块程序，用于实现LED代码
	components LedsC;
	components MainC;  							//TinyOS2主模块，这里用于关联系统启动 
	
	/* LED模块程序中控制LED的IO与tinyos提供
	*  的接口相关联
	*/
	BlinkM.Leds -> LedsC;
	
	/* LED模块程序的Boot接口与系统Boot接口
	*  关联这样系统启动时会调用LedM的Boot接口
	*/
	BlinkM.Boot -> MainC.Boot;
}
