#include "ALServerCmdPacket.h"

interface ALServerCmd
{
	/* PC -> Server */
	event void pingServerFired();
	event void setRefNodesLocFired(uint16_t addr,uint16_t px,uint16_t py);
	event void setBliNodeLocAutoFired(uint16_t addr,uint8_t flag);
    event void reqBliNodeLocFired(uint16_t addr);
    event void setAdjAutoFired(uint16_t addr,uint16_t px,uint16_t py);
    event void setAdjImmFired(uint16_t addr,uint8_t param_a,uint8_t param_n);
    
	event void queryRefFired();
	event void queryBlindFired();

	/* Server -> PC */
	command error_t pingServerAck(alserver_cmd_server_info_t *server_info);
	event void pingServerAckDone(error_t error);
	
	command error_t sendBlindNodeInfo(blind_node_info_t *node_info);
	event void sendBlindNodeInfoDone(error_t error);
    
    command error_t sendRefNodeInfo(ref_node_info_t *node_info);
	event void sendRefNodeInfoDone(error_t error);
    
}

