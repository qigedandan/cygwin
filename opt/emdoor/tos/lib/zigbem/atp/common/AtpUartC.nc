

generic configuration AtpUartC(uint16_t BUFFER_SIZE)
{
	provides interface StdControl;
	provides interface AtpUart;
}
implementation
{
	components new AtpUartP(BUFFER_SIZE);
	components PlatformSerialC;

	StdControl = AtpUartP;
	AtpUart = AtpUartP;

	AtpUartP.UartStdControl -> PlatformSerialC;
	AtpUartP.UartStream -> PlatformSerialC;
}

