/*************************************************
*	FUNCTION NAME : SerialDebugM.nc
*	FUNCTION DESCRIPTION : 串口调试信息打印
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/* 定义调试级别，参加Makefile的ADBG_LEVEL定义，设置大于等于ADBG_LEVEL */
#define DBG_LEV	9

module SerialDebugM
{
	uses interface Boot;
}
implementation
{
	/** 任务:  通过串口打印信息来调试 */
	task void DebugSerial()
	{
		uint8_t num1 = 0x39;		
		uint32_t num2 = 0x12345678;
		float float1 = 123.1234;
		
		/** ADBG，格式类似于printf,
		*	第一个参数为调试等级，可以参见tos/lib/common/antdebug.h 
		*/
		
		/** 打印字符和字符串 */
		ADBG(DBG_LEV, "\r\n\r\nDEMO of Serial Debug\r\n", 'x');
		ADBG(DBG_LEV, "1. Hello,Welcome to WSN!\r\n", 'x');
		
		/** 打印8位的数字 */
		ADBG(DBG_LEV, "2. NUM1: HEX=0x%x, DEC=%d\r\n", (int)(num1), (int)(num1));
		
		/** 打印32位数字 */
		ADBG(DBG_LEV, "2. NUM2: HEX=0x%lx, DEC=%ld\r\n", (uint32_t)(num2), (uint32_t)(num2));
		
		/** 打印浮点数*/
		ADBG(DBG_LEV, "3. FLOAT: %f\r\n", float1);
	}

	/**  启动事件处理函数，在SerialDebug.nc已经关联到MainC.Boot接口
	*	 系统启动后会调用此函数
	*/
	event void Boot.booted()
	{
		post DebugSerial();
	}
}

