

configuration ReceiveDiagnoseC{

	provides {		
		interface StdControl;
		interface ReceiveDiagnose;
	}
}
implementation
{
	components MainC;
	components ReceiveDiagnoseP;
	components ActiveMessageC;
	components new AMSenderC(ACK_DATA) as Sender;
	components new AMReceiverC(QUERY_DATA) as Receiver;

	MainC.SoftwareInit -> ReceiveDiagnoseP.Init;

	StdControl = ReceiveDiagnoseP;
	ReceiveDiagnose = ReceiveDiagnoseP;

	ReceiveDiagnoseP.SendAck -> Sender.AMSend;
	ReceiveDiagnoseP.ReceiveQuery -> Receiver.Receive;
	ReceiveDiagnoseP.Packet -> ActiveMessageC;
	ReceiveDiagnoseP.RadioControl -> ActiveMessageC.SplitControl;
}	
