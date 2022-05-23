/*************************************************
*	FUNCTION NAME : SerialDebug.nc
*	FUNCTION DESCRIPTION : 串口调试信息打印
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration SerialDebug
{
}
implementation
{
	components SerialDebugM;  /* SerialDebug模块程序，用于实现具体代码 */
	components MainC;  		  /* TinyOS2主模块，这里用于关联系统启动 */

	/* SerialDebug模块程序的Boot接口与系统Boot接口关联
	*  这样系统启动时会调用SerialDebugM的Boot接口
	*/
	SerialDebugM.Boot -> MainC.Boot;	
}

