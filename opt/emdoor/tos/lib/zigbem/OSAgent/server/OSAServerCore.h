

#ifndef OSASERVERCORE_H
#define OSASERVERCORE_H

#include "OSAComm.h"

enum
{
	OSASERVER_MAX_RF_ERROR = 10,
	OSASERVER_MAX_CMD_ERROR = 5,
	OSASERVER_MAX_NODE_LIST = 150,  /* Support max node list: 150 */
};


typedef struct _osaserver_state
{
	uint16_t server_addr;

	uint8_t rf_error_count;
	uint8_t cmd_error_count;

	uint16_t node_count;
	uint16_t node_list[OSASERVER_MAX_NODE_LIST];

	bool downloading;
	bool node_download_request;
	uint16_t node_down_index;
	uint16_t node_down_len;

	uint16_t one_query_node;
	bool one_query;

	osacomm_cmd_run_app_t run_arg;


	uint16_t reboot_node;
} osaserver_state_t;


#endif /* OSASERVERCORE_H */

