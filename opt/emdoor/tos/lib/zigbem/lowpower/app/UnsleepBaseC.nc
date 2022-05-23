
configuration UnsleepBaseC
{
	provides interface UnsleepBase;
	provides interface ClockSync;
}
implementation
{
	components UnsleepBaseP;
	UnsleepBase = UnsleepBaseP;

	components new TimerMilliC();
	UnsleepBaseP.Timer -> TimerMilliC;

	components new ClockSyncC(TRUE);
	UnsleepBaseP.ClockSync -> ClockSyncC;
	
	ClockSync = ClockSyncC;
}

