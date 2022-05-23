
#include "ALServerCmdPacket.h"

interface ALServerCmdComm
{
	command error_t sendCmdPacket(alserver_cmd_packet_t *packet);
	event void sendCmdPacketDone(alserver_cmd_packet_t *packet, error_t error);
	
	event void receivedCmdPacket(alserver_cmd_packet_t *packet, error_t error);
}

