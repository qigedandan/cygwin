#include "Location.h"
#include "LocPacket.h"

module CalcBNLocP
{
	provides interface UpdateLoc;

	uses interface UpdateLocInfo;
	uses interface Timer<TMilli> as Timer;
	uses interface CalcLocation;
}
implementation
{
#define 	DEFAULT_PARA_A  45
#define 	DEFAULT_PARA_N  13

	LocRefNode_t mref[16];
	LocBlindNode_t mblind ;
	LocDevPara_t mpara ;
	
	uint8_t refNum;
	

	enum
	{
		UPDATE_LOCATION_PERIOD = 3000 , 
	};



	command void UpdateLoc.Init()
	{
		mpara.param_a = DEFAULT_PARA_A;
		mpara.param_n = DEFAULT_PARA_N;		
		call Timer.startPeriodic(UPDATE_LOCATION_PERIOD);
	}
	command void UpdateLoc.SetCalcPara(uint8_t param_a,uint8_t param_n)
	{
		mpara.param_a = param_a;
		mpara.param_n = param_n;		
	}

	task void doCalc()
	{
/*	uint8_t x;
		memset(mref,0,sizeof(LocRefNode_t)*16);
#define DBG_NODE_INFO 2
		ADBG(DBG_NODE_INFO,"\r\nrefNum = %d",(int)(refNum));
		for(x=0;x<16;x++)
		{
			ADBG(DBG_NODE_INFO,"\nmref[%d] x=%d , y=%d , rssi=%d , addr=%d ",(int)(x),(int)(mref[x].x),(int)(mref[x].y),(int)(mref[x].rssi),(int)(mref[x].addr));
		}
*/		
		call UpdateLocInfo.Update(mref,&refNum);

/*
		ADBG(DBG_NODE_INFO,"\r\nrefNum = %d",(int)(refNum));
		for(x=0;x<16;x++)
		{
			ADBG(DBG_NODE_INFO,"\nmref[%d] x=%d , y=%d , rssi=%d , addr=%d ",(int)(x),(int)(mref[x].x),(int)(mref[x].y),(int)(mref[x].rssi),(int)(mref[x].addr));
		}
*/		
		call CalcLocation.Calc(&mblind,&mpara,mref);
		//signal UpdateLoc.Fired(&mblind,&mpara,&refNum);
	}

	event void Timer.fired()
	{
		post doCalc();
	}

	event void CalcLocation.CalcFinish()
	{
		signal UpdateLoc.Fired(&mblind,&mpara,&refNum);
	}

	default event void UpdateLoc.Fired(LocBlindNode_t *blind,LocDevPara_t *locpara,uint8_t *RefNum){}
}

