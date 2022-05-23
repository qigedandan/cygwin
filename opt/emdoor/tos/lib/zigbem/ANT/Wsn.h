#ifndef WSN_H
#define WSN_H

#include "MultiHop.h"
/*************************************************************************/
/* WSN Radio Config */

#ifndef EM_RADIO_CHANNEL
#define EM_RADIO_CHANNEL		11
#endif

#ifndef EM_RADIO_POWER
#define EM_RADIO_POWER			100
#endif

#ifndef EM_RADIO_ACK_TIME 
#define EM_RADIO_ACK_TIME       500
#endif

#ifndef RADIO_SEND_QUEUE_SIZE
#define EM_RADIO_SEND_QUEUE_SIZE		200
#endif

#ifndef RADIO_RECEIVE_QUEUE_SIZE
#define EM_RADIO_RECEIVE_QUEUE_SIZE		200
#endif

#ifndef EM_ROUTE_UPDATE_TIME
#define EM_ROUTE_UPDATE_TIME   			3000
#endif



/****************************************************************************/
#define EM_MSG_SENSOR 		0x28

//in face in the flash 0x1fff8, use MEMCTR.FMAP to access this one
#define EM_IEEE_BASE		0xFFF8
#define EM_IEEE_FMAP		3

#define EM_IEEE_BYTE(n)		(*(uint8_t_code *)(EM_IEEE_BASE+n))


#define EM_MSG     			TOS_MHopMsg

#endif

