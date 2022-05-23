

generic configuration SleepAlarm32khz32C()
{
	provides interface Alarm<T32khz, uint32_t> as Alarm;
}
implementation
{
	components SleepAlarm32khz32P;

	Alarm = SleepAlarm32khz32P;
}

