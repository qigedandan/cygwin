

#ifndef ALSERVERCMDPACKET_H
#define ALSERVERCMDPACKET_H


enum
{
	ALSERVER_CMD_MAX_RECEIVE_PACKET = 128,
	ALSERVER_CMD_SOF_ID = 0x37,

	ALSERVER_CMD_STATE_SOF = 0,
	ALSERVER_CMD_STATE_HEADER = 1,
	ALSERVER_CMD_STATE_DATA = 2,
	ALSERVER_CMD_STATE_FCS = 3,
};

#define ALSERVER_CMD(v)	(0x0000 | (v))
#define ALSERVER_CMD_ACK(v)	(0x0080 | (v))

enum
{
	ALSERVER_CMD_PING = ALSERVER_CMD(1),
	ALSERVER_CMD_PING_ACK = ALSERVER_CMD_ACK(1),

	
	ALSERVER_CMD_REF_NODE = ALSERVER_CMD(2),	

	ALSERVER_CMD_BLI_NODE_AUTO = ALSERVER_CMD(3),
    
	ALSERVER_CMD_REQ_BLI_NODE = ALSERVER_CMD(4),
    
    ALSERVER_CMD_ADJ_AUTO = ALSERVER_CMD(5),
    
    ALSERVER_CMD_ADJ_IMM = ALSERVER_CMD(6),
    
    ALSERVER_CMD_REF_NODE_ACK = ALSERVER_CMD_ACK(2),
    
    ALSERVER_CMD_BLI_NODE_ACK = ALSERVER_CMD_ACK(3),

	ALSERVER_CMD_QUERY_REF = ALSERVER_CMD(0x10),
	ALSERVER_CMD_QUERY_BLIND = ALSERVER_CMD(0x11),
};



typedef struct _alserver_cmd_packet
{
	uint16_t cmd;
	uint16_t len;
	uint8_t data[ALSERVER_CMD_MAX_RECEIVE_PACKET];
	uint8_t fcs;
} alserver_cmd_packet_t;

typedef union _alserver_setRefNodesLoc
{
	alserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint16_t loc_x;
	uint16_t loc_y;
	} own_packet;
} alserver_setRefNodesLoc;


typedef union _alserver_setBliNodeLocAuto
{
	alserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint8_t flag;
	} own_packet;
} alserver_setBliNodeLocAuto;

typedef union _alserver_reqBliNodeLoc
{
	alserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	} own_packet;
}  alserver_reqBliNodeLoc;


typedef union _alserver_setAdjAuto
{
	alserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint16_t loc_x;
	uint16_t loc_y;
	} own_packet;
}  alserver_setAdjAuto;

typedef union _alserver_setAdjImm
{
	alserver_cmd_packet_t  comm_packet;
	struct {
	uint16_t cmd;
	uint16_t len;
	uint16_t addr;
	uint8_t para_a;
	uint8_t para_n;
	} own_packet;
}   alserver_setAdjImm ;

enum
{
	ALSERVER_CMD_HEADER_SIZE = sizeof(uint16_t) + sizeof(uint16_t), /* cmd + len */
};


typedef struct _alserver_cmd_server_info
{
	uint16_t server_addr;
} alserver_cmd_server_info_t;

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


#endif /* ALSERVERCMDPACKET_H */

