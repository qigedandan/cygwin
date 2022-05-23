
configuration EMSleepCoordAppC
{
}
implementation
{
	components MainC;
	components EMSleepCoordC as App;

	App.Boot -> MainC;
	
	components ActiveMessageC;	
	App.AMControl -> ActiveMessageC;
	App.AMPacket -> ActiveMessageC;
	App.Packet -> ActiveMessageC;
	
	components QuickRouteC;
	App.Intercept -> QuickRouteC;
	App.RootControl -> QuickRouteC;

	components ABSC;
	App.ABS -> ABSC;


	/*===  Clock Sync control  ======*/
	components UnsleepBaseC;
	App.UnsleepBase -> UnsleepBaseC;
	App.ClockSync -> UnsleepBaseC;
	
	components UnsleepClockC;
	App.UnsleepClock -> UnsleepClockC;
}
