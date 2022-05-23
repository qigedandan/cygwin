#include "Location.h"
#include "LocPacket.h"

module UpdateLocInfoP
{
	provides interface UpdateLocInfo;

	uses interface LocPacket;  
}
implementation
{

#define MAX_REF_NODE_NUM 16
#define MAX_TICKS_DIFF  64
#define AVERAGE_RSSI_NUM 3

	uint8_t ListLock = 0 ;
	uint8_t m_NodeNum=0;
	uint32_t mRecePackNum=0;
	RefNodeList16_t refList[MAX_REF_NODE_NUM];
	
	/*==========*/

	error_t serchAddr(uint16_t addr,uint8_t *mListAddr);
	void searchEarliestList(uint8_t *mListAddr);
	error_t searchAvailableAddr(uint8_t *mListAddr);	
	
	
	error_t serchAddr(uint16_t addr,uint8_t *mListAddr)
	{
		uint8_t i;
		for(i=0;i<MAX_REF_NODE_NUM;i++)	
		{
			if(refList[i].useFlag)
			{
				if(refList[i].addr == addr)
				{
					*mListAddr = i;
					return SUCCESS;
				}
			}
		}
		searchAvailableAddr(mListAddr);
		return SUCCESS;
	}

	void searchEarliestList(uint8_t *mListAddr)
	{
		uint8_t i;
		uint8_t j;
		uint32_t maxTicks = 0;
		for(i=0;i<MAX_REF_NODE_NUM;i++)	
		{
			if(refList[i].last_packet_tick < mRecePackNum)
			{
				if(maxTicks < (mRecePackNum - (refList[i].last_packet_tick)))
				{
					maxTicks = mRecePackNum - (refList[i].last_packet_tick);
					j = i ;
				}
			}
			else
			{
				if(maxTicks < (mRecePackNum - (refList[i].last_packet_tick) + 0xffffffff))
				{
					maxTicks = mRecePackNum - (refList[i].last_packet_tick) + 0xffffffff;
					j = i ;
				}
			}
		}
		*mListAddr = j ;
		memset(&(refList[j]),0,sizeof(RefNodeList16_t));
	}

	error_t searchAvailableAddr(uint8_t *mListAddr)
	{
		uint8_t i;
		for(i=0;i<MAX_REF_NODE_NUM;i++)	
		{
			if(!(refList[i].useFlag))
			{
				*mListAddr = i;
				return SUCCESS;
			}
		}
		*mListAddr = 0;
//		searchEarliestList(mListAddr);
		return SUCCESS;
	}
	
	void DeleteEarlyList()
	{
		uint8_t i;
		uint32_t mTicks;
		for(i=0;i<MAX_REF_NODE_NUM;i++)	
		{
			if(refList[i].last_packet_tick < mRecePackNum)
			{
				mTicks = mRecePackNum - (refList[i].last_packet_tick);
			}
			else
			{
				mTicks = mRecePackNum - (refList[i].last_packet_tick) + 0xffffffff;
			}
			
			if(mTicks > MAX_TICKS_DIFF)
			{
				memset(&(refList[i]),0,sizeof(RefNodeList16_t));
			}
		}
	}
	

	void insertList(uint8_t mListAddr,LocRefNode_t *ref)
	{
		refList[mListAddr].rssi[refList[mListAddr].rssiNum] = ref->rssi ;	

		refList[mListAddr].rssiNum++;
		if((refList[mListAddr].rssiNum) == MAX_LIST_RSSI_NUM)
		{	
			refList[mListAddr].rssiNum = 0;
		}
			
		refList[mListAddr].last_packet_tick = mRecePackNum ;

		if(!(refList[mListAddr].useFlag)) 	// insert new node info
		{
			refList[mListAddr].useFlag = 1 ;
			refList[mListAddr].addr  = ref-> addr;
			refList[mListAddr].x = ref-> x;
			refList[mListAddr].y = ref-> y;			
		}
	}

	void calcAverageRssi(LocRefNode_t *refNodeInfo,uint8_t *refNodeNum)
	{
		uint8_t i,t;
		uint8_t mRssi;
		uint8_t aRssi[AVERAGE_RSSI_NUM];
		uint8_t j=0;

//		DeleteEarlyList();
		memset(refNodeInfo,0,sizeof(LocRefNode_t)*16); 

		for(i=0;i < MAX_REF_NODE_NUM ;i++)
		{
			if(refList[i].useFlag)
			{
				mRssi = 0;
#define dbg_list_lev 2			
				ADBG(dbg_list_lev,"\r\nrefList[i].last_packet_tick = %d",(int)(refList[i].last_packet_tick));
				if(refList[i].rssiNum > AVERAGE_RSSI_NUM)
				{
					ADBG(dbg_list_lev,"\r\n...refList[i].rssiNum = %d",(int)(refList[i].rssiNum));
					memcpy(aRssi,&(refList[i].rssi[refList[i].rssiNum-AVERAGE_RSSI_NUM-1]),AVERAGE_RSSI_NUM);
					mRssi = aRssi[0];
					ADBG(dbg_list_lev,"\r\n...mRssi = %d",(int)(mRssi));
					for(t=1;t<AVERAGE_RSSI_NUM;t++)
					{
						mRssi = ( aRssi[t] + mRssi )/2 ;
						ADBG(dbg_list_lev,"\r\n...mRssi = %d",(int)(mRssi));						
					}
				}
				else
				{
					ADBG(dbg_list_lev,"\r\n____refList[i].rssiNum = %d",(int)(refList[i].rssiNum));
					mRssi = refList[i].rssi[0];
					ADBG(dbg_list_lev,"\r\n___mRssi = %d",(int)(mRssi));						
					for(t=1;t<(refList[i].rssiNum);t++)
					{
						mRssi = ( refList[i].rssi[t] + mRssi )/2 ;
						ADBG(dbg_list_lev,"\r\n___mRssi = %d",(int)(mRssi));						
					}
				}
				refNodeInfo[j].rssi = mRssi;
				refNodeInfo[j].x = refList[i].x;
				refNodeInfo[j].y = refList[i].y;
				refNodeInfo[j].addr = refList[i].addr;
				j++;
			}
		}
		*refNodeNum = j ;		
	}

		
	/*==========*/

	command void UpdateLocInfo.Update(LocRefNode_t *refNodeInfo,uint8_t *refNodeNum)
	{
		ListLock = 1;
		calcAverageRssi(refNodeInfo,refNodeNum);
		ListLock = 0;
	}


	event void LocPacket.SendDone(error_t success){}

	event void LocPacket.Receive(loc_packet_t* lp_t)
	{
		uint8_t mlist;
		LocRefNode_t ref;

		uint8_t i;
		uint8_t j;

#define DBG_BN_LIST 200	

		//ADBG(20, " LocPacket.Receive addr=0x%04x ", (int)lp_t->header.addr);
		if(ListLock == 0)
		{
		if ((lp_t -> type) == LT_RN_2BN_LOC)
		{	
			mRecePackNum ++ ;	
			
			ref.x = (uint8_t)(lp_t->lp_rn2bn_loc.LocX) ;
			ref.y = (uint8_t)(lp_t->lp_rn2bn_loc.LocY) ;
			ref.addr = (uint16_t)lp_t->header.addr;
//			ref.rssi = (uint8_t)(lp_t->lp_rn2bn_loc.rssi) ;
			ref.rssi = (uint8_t)(lp_t->lp_rn2bn_loc.rssi)+18;
			serchAddr(ref.addr,&mlist);
			insertList(mlist,&ref);
					ADBG(200,"*");
//	ADBG(200, "\n mRecePackNum=%d\n", (int)mRecePackNum);
//	ADBG(DBG_BN_LIST, "\nUpdate to %d address 0x%04x, x=%d, y=%d, rssi=%d", (int)mlist, (int)lp_t->header.addr, (int)lp_t->lp_rn2bn_loc.LocX, (int)lp_t->lp_rn2bn_loc.LocY, (int)ref.rssi);		

//		ADBG(DBG_BN_LIST,"\r\n\r\nUpdateLocInfo.Update");		
//		i=0;
/*		for(i=0;i<16;i++)
		{
			ADBG(DBG_BN_LIST,"\r\nUpdateLocInfo.Update___list = %d",(int)(i));		
			ADBG(DBG_BN_LIST,"\r\nrefList[i].useFlag = %d",(int)(refList[i].useFlag));
			ADBG(DBG_BN_LIST,"\r\nrefList[i].rssiNum = %d",(int)(refList[i].rssiNum));
			ADBG(DBG_BN_LIST,"\r\nrefList[i].x = %d",(int)(refList[i].x));			
			ADBG(DBG_BN_LIST,"\r\nrefList[i].y = %d",(int)(refList[i].y));						
			ADBG(DBG_BN_LIST,"\r\nrefList[i].addr = %d",(int)(refList[i].addr));									
			ADBG(DBG_BN_LIST,"\r\nrefList[i].last_packet_tick = %d",(int)(refList[i].last_packet_tick));
			for(j=0;j<8;j++)
			{
				ADBG(DBG_BN_LIST,"\r\nrefList[i].rssi[%d] = %d",(int)(j),(int)(refList[i].rssi[j]));
			}
		}
*/
		}
		}
	}
}
