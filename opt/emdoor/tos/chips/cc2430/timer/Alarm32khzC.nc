
generic configuration Alarm32khzC()
{
	provides interface Alarm<T32khz, uint32_t>;
}
implementation
{
	components MainC;
	components HilAlarm32khzC;

	MainC.SoftwareInit -> HilAlarm32khzC;
	Alarm = HilAlarm32khzC.Alarm32khz[unique(UQ_ALARM_32KHZ)];
}


