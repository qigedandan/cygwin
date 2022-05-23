
configuration UartDebuggerC
{
}
implementation
{
	components UartDebuggerP;
	components MainC;

	MainC.SoftwareInit -> UartDebuggerP;
	
	components new AtpUartC(100);
	UartDebuggerP.AtpUart-> AtpUartC;
	UartDebuggerP.AtpUartControl-> AtpUartC;

	
	components DebuggerC;
	UartDebuggerP.DebuggerCore -> DebuggerC;
}

