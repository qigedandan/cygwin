#ifndef PROFILEROUTE_H
#define PROFILEROUTE_H

#define PROFILEROUTE_MAX	24

#define PROFILEROUTE_SERVER_ADDR  0xf0

typedef nx_struct  _profile_route_header
{
	nx_uint16_t originaddr;
	nx_uint8_t hopcount;
	nx_uint8_t id; // for param interface
	nx_uint8_t sensorType;
}profile_route_header_t;

typedef struct _profile_route_info
{
	uint16_t node;
	uint16_t len;
	uint16_t addr[PROFILEROUTE_MAX];
}profile_route_info_t;

#define ROUTE_HEADER_SIZE (sizeof(uint16_t)+sizeof(uint16_t))  /* node + len */

#define SERVER_CMD(v)	(0x0000 | (v))
#define SERVER_CMD_ACK(v)	(0x0080 | (v))


enum
{
	PRSERVER_CMD_PING = SERVER_CMD(1),
	PRSERVER_CMD_SET = SERVER_CMD(2),
	PRSERVER_CMD_NODE_PING = SERVER_CMD(4),
	
	PRSERVER_CMD_PING_ACK = SERVER_CMD_ACK(1),
	PRSERVER_CMD_UPDATE = SERVER_CMD_ACK(3),	
};

typedef struct _ack_ping_packet
{
	uint16_t addr;
	uint8_t cmd;
}ack_ping_packet_t;

enum{
	ACK_PING_CMD = 0xC1,	
};

enum {
	PING_BASESTATION_TYPE = 181,
	ACK_PING_TYPE = 182,
	ROUTE_UPDATE_TYPE = 183,
	ACK_ROUTE_UPDATE_TYPE = 184,
	MINE_DATA_TYPE = 185,
	FORWARD_DATA_TYPE = 186,
};

#endif

