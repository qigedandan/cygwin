
#ifndef DEBUGLIB_H
#define DEBUGLIB_H

enum
{
	 QUERY_DATA = 15,
	 ACK_DATA = 16,

	 DIAGNOSE_ACK_PACKET_MAX_SIZE = 80,
	 DIAGNOSE_QUERY_CMD_TYPE = 1,
	 DIAGNOSE_ACK_QUERY_CMD_TYPE = 2,	 
};

typedef struct _ackQuery_cmd_header
{
	uint16_t cmd;
	uint16_t Debuger_id;
	uint16_t queryNodeId;
	uint8_t len;
}ackQuery_cmd_header_t;

typedef struct _ackQuery_cmd_packet
{
	ackQuery_cmd_header_t header;
	uint8_t data[DIAGNOSE_ACK_PACKET_MAX_SIZE];
}ackQuery_cmd_packet_t;

typedef struct  _query_cmd_packet
{
	uint16_t cmd;
	uint16_t Debuger_id;     //the Debuger id
	uint16_t queryNodeId; 	
}query_cmd_packet_t;


enum
{
	QUERY_CMD_PACKET_SIZE = sizeof(query_cmd_packet_t),
	ACKQUERY_CMD_PACKET_HEADER_SIZE = sizeof(ackQuery_cmd_header_t),
};

/*
typedef struct _nodInfo {
	uint16_t id;   //node id
	uint16_t panId; //network id
	uint32_t time;
}nodeInfo_t;

typedef struct _routeInfo {
	bool isActive;       // whether the node has valid route
	uint16_t nextHop; 
	uint16_t reverseHop;//for reverse route
	uint8_t depth;         //the hop to destination(BaseStation) node
	uint16_t updateInterval;
}routeInfo_t;

typedef struct _appInfo{
	uint8_t sensorType; 
}appInfo_t;

typedef struct _RadioInfo{
	uint8_t power;
	uint8_t channel;
	uint8_t radio_stack;	
}RadioInfo_t;

typedef struct _ackQuery_cmd_packet 
{
	uint16_t cmd;
	uint16_t QueryId;
	nodeInfo_t nodeInfo;
	appInfo_t  appInfo;
	routeInfo_t routeInfo;
	RadioInfo_t RadioInfo;
	
}ackQuery_cmd_packet_t;

*/


#endif /* DEBUGLIB_H */
	
