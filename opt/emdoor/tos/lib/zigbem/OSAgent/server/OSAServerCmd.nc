#include "OSAServerCmdPacket.h"
#include "OSAComm.h"

interface OSAServerCmd
{
	/* PC -> Server */
	event void pingServerFired();
	event void queryNodesFired();
	event void runUsrAppFired(osacomm_cmd_run_app_t *run_arg);
	event void downDataFired();
	event void rebootNodesFired(uint16_t addr);


	/* Server -> PC */
	command error_t pingServerAck(osaserver_cmd_server_info_t *server_info);
	event void pingServerAckDone(error_t error);
	
	command error_t sendNodeInfo(osanode_info_t *node_info);
	event void sendNodeInfoDone(error_t error);

	command error_t downDataAck(uint8_t *data, int8_t len);
	event void downDataAckDone(error_t error);

	command error_t downDataResult(uint8_t result);
	event void downDataResultDone(error_t error);
}

