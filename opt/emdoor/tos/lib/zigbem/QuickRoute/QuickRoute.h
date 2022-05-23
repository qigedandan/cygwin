
#ifndef _QUICK_ROUTE_H
#define _QUICK_ROUTE_H

#ifndef QUICK_ROUTE_TABLE_SIZE 
#define QUICK_ROUTE_TABLE_SIZE  6
#endif

#ifndef MHOP_QUICKROUTE_HISTORY_SIZE
#define MHOP_QUICKROUTE_HISTORY_SIZE 3
#endif

#ifndef QUICK_ROUTE_TIMEOUT
#define QUICK_ROUTE_TIMEOUT 1000
#endif

#ifndef QUICK_ROUTE_TRY_TIMES
#define QUICK_ROUTE_TRY_TIMES 3
#endif

#ifndef QUICK_ROUTE_FORWARD_SIZE
#define QUICK_ROUTE_FORWARD_SIZE  512
#endif


#define UQ_QUICK_ROUTE_CLIENT "ForwardingEngineP.Send" 

enum {
	AM_QUICK_ROUTE_BEACON_MSG = 30,
	AM_QUICK_ROUTE_REQUEST_MSG = 31,
	AM_QUICK_ROUTE_DATA_FORWARD_MSG = 40,
	AM_QUICK_ROUTE_DATA_MSG = 50,
	NUM_QUICK_ROUTE_CLIENTS = uniqueCount(UQ_QUICK_ROUTE_CLIENT),
};

typedef struct quickroute_table_entry
{
	uint16_t addr;
	uint16_t link_cost;
	uint16_t parent;
	uint16_t parent_cost;
	uint8_t  hopcount;
	bool used;
} quickroute_table_entry_t;


typedef struct quickroute_beacon_msg
{
	uint8_t  seqno;
	uint16_t dest_addr;  /* beacon to the who? */
	
	uint16_t parent;
	uint16_t parent_cost;
	uint8_t  hopcount;
} quickroute_beacon_msg_t;

typedef struct quickroute_request_msg
{
	uint8_t  seqno;
} quickroute_request_msg_t;

typedef struct quickroute_data_header
{
	uint8_t  seqno;
	uint16_t orgi_addr;
	uint16_t second_addr;
	uint16_t hop_real;
	uint16_t hop_est;
	uint8_t  sensor_type;
} quickroute_data_header_t;

#endif
