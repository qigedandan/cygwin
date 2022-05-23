#ifndef ABS_H
#define ABS_H

#include "AM.h"

#define ABS_BUFFER_SIZE     512

///1
#define ABS_PACKET_SOP		0x37
#define ABS_PACKET_SOP_START 0

///2
#define ABS_PACKET_CMD_START	1
	#define ABS_CMD_RF_DATA	0x2430

///2
#define ABS_PACKET_LEN_START	3


///2
#define ABS_PACKET_NODE_TYPE_START	5
#define ABS_PACKET_NODE_TYPE_LEN        2

///2
//#define ABS_PACKET_NODE_ID_START		7
//#define ABS_PACKET_NODE_ID_LEN        2




//add so many meta info to the packet HEADER+FCS
//
#define ABS_PACKET_META_LEN    8

#define ABS_START_FCS(fcs, d)	(fcs) = (d)
#define ABS_CALC_FCS(fcs, d)		(fcs) ^= (d)
#define ABS_END_FCS(fcs)		(fcs)



#endif
