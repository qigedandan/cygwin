configuration EMSleepNodeAppC
{
}
implementation
{
	components EMSleepNodeC as App;
	components MainC;
	components ActiveMessageC;

	/* Basic */
	App.Boot -> MainC;
	
	App.AMPacket -> ActiveMessageC;
	App.Packet -> ActiveMessageC;

	/* Sleep control */
	components SleepNodeCycleControlC;
	App.SleepNodeCycleControl -> SleepNodeCycleControlC;

	components UnsleepClockC;
	App.UnsleepClock -> UnsleepClockC;

	components CycleNodeSyncC;
	App.CycleNodeSyncData -> CycleNodeSyncC;

	components SleepNodeClockSyncC;
	App.ClockSync -> SleepNodeClockSyncC;

	/* Sensor */
	components SensorCollectionC;
	App.SensorCollection -> SensorCollectionC;

	/* Quick Route */
	components QuickRouteC;
	App.Send -> QuickRouteC;

	components QuickRouteEngineC;
	App.QuickRouteEngine -> QuickRouteEngineC;

	/* Uart Debug control */
	components UartDebugControlC;
	App.UartDebugControl -> UartDebugControlC;

	components McuSleepC;
	App.McuSleepControl -> McuSleepC;

	/* add for UartDebuggerC */
	/*components UartDebuggerC;*/
}
