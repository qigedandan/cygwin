/*************************************************
*	FUNCTION NAME : WatchDogAppC.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration WatchDogAppC
{
}
implementation
{
	components WatchDogM as App;  
	components MainC;  /* TinyOS��ģ�飬�������ڹ���ϵͳ���� */

	/** WatchDogCģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	*/
	App.Boot -> MainC.Boot;


	components WatchDogC;
	App.WatchDog -> WatchDogC;
}


