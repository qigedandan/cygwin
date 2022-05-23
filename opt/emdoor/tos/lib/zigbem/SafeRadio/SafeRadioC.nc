
generic configuration SafeRadioC(uint8_t send_id, uint8_t ack_id)
{
	provides interface AMSend;
	provides interface Receive;
	provides interface Packet;
}
implementation
{
	components new SafeRadioP();
	AMSend = SafeRadioP.AMSend;
	Receive = SafeRadioP.Receive;
	Packet = SafeRadioP.Packet;
	
	components MainC;	
	MainC.SoftwareInit-> SafeRadioP;

	components new TimerMilliC();
	SafeRadioP.AckTimer -> TimerMilliC;


	components new ActiveMessageResourceC() as ActiveMessageResourceDataC;
	SafeRadioP.SubAMSendData -> ActiveMessageResourceDataC.AMSend[send_id];
	components new AMReceiverC(send_id) as AMReceiverDataC;
	SafeRadioP.SubReceiveData -> AMReceiverDataC;
	
	components new ActiveMessageResourceC() as ActiveMessageResourceAckC;
	SafeRadioP.SubAMSendAck -> ActiveMessageResourceAckC.AMSend[ack_id];
	components new AMReceiverC(ack_id) as AMReceiverAckC;
	SafeRadioP.SubReceiveAck -> AMReceiverAckC;

	components ActiveMessageC;
	SafeRadioP.AMPacket -> ActiveMessageC;
	SafeRadioP.SubPacket -> ActiveMessageC;

	
	components new TimerMilliC() as TimerMilliDelayC;
	SafeRadioP.DelayTimer -> TimerMilliDelayC;
}

