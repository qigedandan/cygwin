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
	components MainC;  /* TinyOS主模块，这里用于关联系统启动 */

	/** WatchDogC模块程序的Boot接口与系统Boot接口关联
	*/
	App.Boot -> MainC.Boot;


	components WatchDogC;
	App.WatchDog -> WatchDogC;
}


