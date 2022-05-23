

generic configuration DebugLibC(uint16_t buffer_size)
{
	provides interface StdControl;
	provides interface DiagnoseSendQuery;
	provides interface DiagnoseQuery;
}
implementation
{
	components MainC;
	components ActiveMessageC;
	components ReceiveDiagnoseC;
	components SendDiagnoseC;
	components new DebugLibP(buffer_size);	

	MainC.SoftwareInit -> DebugLibP.Init;

	StdControl = DebugLibP.StdControl;
	DiagnoseSendQuery = DebugLibP;
	DiagnoseQuery = DebugLibP;

	DebugLibP.SendDiagCntl -> SendDiagnoseC.StdControl;
	DebugLibP.SendDiagnose -> SendDiagnoseC;
	DebugLibP.ReceiveDiagCntl -> ReceiveDiagnoseC.StdControl;	
	DebugLibP.ReceiveDiagnose -> ReceiveDiagnoseC;
	DebugLibP.AMPacket -> ActiveMessageC;
}
