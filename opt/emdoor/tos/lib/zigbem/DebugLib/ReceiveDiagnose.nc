#include "DiagnoseMsg.h"

interface ReceiveDiagnose
{	
	event void receivedQuery( query_cmd_packet_t* packet, uint8_t len);

	/**
	 * send ackQuery string
	 */
	command error_t ackQuery(ackQuery_cmd_packet_t* packet,  uint8_t len);

	event void ackQueryDone(ackQuery_cmd_packet_t* packet, error_t err);
	
}
