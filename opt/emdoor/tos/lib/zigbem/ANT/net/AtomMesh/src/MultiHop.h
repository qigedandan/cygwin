

#ifndef _TOS_MULTIHOP_H
#define _TOS_MULTIHOP_H

#define XMESH_DEBUG

#ifdef XMESH_DEBUG
#define XDBG(t, s,...)	ADBG(1, s)
#else
#define XDBG(t, s,...)
#endif


#include <message.h>


enum {
  AM_MULTIHOPMSG = 250,
  AM_DEBUGPACKET = 3 
};

/* Fields of neighbor table */
typedef struct TOS_MHopNeighbor {
  uint16_t addr;                     // state provided by nbr
  uint16_t recv_count;               // since last goodness update
  uint16_t fail_count;               // since last goodness, adjusted by TOs
  int16_t last_seqno;
  uint8_t goodness;
  uint8_t hopcount;
  uint8_t timeouts;		     // since last recv
} TOS_MHopNeighbor;
  
typedef struct MultihopMsg {
  uint16_t sourceaddr;
  uint16_t originaddr;
  int16_t seqno;
  uint8_t hopcount;
  uint8_t data[(TOSH_DATA_LENGTH - 7)]; 
} __attribute__ ((packed)) TOS_MHopMsg;

typedef struct DBGEstEntry {
  uint16_t id;
  uint8_t hopcount;
  uint8_t sendEst;
} __attribute__ ((packed)) DBGEstEntry;


typedef struct DebugPacket {
  uint8_t estEntries;
  DBGEstEntry estList[5];
} __attribute__ ((packed)) DebugPacket;


#define SEND_FAIL_CHOOSE_NEW    2

#define SEND_FAIL_RETRY_MAX     3

#endif /* _TOS_MULTIHOP_H */

