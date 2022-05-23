

generic configuration RTCC()
{
	provides interface RTC;
}
implementation
{
	components new RTCP();
	RTC = RTCP;

	/* CLK->P01,  DATA->P00 */
	components new CC2430I2CMasterC();
	RTCP.I2C -> CC2430I2CMasterC.I2CPacket;
	
	components HplCC2430InterruptC;
	RTCP.AlarmInterrupt -> HplCC2430InterruptC.P0_INT[5];

}

