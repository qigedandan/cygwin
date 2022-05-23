
#include "ALServerCmdPacket.h"

interface ALServerCmdPacket
{
	command error_t receiveNext(uint8_t *data, uint16_t len);
	event void receivedPacket(alserver_cmd_packet_t *packet);

	command error_t generatePacket(alserver_cmd_packet_t *packet, uint8_t *buf, uint16_t *len);
}

