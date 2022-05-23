
configuration DebuggerLevelC
{
	provides interface DebuggerHandler;
}
implementation
{
	components DebuggerLevelP;
	DebuggerHandler = DebuggerLevelP;

	components UartInputC;	
	DebuggerLevelP.UartInput -> UartInputC;
}
