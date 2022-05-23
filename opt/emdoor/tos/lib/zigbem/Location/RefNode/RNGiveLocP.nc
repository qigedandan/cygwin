
#include "ALServerCmdPacket.h"
#include "LocPacket.h"

module RNGiveLocP
{
	provides interface Init;
	
	uses interface LocPacket;
	uses interface GetCfgData;
	uses interface Timer<TMilli> as Timer;
	
}
implementation
{
#define STATE_OK 1
	enum
	{
		GIVE_SPEED = 500,
	};

	typedef struct _loc_xy
	{
		uint16_t loc_x;
		uint16_t loc_y;
	} loc_xy;
	
	loc_xy loc;
	loc_packet_t rn_pack;
	ref_node_info_t info;

	uint16_t CmdNodeAddr;

	task void sendState()
	{
		if (CmdNodeAddr != 0x0000)
		{
			info.state = 0;
			info.loc_x = loc.loc_x;
			info.loc_y = loc.loc_y;

			rn_pack.type = LT_RN_2CN_STATE;
			rn_pack.header.addr = CmdNodeAddr ;
			rn_pack.header.len = sizeof(lp_rn2cn_state_t) - sizeof(lp_header_t) ;
			rn_pack.lp_rn2cn_state.state = info.state ;
			rn_pack.lp_rn2cn_state.LocX = info.loc_x ;
			rn_pack.lp_rn2cn_state.LocY = info.loc_y ;

			call LocPacket.Send(&rn_pack);
		}
	}

	task void sendLocPacket()
	{		
		rn_pack.type = LT_RN_2BN_LOC ;
		rn_pack.header.addr = 0xffff ;
		rn_pack.header.len = sizeof(lp_rn2bn_loc_t) - sizeof(lp_header_t) ;
		rn_pack.lp_rn2bn_loc.LocX =  loc.loc_x;
		rn_pack.lp_rn2bn_loc.LocY =  loc.loc_y;

		call LocPacket.Send(&rn_pack);
		ADBG(200,"\r\nsendLocPacket()");
	}

	event void Timer.fired()
	{
		post sendLocPacket();
		ADBG(DBG_LEV,"\r\nTimer.fired()");
	}

	command error_t Init.init()
	{
		#ifdef LOC_XY
	       loc.loc_x = LOC_X;
	       loc.loc_y = LOC_Y;
	       call GetCfgData.Write((uint8_t *)(&loc),sizeof(loc_xy));
	   #endif

	       call GetCfgData.Read((uint8_t *)(&loc),sizeof(loc_xy));
	       ADBG(200, " [RNGiveLocP] x=%d , y=%d \r\n",(int)loc.loc_x,(int)loc.loc_y);

		   	
	       post sendState();
		   call Timer.startPeriodic(GIVE_SPEED);
		return SUCCESS;
	}

	event void LocPacket.Receive(loc_packet_t* lp_t)
	{
		if ((lp_t->type) == LT_CN_2RN_SET_LOC)
		{

			loc.loc_x = lp_t->lp_cn2rn_set_loc.LocX ;
			loc.loc_y = lp_t->lp_cn2rn_set_loc.LocY ;
			ADBG(DBG_LEV,"\r\nLT_CN_2RN_SET_LOC___");
			ADBG(DBG_LEV,"\r\nLT_CN_2RN_SET_LOC___loc_x = %d",(int)(loc.loc_x));
			ADBG(DBG_LEV,"\r\nLT_CN_2RN_SET_LOC___loc_y = %d\r\n",(int)(loc.loc_y));
			call GetCfgData.Write((uint8_t *)(&loc),sizeof(loc_xy));

			CmdNodeAddr = lp_t->header.addr;
			post sendState();
		}
		else if ((lp_t->type) == LT_CN_2RN_QUERY)
		{
			CmdNodeAddr = lp_t->header.addr;
			post sendState();
		}
	}

	event void LocPacket.SendDone(error_t success)
	{
		ADBG(20, "LocPacket.SendDone\n");
	}
}
