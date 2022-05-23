#include "QuickRoute.h"

interface QuickRouteEngine {
	command void resetRoute();

	command bool isEmptyRoute();

	command void enableRouteAutoUpdate(uint32_t interval);
	command void disableRouteAutoUpdate();
	
	command error_t updateEmptyRoute(uint32_t timeout_ms);
	command void broadcastFailRoute();
	
	command uint16_t getParent();

	command error_t selectRoute(message_t* msg);
	command void invalidCurrentRoute();
	command void initializeFields(message_t* msg);

	command quickroute_data_header_t *getRouteDataHeader(message_t *msg);

	command bool forwardProcess(message_t *msg);
}
	
	
