

#ifndef ATPCMDPACKET_H
#define ATPCMDPACKET_H


enum
{
	ATP_CMD_MAX_RECEIVE_PACKET = 128,
	ATP_CMD_SOF_ID = 0x37,

	ATP_CMD_STATE_SOF = 0,
	ATP_CMD_STATE_HEADER = 1,
	ATP_CMD_STATE_DATA = 2,
	ATP_CMD_STATE_FCS = 3,
};

#define ATP_CMD(v)	(0x0000 | (v))
#define ATP_CMD_ACK(v)	(0x0080 | (v))



typedef struct _atp_cmd_packet
{
	uint16_t cmd;
	uint16_t len;
	uint8_t data[ATP_CMD_MAX_RECEIVE_PACKET];
	uint8_t fcs;
} atp_cmd_packet_t;

enum
{
	ATP_CMD_HEADER_SIZE = sizeof(uint16_t) + sizeof(uint16_t), /* type + cmd + len */
};


#endif /* ATPCMDPACKET_H */

