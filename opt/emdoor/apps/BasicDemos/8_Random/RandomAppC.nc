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
	components MainC;  /* TinyOS2��ģ�飬�������ڹ���ϵͳ���� */
	components PlatformSerialC;	
	components CC2430RandomLfsrC as RandomC;	

	/** RandomMģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	*/
	RandomM.Boot -> MainC.Boot;
	RandomM.RandomInit -> RandomC.Init;
	RandomM.Random -> RandomC.Random;

	RandomM.UartStdControl -> PlatformSerialC.UartStdControl;
	RandomM.UartStream -> PlatformSerialC.UartStream;
}


