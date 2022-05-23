
configuration HplGeneralIOC
{
	provides interface GeneralIO as PIN[uint8_t port];
}
implementation
{
	#define P0_PIN(port)	(port)
	#define P1_PIN(port)	(8+port)
	#define P2_PIN(port)	(16+port)

	components HplCC2430GeneralIOC;
	PIN[ P0_PIN(0) ] = HplCC2430GeneralIOC.P00;
	PIN[ P0_PIN(1) ] = HplCC2430GeneralIOC.P01;
	PIN[ P0_PIN(2) ] = HplCC2430GeneralIOC.P02;
	PIN[ P0_PIN(3) ] = HplCC2430GeneralIOC.P03;
	PIN[ P0_PIN(4) ] = HplCC2430GeneralIOC.P04;
	PIN[ P0_PIN(5) ] = HplCC2430GeneralIOC.P05;
	PIN[ P0_PIN(6) ] = HplCC2430GeneralIOC.P06;
	PIN[ P0_PIN(7) ] = HplCC2430GeneralIOC.P07;
}

