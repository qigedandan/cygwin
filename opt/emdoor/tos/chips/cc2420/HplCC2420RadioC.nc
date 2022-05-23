 
configuration HplCC2420RadioC
{
	provides interface HplCC2420Radio;
}
implementation
{
	components HplCC2420RadioP;

	HplCC2420Radio = HplCC2420RadioP;
}


