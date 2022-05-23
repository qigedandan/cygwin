
configuration UartDebugControlC
{
	provides interface UartDebugControl;
}
implementation
{
	components UartDebugControlP;
	components UartInputC;

	UartDebugControl = UartDebugControlP;

	UartDebugControlP.UartInput -> UartInputC;
}

