
#include "AtpCmdPacket.h"

interface AtpCmdComm
{
	command error_t sendCmdPacket(atp_cmd_packet_t *packet);
	event void sendCmdPacketDone(atp_cmd_packet_t *packet, error_t error);
	
	event void receivedCmdPacket(atp_cmd_packet_t *packet, error_t error);
}

