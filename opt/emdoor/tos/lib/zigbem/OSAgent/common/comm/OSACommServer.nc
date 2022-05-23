
#include "OSAComm.h"

interface OSACommServer
{
	/**/
	command error_t queryNodes(uint16_t server_addr, uint16_t addr);
	command error_t runUsrApp(uint16_t server_addr, uint16_t addr, osacomm_cmd_run_app_t *arg);
	command error_t downNodeData(uint16_t server_addr, uint16_t addr);
	command error_t rebootNodes(uint16_t server_addr, uint16_t addr);


	/**/
	event void querNodesDone(error_t error);
	event void runUsrAppDone(error_t error);
	event void downNodeDataDone(error_t error);
	event void rebootNodesDone(error_t error);
	
	event void receiveNodeInfo(uint16_t addr, uint16_t dest_addr, osanode_info_t *node);
	event void downNodeDataAck(uint16_t addr, uint8_t *data, uint8_t len);
	
}

