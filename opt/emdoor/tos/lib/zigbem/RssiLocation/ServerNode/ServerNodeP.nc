#include "RssiLocation.h"
#include "AtpCmdPacket.h"
#include "QuickRoute.h"
 module ServerNodeP
 {
 	provides {
 		interface StdControl;		
	}
 	uses {
 		interface Send;
		interface Intercept;
		interface RootControl;
 		interface StdControl as AtpCmdCommControl;
 		interface AtpCmdComm;
 		interface AMPacket;
 		interface Packet;
 	}
 }
 implementation
 {
 	atp_cmd_packet_t atp_cmd_packet;
	message_t m_msg;

	task void sendTask()
	{
		call Send.send(&m_msg, 10);
	}
	
 	command error_t StdControl.start()
 	{
 		call AtpCmdCommControl.start();

 		post sendTask();
 		
 		return SUCCESS;
 	}

 	command error_t StdControl.stop()
 	{
 		return SUCCESS;
 	}
 	
	event bool Intercept.forward(message_t* msg, void* payload, uint16_t len)
	{
		upload_info_t info;

		quickroute_data_header_t* data_header = (quickroute_data_header_t*) call Packet.getPayload(msg, NULL);

 		info.id = data_header->orgi_addr;
 		info.len = len;

 		// LED_BLUE_TOGGLE;	

 		memcpy(info.data, payload, len);

 		atp_cmd_packet.cmd = 0x01;
 		atp_cmd_packet.len = sizeof(uint16_t)+info.len;
 		memcpy(atp_cmd_packet.data, &info, atp_cmd_packet.len);

 		call AtpCmdComm.sendCmdPacket(&atp_cmd_packet);

 		return FALSE;
	}

 	event void Send.sendDone(message_t* msg, error_t error)
	{
		ADBG(200, "## Send.sendDone result=%d\n", (int)error);
	}

 	event void AtpCmdComm.sendCmdPacketDone(atp_cmd_packet_t* packet, error_t err)
 	{
 	}

 	event void AtpCmdComm.receivedCmdPacket(atp_cmd_packet_t* packet, error_t err)
 	{
 	} 	
 }
 		
 		
