
configuration DebuggerLogC
{
	provides interface DebuggerHandler;
}
implementation
{
	components DebuggerLogP;
	DebuggerHandler = DebuggerLogP;
}

