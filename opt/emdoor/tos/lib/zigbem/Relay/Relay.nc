/*********************************************
*		fn:	Relay.nc
*		brief:interface of relay's action
*		author:tivacc
**********************************************/

interface Relay
{
	async command void RelayInit(); //Relay initial 
	async command void RelayOn();		//turn on relay
	async command void RelayOff();	//turn off relay
	async command void RelayToggle(); //periodic action
}
