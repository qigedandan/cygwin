configuration HplCC2430InterruptC
{
    provides interface GpioInterrupt as P0_INT[uint8_t pin];
	provides interface GpioInterrupt as P1_INT[uint8_t pin];
}
implementation
{
	components HplCC2430Pin0InterruptC; 
	components HplCC2430Pin1InterruptC; 
	
	P0_INT = HplCC2430Pin0InterruptC.P0_INT;
	P1_INT = HplCC2430Pin1InterruptC.P1_INT;
}
