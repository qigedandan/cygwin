
configuration SleepNodeCycleControlC
{
	provides interface SleepNodeCycleControl;
}
implementation
{
	components SleepNodeCycleControlP;
	SleepNodeCycleControl = SleepNodeCycleControlP;

	components ActiveMessageC;
	SleepNodeCycleControlP.RadioControl -> ActiveMessageC;

	components SleepNodeClockSyncC;
	SleepNodeCycleControlP.ClockSync -> SleepNodeClockSyncC;

	components SleepNodeCoreControlC;
	SleepNodeCycleControlP.SleepNodeCoreControl -> SleepNodeCoreControlC;

	components CycleNodeUnsyncC;
	SleepNodeCycleControlP.CycleNodeUnsync -> CycleNodeUnsyncC;

	components CycleNodeSyncC;
	SleepNodeCycleControlP.CycleNodeSync -> CycleNodeSyncC;
}

