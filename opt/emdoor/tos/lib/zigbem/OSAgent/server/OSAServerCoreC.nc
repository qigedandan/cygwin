
configuration OSAServerCoreC
{
	provides interface StdControl as CoreControl;
}
implementation
{
	components OSAServerCoreP;
	components MainC;

	CoreControl = OSAServerCoreP;

	
	MainC.SoftwareInit -> OSAServerCoreP;


	components OSACommServerC;
	OSAServerCoreP.OSACommServerControl -> OSACommServerC;
	OSAServerCoreP.OSACommServer -> OSACommServerC;

	components OSAServerCmdC;
	OSAServerCoreP.OSAServerCmdControl -> OSAServerCmdC;
	OSAServerCoreP.OSAServerCmd -> OSAServerCmdC;

	components OSAUsrAppC;
	OSAServerCoreP.OSAUsrApp -> OSAUsrAppC;

	components ActiveMessageAddressC;
	OSAServerCoreP.ActiveMessageAddress -> ActiveMessageAddressC;
}

