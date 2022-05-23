
#include "StaticRoute.h"

interface StaticRoute {
	command uint16_t getUplinkNode(uint16_t src, staticroute_t *route_table, uint16_t size);
	command uint16_t getDownlinkNode(uint16_t src, staticroute_t *route_table, uint16_t size);
}

