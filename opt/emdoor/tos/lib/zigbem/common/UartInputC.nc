
configuration UartInputC
{
	provides interface UartInput;
}
implementation
{
	components UartInputP;
	UartInput = UartInputP;

	components PlatformSerialC;
	UartInputP.UartStdControl -> PlatformSerialC;
	UartInputP.UartStream -> PlatformSerialC;
}

