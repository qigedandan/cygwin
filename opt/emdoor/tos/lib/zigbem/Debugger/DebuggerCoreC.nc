
configuration DebuggerCoreC
{
	provides interface DebuggerCore;
	uses interface DebuggerHandler;
}
implementation
{
	components DebuggerCoreP;

	DebuggerCore = DebuggerCoreP;
	DebuggerHandler = DebuggerCoreP;
}

