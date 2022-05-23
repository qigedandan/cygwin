
#include "OSAComm.h"

interface OSACommClient
{
	/**/
	command error_t sendNodeInfo(uint16_t server_addr, osanode_info_t *node);
	command error_t downNodeDataAck(uint16_t server_addr, uint8_t *data, uint8_t len);


	/**/
	event void sendNodeInfoDone(error_t error);
	event void downNodeDataAckDone(error_t error);
	
	
	/**/
	event void queryNodeInfoFired(uint16_t server_addr);
	event void runUsrAppFired(uint16_t server_addr, osacomm_cmd_run_app_t * run_app_arg);
	event void downNodeDataFired(uint16_t server_addr);
	event void rebootNodesFired(uint16_t server_addr);
}

