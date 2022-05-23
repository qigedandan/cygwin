
#ifndef LOCPACKET_H
#define LOCPACKET_H

enum
{
	LOC_PACKET_KEY = 0x33,
	LOC_MAX_PACKETDATA_LEN = 32,
	LP_HEADER_LEN = 4,
};

enum
{
	LT_BN_2RN_REQ	= 0x10,
	LT_BN_2CN_STATE = 0x11,

	LT_RN_2BN_LOC= 0x20,
	LT_RN_2CN_STATE = 0x21,

	/*  Query nodes information... */
	LT_CN_2RN_QUERY			= 0x30,
	LT_CN_2BN_QUERY			= 0x31,

		
	LT_CN_2RN_SET_LOC 	= 0x41,
	
	LT_CN_2BN_LOC_AUTO 	= 0x45,	
	LT_CN_2BN_CALC_IMM 	= 0x46,
	LT_CN_2BN_CFG_AUTO	= 0x47,
	LT_CN_2BN_CFG_IMM	= 0x48,	
};


typedef struct _lp_header
{
	uint8_t type;
	uint8_t len;
	uint16_t addr;
} lp_header_t;



typedef struct _lp_bn2rn_req
{
	lp_header_t header;
	uint8_t rssi;
	uint8_t StopFlag;
} lp_bn2rn_req_t;

typedef struct _lp_bn2cn_state
{
	lp_header_t header;
	uint8_t state;
	uint8_t RefNum;
	uint8_t AutoFlag;
	uint8_t ParamA;
	uint8_t ParamN;
	uint16_t LocX;
	uint16_t LocY;	
} lp_bn2cn_state_t;

typedef struct _lp_rn2bn_loc
{
	lp_header_t header;
	uint8_t rssi;
	uint16_t LocX;
	uint16_t LocY;	
} lp_rn2bn_loc_t;

typedef struct _lp_rn2cn_state
{
	lp_header_t header;
	uint8_t state;
	uint16_t LocX;
	uint16_t LocY;		
} lp_rn2cn_state_t;

typedef struct _lp_cn2rn_query
{
	lp_header_t header;

} lp_cn2rn_query_t;

typedef struct _lp_cn2bn_query
{
	lp_header_t header;

} lp_cn2bn_query_t;

typedef struct _lp_cn2rn_set_loc
{
	lp_header_t header;
	uint16_t LocX;
	uint16_t LocY;
} lp_cn2rn_set_loc_t;

typedef struct _lp_cn2bn_loc_auto
{
	lp_header_t header;
	uint8_t Flag;
} lp_cn2bn_loc_auto_t;

typedef struct _lp_cn2bn_calc_imm
{
	lp_header_t header;

} lp_cn2bn_calc_imm_t ;

typedef struct _lp_cn2bn_cfg_auto
{
	lp_header_t header;
	uint16_t LocX;
	uint16_t LocY;		
} lp_cn2bn_cfg_auto_t ;

typedef struct _lp_cn2bn_cfg_imm
{
	lp_header_t header;
	uint8_t ParamA;
	uint8_t ParamN;
} lp_cn2bn_cfg_imm_t ;



typedef union _loc_packet
{
	uint8_t type;
	lp_header_t header;
	uint8_t data[LOC_MAX_PACKETDATA_LEN];
	lp_bn2rn_req_t 	lp_bn2rn_req;
	lp_bn2cn_state_t lp_bn2cn_state; 
	lp_rn2bn_loc_t 	lp_rn2bn_loc;
	lp_rn2cn_state_t lp_rn2cn_state;
	lp_cn2rn_query_t	lp_cn2rn_query;
	lp_cn2bn_query_t	lp_cn2bn_query;
	lp_cn2rn_set_loc_t	lp_cn2rn_set_loc;
	lp_cn2bn_loc_auto_t	lp_cn2bn_loc_auto;
	lp_cn2bn_calc_imm_t	lp_cn2bn_calc_imm;
	lp_cn2bn_cfg_auto_t	lp_cn2bn_cfg_auto;
	lp_cn2bn_cfg_imm_t	lp_cn2bn_cfg_imm;
} loc_packet_t;

#include "OSARF.h"

#endif /* LOCPACKET_H */

