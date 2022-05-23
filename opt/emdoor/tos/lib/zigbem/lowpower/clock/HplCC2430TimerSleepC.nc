configuration HplCC2430TimerSleepC
{
    provides interface Alarm<T32khz, uint32_t> as Alarm;
}
implementation
{
	components MainC;
	components HplCC2430TimerSleepP;

	Alarm = HplCC2430TimerSleepP;
	MainC.SoftwareInit -> HplCC2430TimerSleepP;
}

