
configuration EmRouterAppC
{
}
implementation
{
	components EmRouterC as App;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components ActiveMessageC;

	App.Boot -> MainC;
	App.SensorTimer -> SensorTimerC;
	App.RFControl -> ActiveMessageC;
	App.AMPacket -> ActiveMessageC;
	
	components SensorCollectionC;
	App.SensorCollection -> SensorCollectionC;

	components QuickRouteC;
	App.Send -> QuickRouteC;
	App.Packet -> QuickRouteC;

	components UartDebugControlC;
	App.UartDebugControl -> UartDebugControlC;

	components SystemHeartC;
	App.SystemHeartControl -> SystemHeartC;
}
