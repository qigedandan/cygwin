#ifndef CLOCKSYNC_H
#define CLOCKSYNC_H

#include "TimerRTC.h"


#define CLOCKSYNC_AM_ID		199

#define CLOCKSYNC_ADJ_TIME		2

enum
{
	CLOCKSYNC_INVALID_DSN	= 0,
};

enum
{
	CLOCKSYNC_AM_TYPE_TIME = 111,	/* It's the command for sync time */
	CLOCKSYNC_AM_TYPE_REQ = 112,	/* It's the request for sync time */
};

typedef struct _clocksync_packet_t
{
	uint8_t type;
	uint8_t dsn;
	timerrtc_time_t time;
} clocksync_packet_t;

#define CLOCKSYNC_PACKET_PTR(p) ((clocksync_packet_t *)(p))


#endif /* CLOCKSYNC_H */

