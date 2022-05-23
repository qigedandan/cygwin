
#include "OSAComm.h"

interface OSAComm
{
	command error_t sendCmd(uint16_t addr, osacomm_cmd_t *cmd, uint8_t cmddata_size);
	event void sendCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error);
	
	event void receivedCmd(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd);
}

