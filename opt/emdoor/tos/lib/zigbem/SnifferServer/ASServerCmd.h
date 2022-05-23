

#ifndef ASSERVERCMDPACKET_H
#define ASSERVERCMDPACKET_H

#include "AtpCmdPacket.h"

enum
{
	ASSERVER_CMD_MAX_RECEIVE_PACKET = 128,
	ASSERVER_CMD_SOF_ID = 0x37,

	ASSERVER_CMD_STATE_SOF = 0,
	ASSERVER_CMD_STATE_HEADER = 1,
	ASSERVER_CMD_STATE_DATA = 2,
	ASSERVER_CMD_STATE_FCS = 3,
};

enum
{
	ASSERVER_CMD_HEADER_SIZE = sizeof(uint16_t) + sizeof(uint16_t), /* cmd + len */
    ASSERVER_SNIFF_DATA_HEADER_SIZE = sizeof(uint16_t)*4 + sizeof(uint8_t)*3 , /*  rf_length + dsn + fcf + src + dest + destpan + rssi */
};

#define ASSERVER_CMD(v)	(0x0000 | (v))
#define ASSERVER_CMD_ACK(v)	(0x0080 | (v))

enum
{
	ASSERVER_CMD_PING = ASSERVER_CMD(1),
	ASSERVER_CMD_PING_ACK = ASSERVER_CMD_ACK(1),

	
	ASSERVER_CMD_START = ASSERVER_CMD(2),	

	ASSERVER_CMD_STOP = ASSERVER_CMD(3),
    
	ASSERVER_CMD_SET_CHANNEL = ASSERVER_CMD(4),



	ASSERVER_CMD_REPROT_SNIFF_DATA = ASSERVER_CMD_ACK(5),    
    
	ASSERVER_CMD_START_ACK = ASSERVER_CMD_ACK(2),
    
    	ASSERVER_CMD_STOP_ACK = ASSERVER_CMD_ACK(3),
    
   	ASSERVER_CMD_SET_CHANNEL_ACK = ASSERVER_CMD_ACK(4),
	
};


/*
typedef struct _asserver_cmd_packet
{
	uint16_t cmd;
	uint16_t len;
	uint8_t data[ASSERVER_CMD_MAX_RECEIVE_PACKET];
	uint8_t fcs;
} asserver_cmd_packet;
*/

typedef union asserver_ReportPacket
{
	atp_cmd_packet_t comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint8_t dsn;
	uint16_t fcf;
    uint16_t src;
    uint16_t dest;
    uint16_t destpan;
    uint8_t rssi;
    uint8_t rf_length;
    uint8_t  rf_data[ATP_CMD_MAX_RECEIVE_PACKET - ASSERVER_SNIFF_DATA_HEADER_SIZE];
	} own_packet;
} asserver_ReportPacket;

/*

typedef union _asserver_setBliNodeLocAuto
{
	asserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint8_t flag;
	} own_packet;
} asserver_setBliNodeLocAuto;

typedef union _asserver_reqBliNodeLoc
{
	asserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	} own_packet;
}  asserver_reqBliNodeLoc;


typedef union _asserver_setAdjAuto
{
	asserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint16_t loc_x;
	uint16_t loc_y;
	} own_packet;
}  asserver_setAdjAuto;

typedef union _asserver_setAdjImm
{
	asserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint8_t para_a;
	uint8_t para_n;
	} own_packet;
}   asserver_setAdjImm ;




typedef struct _asserver_cmd_server_info
{
	uint16_t server_addr;
} asserver_cmd_server_info_t;

typedef struct _ref_node_info_t
{
    uint16_t node_addr;
    uint8_t  state;
    uint16_t loc_x;
    uint16_t loc_y;
} ref_node_info_t;

typedef struct _blind_node_info_t
{
    uint16_t node_addr;
    uint8_t  state;
    uint8_t  ref_num;
    uint8_t  loc_auto_flag;
    uint8_t  loc_param_a;
    uint8_t  loc_param_n;
    uint16_t loc_x;
    uint16_t loc_y; 
} blind_node_info_t;
*/

#endif /* ASSERVERCMDPACKET_H */

