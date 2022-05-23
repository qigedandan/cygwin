#include "DiagnoseMsg.h"

interface SendDiagnose
{
	
		command error_t query( query_cmd_packet_t* packet,  uint8_t len);
		event  void receivedAck(ackQuery_cmd_packet_t* packet, uint8_t len);

}