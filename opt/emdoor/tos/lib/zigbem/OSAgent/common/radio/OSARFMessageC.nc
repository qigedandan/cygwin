
configuration OSARFMessageC
{
	provides interface StdControl;
	provides interface Send;
	provides interface Receive;
	provides interface Receive as ReceiveAll;
	provides interface OSARF;
}
implementation
{
	components OSARFMessageP;
	components OSARFC;
	components OSARFTransmitC;
	components OSARFReceiveC;

	components MainC;
	MainC.SoftwareInit -> OSARFMessageP.Init;

	
	StdControl = OSARFMessageP;
	Send = OSARFTransmitC;
	Receive = OSARFReceiveC.Receive;
	ReceiveAll = OSARFReceiveC.ReceiveAll;
	OSARF = OSARFC;


	OSARFMessageP.SubInit -> OSARFC.Init;
	OSARFMessageP.SubControl -> OSARFC.OSARFControl;
	OSARFMessageP.SubControl -> OSARFTransmitC.StdControl;

}



