
configuration OSARFC
{
    provides  interface OSARF;
    provides  interface StdControl as OSARFControl;
    provides  interface Init;
}
implementation
{
	components OSARFP;
	OSARF = OSARFP;
	OSARFControl = OSARFP;
	Init = OSARFP;

	components OSARFInterruptsC;
	OSARFP.InterruptTXDone -> OSARFInterruptsC.InterruptTXDone;
	OSARFP.InterruptFIFOP -> OSARFInterruptsC.InterruptFIFOP;
	OSARFP.InterruptRFErr -> OSARFInterruptsC.InterruptRFErr;

	components LedsC;
	OSARFP.Leds -> LedsC;
}

