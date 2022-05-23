/****************************************
*	fn:RelayM.nc
*	brief:
*	author:tivacc
*****************************************/

module RelayM
{
	provides interface Relay;
	
	uses interface GeneralIO as RelayIO;
}
implementation
{
	async command void Relay.RelayInit() 
	{
		atomic
		{
			call RelayIO.makeOutput();
			call RelayIO.set();
		}
	}
	
	async command void Relay.RelayOn()
	{
		call RelayIO.set();
	}
	
	async command void Relay.RelayOff()
	{
		call RelayIO.clr();
	}
	
	async command void Relay.RelayToggle()
	{
		call RelayIO.toggle();
	}
}