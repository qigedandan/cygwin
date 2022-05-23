/*************************************************
*	FUNCTION NAME : RandomAppC.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration RandomAppC
{
}
implementation
{
	components RandomM;
	components MainC;  /* TinyOS2主模块，这里用于关联系统启动 */
	components PlatformSerialC;	
	components CC2430RandomLfsrC as RandomC;	

	/** RandomM模块程序的Boot接口与系统Boot接口关联
	*/
	RandomM.Boot -> MainC.Boot;
	RandomM.RandomInit -> RandomC.Init;
	RandomM.Random -> RandomC.Random;

	RandomM.UartStdControl -> PlatformSerialC.UartStdControl;
	RandomM.UartStream -> PlatformSerialC.UartStream;
}


