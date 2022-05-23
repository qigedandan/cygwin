
configuration EmRouterCoordAppC
{
}
implementation
{
	components MainC;
	components EmRouterCoordC as App;

	App.Boot -> MainC;
	
	components ActiveMessageC;	
	App.AMControl -> ActiveMessageC;
	App.AMPacket -> ActiveMessageC;
	
	components QuickRouteC;
	App.Send -> QuickRouteC;
	App.Intercept -> QuickRouteC;
	App.RootControl -> QuickRouteC;
	App.Packet -> QuickRouteC;

	components ABSC;
	App.ABS -> ABSC;

//	components UartDebugControlC;
//	App.UartDebugControl -> UartDebugControlC;

	components SystemHeartC;
	App.SystemHeartControl -> SystemHeartC;
}
