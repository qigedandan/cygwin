/****************************************************
*	fn:RelayC.nc
*	brief:do connection among interfaces
*	author:tivacc
*****************************************************/

configuration RelayC
{
	provides interface Relay;
}
implementation 
{
	components RelayM;
	components HplCC2430GeneralIOC as CC2430IO;
	
	Relay = RelayM;
	
	RelayM.RelayIO -> CC2430IO.P11;
}
