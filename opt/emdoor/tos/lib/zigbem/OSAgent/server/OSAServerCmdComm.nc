
#include "OSAServerCmdPacket.h"

interface OSAServerCmdComm
{
	command error_t sendCmdPacket(osaserver_cmd_packet_t *packet);
	event void sendCmdPacketDone(osaserver_cmd_packet_t *packet, error_t error);
	
	event void receivedCmdPacket(osaserver_cmd_packet_t *packet, error_t error);
}

