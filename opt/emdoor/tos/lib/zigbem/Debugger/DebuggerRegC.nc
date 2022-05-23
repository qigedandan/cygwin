
configuration DebuggerRegC
{
	provides interface DebuggerHandler;
}
implementation
{
	components DebuggerRegP;
	DebuggerHandler = DebuggerRegP;
}


