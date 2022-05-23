

configuration SendDiagnoseC {

	provides {
		interface StdControl;
		interface SendDiagnose;
	}
}
implementation
{
	components MainC;
	components SendDiagnoseP;
	components ActiveMessageC;
	components new AMSenderC(QUERY_DATA) as Sender;
	components new AMReceiverC(ACK_DATA) as Receiver;

	MainC.SoftwareInit ->SendDiagnoseP.Init;

	StdControl = SendDiagnoseP;
	SendDiagnose = SendDiagnoseP;

	SendDiagnoseP.SendQuery -> Sender.AMSend;
	SendDiagnoseP.ReceiveAck -> Receiver.Receive;
	SendDiagnoseP.RadioControl -> ActiveMessageC.SplitControl;
	SendDiagnoseP.Packet -> ActiveMessageC;
}	
