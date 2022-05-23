
configuration OSARFReceiveC
{
    provides interface Receive;  /* Receive Data only */
    provides interface Receive as ReceiveAll;  /* Receive any message received include ACK message */

    provides interface StdControl;
}
implementation
{
	components OSARFReceiveP;
	StdControl = OSARFReceiveP;
	Receive = OSARFReceiveP.Receive;
	ReceiveAll = OSARFReceiveP.ReceiveAll;

	components OSARFC;
	OSARFReceiveP.OSARF -> OSARFC.OSARF;

	components ActiveMessageAddressC;
	OSARFReceiveP.ActiveMessageAddress -> ActiveMessageAddressC;
}

