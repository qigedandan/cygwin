

generic configuration SleepAlarmMilli32C()
{
	provides interface Init;
	provides interface Alarm<TMilli, uint32_t>;
}
implementation 
{
	components new SleepAlarm32khz32C();
	components SleepAlarmMilli32P;

	Init = SleepAlarmMilli32P;
	Alarm =  SleepAlarmMilli32P;

	SleepAlarmMilli32P.AlarmFrom -> SleepAlarm32khz32C;
}
