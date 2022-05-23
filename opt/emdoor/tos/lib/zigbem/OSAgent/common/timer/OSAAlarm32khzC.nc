#include "OSATimer.h"

generic configuration OSAAlarm32khzC()
{
	provides interface Alarm<T32khz, uint32_t>;
}
implementation
{
	components MainC;
	components HilOSAAlarm32khzC;

	MainC.SoftwareInit -> HilOSAAlarm32khzC;
	Alarm = HilOSAAlarm32khzC.Alarm32khz[unique(UQ_OSAALARM_32KHZ)];
}


