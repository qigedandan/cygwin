/*************************************************
*	FUNCTION NAME : FlashM.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/* 定义调试级别，参加Makefile的ADBG_LEVEL定义，设置大于等于ADBG_LEVEL */
#define DBG_LEV	9
module FlashM
{
	uses interface Boot;
	uses interface HalFlash;
}
implementation
{
	uint8_t ieee[8] = {0};
	uint8_t ieee2[8] = {0xFF,0xFF,0xFF,1,0xFF,0xFF,0xFF,1};

	
	task void initTask()
	{
		uint8_t i;
		ADBG(DBG_LEV, "read now \n");

		call HalFlash.erase((uint8_t*)0x1fff8);
		for (i=0; i < 8; i+=4)
		{
			call HalFlash.write((uint8_t*)(0x1FFF8+i), (ieee2+i), 4);
		}
		
		call HalFlash.read(ieee, (uint8_t *)0x1FFF8, 8);
		ADBG(DBG_LEV, "read ok.\n");
		for (i=0; i < sizeof(ieee); ++i)
		{
			ADBG(DBG_LEV, "ieee[%d]=%d\n", (int)i, (int)ieee[i]);
		}

	}	
	
	event void Boot.booted()
	{
		ADBG(DBG_LEV, "Boot.booted\n");
		post initTask();
	}
}


