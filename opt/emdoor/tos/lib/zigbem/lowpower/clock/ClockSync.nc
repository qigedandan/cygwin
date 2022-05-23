
#include "ClockSync.h"

interface ClockSync {
	command error_t start();
	command error_t stop();
	
	command error_t sourceBroadcast();
	command error_t requestSync();

	command bool isSynchornized();
	
	event void syncFired(bool unsyncBefore);
	event void requestSyncDone(error_t result);
	event void sourceBroadcastDone(error_t result);
}

