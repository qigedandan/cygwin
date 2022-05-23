
configuration OSARFTransmitC
{
    provides interface StdControl;
    provides interface Send;

}
implementation
{
	components OSARFTransmitP;
	StdControl = OSARFTransmitP;
	Send = OSARFTransmitP;

	components OSARFC;
	OSARFTransmitP.OSARF -> OSARFC.OSARF;

	components OSARFReceiveC;
	OSARFTransmitP.ReceiveAll -> OSARFReceiveC.ReceiveAll;

	components ActiveMessageAddressC;
	OSARFTransmitP.ActiveMessageAddress -> ActiveMessageAddressC;

	components RandomLfsrC as RandomC;
	OSARFTransmitP.Random -> RandomC;

	components new OSAAlarm32khzC() as Alarm;
	OSARFTransmitP.BackoffTimer -> Alarm;
}

