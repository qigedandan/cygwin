
configuration SleepNodeCoreControlC
{
	provides interface SleepNodeCoreControl;
}
implementation
{
	components SleepNodeStateLockManC;
	components SleepNodeCoreControlP;
	SleepNodeCoreControl = SleepNodeCoreControlP;
	SleepNodeCoreControlP.StateLockMan -> SleepNodeStateLockManC;

	/* Core control link are defined in the corresponding component, 
	such as SleepNodeClockSyncC,  CycleNodeUnsyncC, CycleNodeSyncC...*/
}

