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
	components MainC;  /* TinyOS2��ģ�飬�������ڹ���ϵͳ���� */

	/** RFDemoģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	*/
	App.Boot -> MainC.Boot;
	
	components HalFlashC;
	App.HalFlash -> HalFlashC;
}


