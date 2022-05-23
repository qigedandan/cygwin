
configuration OSACommServerC
{
	provides interface StdControl;
	provides interface OSACommServer;
}
implementation
{
	components OSACommServerP;
	OSACommServer = OSACommServerP;
	StdControl = OSACommServerP;

	components OSACommC;
	OSACommServerP.OSAComm -> OSACommC;
	OSACommServerP.SubControl -> OSACommC;
}

