/*************************************************
*	FUNCTION NAME : FlashAppC.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration FlashAppC
{
}
implementation
{
	components FlashM as App;  
	components MainC;  /* TinyOS2主模块，这里用于关联系统启动 */

	/** RFDemo模块程序的Boot接口与系统Boot接口关联
	*/
	App.Boot -> MainC.Boot;
	
	components HalFlashC;
	App.HalFlash -> HalFlashC;
}


