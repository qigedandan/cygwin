

#ifndef OSACLIENTCORE_H
#define OSACLIENTCORE_H

#include "OSALogger.h"
#include "OSALoggerRF.h"

/*=====================================*/

enum
{
	OSACLIENT_MAX_ERROR = 10,
	OSACLIENT_UPLOAD_DATA_SIZE = sizeof(osalog_rf_t) * 8,
	OSACLIENT_UPLOAD_DATA_SMALL_SIZE = sizeof(osalog_rf_t) * 5,
};


typedef struct _osaclient_state
{
	uint16_t server_addr;
	uint8_t run_state;
	uint8_t run_state_prev;
	uint8_t error_count;
	uint32_t program_time;
	uint32_t program_start_time;

	/* User App control */
	bool m_launch_usr_app;
	uint32_t run_time_set;

	/* upload control */
	bool m_launch_upload;
	int32_t upload_offset;
	int32_t upload_len;
} osaclient_state_t;


enum
{
	OSACLIENT_RUN_AGENT_FREE = 0,
	OSACLIENT_RUN_AGENT_END_USR_APP = 1,
	OSACLIENT_RUN_AGENT_UPLOAD = 2,
	OSACLIENT_RUN_USR_APP = 10,
};


#endif /* OSACLIENTCORE_H */

