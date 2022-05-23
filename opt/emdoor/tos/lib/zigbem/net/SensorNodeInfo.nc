/**
 * @ author xxl
 */
#include <AM.h>
interface SensorNodeInfo {
	command uint8_t getHopCount(message_t* msg);
	command void setHopCount(message_t* msg);

	command uint16_t getNodeType(message_t* msg);
	command void setNodeType(message_t* msg, uint16_t nodetype);
}
