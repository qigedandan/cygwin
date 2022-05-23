#include "RssiLocation.h"
configuration MobileNodeC
{
	provides interface StdControl;
}
implementation
{
	components MainC, MobileNodeP;
	components ActiveMessageC;
	components new ActiveMessageResourceC();
	components HplCC2430TimerSleepP;
	components PowerControlC;


	//components new SleepAlarm32khz32C() as AlarmC;

	StdControl = MobileNodeP;
	MainC.SoftwareInit -> MobileNodeP;

	MobileNodeP.BCastSend -> ActiveMessageResourceC.AMSend[AM_LOCATION_BROADCAST_MSG];
	MobileNodeP.Packet -> ActiveMessageC;	
	MobileNodeP.SubInit -> HplCC2430TimerSleepP;
	MobileNodeP.Alarm -> HplCC2430TimerSleepP;
	MobileNodeP.PowerControl -> PowerControlC;

	components UartDebugControlC;
	MobileNodeP.UartDebugControl -> UartDebugControlC;
	
	MobileNodeP.RadioControl -> ActiveMessageC;
	
}

