
configuration DebuggerStepC
{
	provides interface DebuggerHandler;
}
implementation
{
	components DebuggerStepP;
	DebuggerHandler = DebuggerStepP;
}

