
configuration DebuggerC
{
	provides interface DebuggerCore;
}
implementation
{
	components DebuggerCoreC;
	DebuggerCore = DebuggerCoreC;

	/* modules */
	components DebuggerRegC;
	DebuggerCoreC.DebuggerHandler -> DebuggerRegC;


	components DebuggerStepC;
	DebuggerCoreC.DebuggerHandler -> DebuggerStepC;
	
	components DebuggerLogC;
	DebuggerCoreC.DebuggerHandler -> DebuggerLogC;

	components DebuggerLevelC;
	DebuggerCoreC.DebuggerHandler -> DebuggerLevelC;
}

