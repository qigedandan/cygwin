

configuration OSACommClientC
{
	provides interface OSACommClient;
	provides interface StdControl;
}
implementation
{
	components OSACommClientP;
	OSACommClient = OSACommClientP;
	StdControl = OSACommClientP;

	components OSACommC;
	OSACommClientP.OSAComm -> OSACommC;
	OSACommClientP.SubControl -> OSACommC;

	components new OSAAlarm32khzC();
	OSACommClientP.BackoffTimer -> OSAAlarm32khzC;
	
	components ActiveMessageAddressC;
	OSACommClientP.ActiveMessageAddress -> ActiveMessageAddressC;

	components RandomLfsrC as RandomC;
	OSACommClientP.Random -> RandomC;
}


