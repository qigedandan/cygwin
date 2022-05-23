

configuration UnsleepClockC
{
	provides interface UnsleepClock;
}
implementation
{
	components UnsleepClockP;
	components TimerRTCC;
	components PowerControlC;

	UnsleepClock = UnsleepClockP;
	UnsleepClockP.TimerRTC -> TimerRTCC;
	UnsleepClockP.PowerControl -> PowerControlC;
}
