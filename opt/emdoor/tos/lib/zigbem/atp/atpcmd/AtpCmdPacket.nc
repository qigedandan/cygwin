
#include "AtpCmdPacket.h"

interface AtpCmdPacket {
	command error_t receiveNext(uint8_t *data, uint16_t len);
	event void receivedPacket(atp_cmd_packet_t *packet);

	command error_t generatePacket(atp_cmd_packet_t *packet, uint8_t *buf, uint16_t *len);
}

