/* OSAgent Communication */

#ifndef OSACOMM_H
#define OSACOMM_H




/* type */

typedef struct _osanode_info
{	
	uint16_t id;			/* Node ID */
	uint8_t state;			/* run state */
	uint8_t error;			/* 0: no error */
	uint32_t program_time;	/* program execution time */
	uint32_t log_size;			/* current log size (bytes) */
} osanode_info_t;


typedef struct _osacomm_cmd_run_app
{
	uint32_t run_time;
} osacomm_cmd_run_app_t;

typedef union _osacomm_cmd_server
{
	struct {
		uint32_t time;
	} sync_time;


	struct {
		uint16_t server_addr;
	} query_nodes;

	struct {
		uint16_t server_addr;
	} down_node_data;

	struct {
		uint16_t server_addr;
	} reboot_nodes;

	osacomm_cmd_run_app_t run_usr_app;
	
} osacomm_cmd_server_t;

typedef union _osacomm_cmd_client
{
	osanode_info_t node_info;

	struct {
		uint8_t length;
		uint8_t data[128];  /* the max size... */
	} down_node_data_ack;
} osacomm_cmd_client_t;

typedef union _osacomm_cmddata
{
	osacomm_cmd_server_t server;
	osacomm_cmd_client_t client;
} osacomm_cmddata_t;

typedef struct _osacomm_cmd
{
	uint8_t cmd;
	osacomm_cmddata_t cmddata;
} osacomm_cmd_t;











/* CONST */
#define OSACOMM_SERVER_CMD(v)  (0x00 | (v))
#define OSACOMM_CLIENT_CMD(v)	(0x80 | (v))

#define OSACOMM_IS_SERVER_CMD(v)	(0x80 & (v) == 0x00)
#define OSACOMM_IS_CLIENT_CMD(v)	(0x80 & (v) == 0x80)

enum
{
	OSACOMM_RF_TYPE = 30,  /* type value to store in the cc2420_header_t.type */
};

enum
{
	/* Server -> Client */
	OSACOMM_CMD_QUERY_NODES = OSACOMM_SERVER_CMD(1),
	OSACOMM_CMD_RUN_USR_APP = OSACOMM_SERVER_CMD(2),
	OSACOMM_CMD_DOWN_NODE_DATA = OSACOMM_SERVER_CMD(4),
	OSACOMM_CMD_REBOOT = OSACOMM_SERVER_CMD(5),

	/* Client -> Server  */
	OSACOMM_CMD_SEND_NODE_INFO = OSACOMM_CLIENT_CMD(1),
	OSACOMM_CMD_DOWN_NODE_DATA_ACK = OSACOMM_CLIENT_CMD(4),
	
};

enum
{
	OSANODE_ERROR_NONE,
	OSANODE_ERROR_TIME,
	OSANODE_ERROR_RUN,
	OSANODE_ERROR_DATA,
};

enum
{
	OSANODE_MAX_COUNT = 100,
};

#endif /* OSACOMM_H */

