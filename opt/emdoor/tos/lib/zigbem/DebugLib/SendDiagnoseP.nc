#include "DiagnoseMsg.h"

module SendDiagnoseP {

	provides interface Init;
	provides interface StdControl;
	provides interface SendDiagnose;

	uses {
		interface AMSend as SendQuery;
		interface Packet;
		interface Receive as ReceiveAck;
		interface SplitControl as RadioControl;
	}
}
implementation
{
	message_t* msgPtr;
	message_t msg;

	/*============== Init ============*/
	command error_t Init.init() {
		msgPtr = &msg;
		return SUCCESS;
	}

	/*============= StdControl ==========*/
	command error_t StdControl.start()
	{
		return call RadioControl.start();
	}

	command error_t StdControl.stop() 
	{
		return call RadioControl.stop();
	}

	/*=============== RadioControl event ===========*/
	event void RadioControl.startDone(error_t error) {
	}

	event void RadioControl.stopDone(error_t error) {
	}

	/*============= SendDiagnose command ==========*/

	command error_t SendDiagnose.query(query_cmd_packet_t* packet, uint8_t len) 
	{
		uint8_t* payload = (uint8_t*)call Packet.getPayload(msgPtr, NULL);
		uint8_t* data = (uint8_t*)packet;
		uint8_t i;

		ADBG(1, "SendDiagnose.query, cmd len = %d\n", (int)len);
		if(len > call Packet.maxPayloadLength()) {
			return FAIL;
		}

		for(i=0; i<len; i++) {
			payload[i] = data[i];
		}

		return call SendQuery.send(packet->queryNodeId, msgPtr, len);
	}

	/*================= SendQuery event ===============*/
	event void SendQuery.sendDone(message_t* msg, error_t error)
	{
		ADBG(1,"SendQuery.sendDone, error= %d\n", (int)error);
	}

	/*============= ReceiveAck event ===================*/

	event message_t* ReceiveAck.receive(message_t* msg, void* payload, uint8_t len)
	{	
		ackQuery_cmd_packet_t* cmd = (ackQuery_cmd_packet_t*)payload;

		signal SendDiagnose.receivedAck(cmd, len);

		return msg;
	}

	default event void SendDiagnose.receivedAck(ackQuery_cmd_packet_t* packet, uint8_t len)
	{
	}
}	
		
	

	
		
	
