

configuration TimerRTCC
{
	provides interface TimerRTC;
}
implementation
{
	components MainC;
	components TimerRTCP;
	MainC.SoftwareInit -> TimerRTCP;

	TimerRTC = TimerRTCP;

	components HplCC2430TimerSleepP;

	TimerRTCP.Alarm -> HplCC2430TimerSleepP;
	TimerRTCP.SubInit -> HplCC2430TimerSleepP; 
}

