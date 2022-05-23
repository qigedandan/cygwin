/*************************************************
*	FUNCTION NAME : PowerModeC.nc
*	FUNCTION DESCRIPTION :模式示例程序
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration PowerModeC
{
}
implementation
{
	components PowerModeM;
	components MainC;

	PowerModeM.Boot -> MainC;

	components new TimerMilliC();

	PowerModeM.Timer -> TimerMilliC;

	components HplCC2430TimerSleepC;

	PowerModeM.SleepAlarm -> HplCC2430TimerSleepC;
}
