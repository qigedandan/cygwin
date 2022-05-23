#include "DiagnoseMsg.h"

module ReceiveDiagnoseP {

	provides interface Init;
	provides interface StdControl;	
	provides interface ReceiveDiagnose;

	uses {
		interface AMSend as SendAck;
		interface Packet;
		interface Receive as ReceiveQuery;
		interface SplitControl as RadioControl;
	}
}
implementation
{	
	message_t* msgPtr;
	message_t msg;

	/*============= Init ================*/
	command error_t Init.init() {
		msgPtr = &msg;
		return SUCCESS;
	}	

	/*========== StdControl ============== */
	command error_t StdControl.start()
	{
		return call RadioControl.start();
	}

	command error_t StdControl.stop() 
	{
		return call RadioControl.stop();
	}

	/*========== RadioControl event =========*/
	event void RadioControl.startDone(error_t error) {
	}

	event void RadioControl.stopDone(error_t error) {
	}

	/*========== ReceiveDiagnose command ===========*/
	
	command error_t ReceiveDiagnose.ackQuery( ackQuery_cmd_packet_t* packet, uint8_t len) {

		uint8_t* payload = (uint8_t*) call Packet.getPayload(msgPtr, NULL);
		uint8_t* data = (uint8_t*)packet;
		uint8_t i;

		ADBG(1, " ReceiveDiagnose.ackQuery is called, len= %d\n", (int)len);
		if(len > call Packet.maxPayloadLength()){
			return FAIL;
		}
		
		for(i = 0; i < len; i++) {
			payload[i] = data[i];
		}

		return call SendAck.send(packet->header.Debuger_id, msgPtr, len);
	}

	/*=============  SendAck event =================*/
	
	event void SendAck.sendDone( message_t* msg, error_t error) {
		ackQuery_cmd_packet_t* ack_packet = call Packet.getPayload(msg, NULL);
		signal ReceiveDiagnose.ackQueryDone(ack_packet, error); 
	}

	/*============= Receive event =================*/

	event message_t* ReceiveQuery.receive(message_t* msg, void* payload, uint8_t len) 
	{
		query_cmd_packet_t* cmd = (query_cmd_packet_t*)payload;
		
		if(len != QUERY_CMD_PACKET_SIZE) {
			return msg;
		}

		signal ReceiveDiagnose.receivedQuery(cmd, len);

		return msg;
	}

	default event void ReceiveDiagnose.receivedQuery(query_cmd_packet_t* packet, uint8_t len)
	{
	}

	default event void ReceiveDiagnose.ackQueryDone(ackQuery_cmd_packet_t* packet, error_t error)
	{
	}

}	
		