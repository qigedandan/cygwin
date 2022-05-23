

#ifndef OSASERVERCMDPACKET_H
#define OSASERVERCMDPACKET_H


enum
{
	OSASERVER_CMD_MAX_RECEIVE_PACKET = 128,
	OSASERVER_CMD_SOF_ID = 0x37,

	OSASERVER_CMD_STATE_SOF = 0,
	OSASERVER_CMD_STATE_HEADER = 1,
	OSASERVER_CMD_STATE_DATA = 2,
	OSASERVER_CMD_STATE_FCS = 3,
};

#define OSASERVER_CMD(v)	(0x0000 | (v))
#define OSASERVER_CMD_ACK(v)	(0x0080 | (v))

enum
{
	OSASERVER_CMD_PING = OSASERVER_CMD(1),
	OSASERVER_CMD_PING_ACK = OSASERVER_CMD_ACK(1),
	
	OSASERVER_CMD_QUERY_NODES = OSASERVER_CMD(2),	
	OSASERVER_CMD_NODE_INFO_ACK = OSASERVER_CMD_ACK(2),
	
	OSASERVER_CMD_RUN_USR_APP = OSASERVER_CMD(3),
	

	OSASERVER_CMD_DOWN_DATA = OSASERVER_CMD(4),
	OSASERVER_CMD_DOWN_DATA_ACK = OSASERVER_CMD_ACK(4),

	OSASERVER_CMD_DOWN_DATA_RESULT = OSASERVER_CMD_ACK(5),

	OSASERVER_CMD_REBOOT_NODES = OSASERVER_CMD(5),
};



typedef struct _osaserver_cmd_packet
{
	uint16_t cmd;
	uint16_t len;
	uint8_t data[OSASERVER_CMD_MAX_RECEIVE_PACKET];
	uint8_t fcs;
} osaserver_cmd_packet_t;

enum
{
	OSASERVER_CMD_HEADER_SIZE = sizeof(uint16_t) + sizeof(uint16_t), /* cmd + len */
};


typedef struct _osaserver_cmd_server_info
{
	uint16_t server_addr;
} osaserver_cmd_server_info_t;

#endif /* OSASERVERCMDPACKET_H */

