/*************************************************
*	FUNCTION NAME : WatchDogM.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/* ������Լ��𣬲μ�Makefile��ADBG_LEVEL���壬���ô��ڵ���ADBG_LEVEL */
#define DBG_LEV	9
module WatchDogM
{
	uses interface Boot;
	uses interface WatchDog;
}
implementation
{
	task void initTask()
	{
		uint16_t i,j;
		
		ADBG(DBG_LEV, "initTask now \n");
		ADBG(DBG_LEV, "wait for restart \n");

		for(i=0;i<2000;i++)
			for(j=0;j<2000;j++);

		ADBG(DBG_LEV, "restart now \n");

		call WatchDog.resetCpu();
	}	
	
	event void Boot.booted()
	{
		ADBG(DBG_LEV, "\nBoot.booted\n");
		post initTask();
	}
}


