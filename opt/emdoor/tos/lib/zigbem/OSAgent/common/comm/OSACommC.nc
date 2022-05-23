
configuration OSACommC
{
	provides interface OSAComm;
	provides interface StdControl;
}
implementation
{
	components OSACommP;
	OSAComm = OSACommP;
	StdControl = OSACommP;

	components OSARFMessageC;

	
	OSACommP.Send -> OSARFMessageC;
	OSACommP.Receive -> OSARFMessageC.Receive;
	OSACommP.SubControl -> OSARFMessageC.StdControl;
}

