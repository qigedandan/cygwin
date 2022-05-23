//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ����������
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

#include "Wsn.h"
configuration NodeAppC
{
}
implementation
{
	components HallAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	HallAppM.Boot -> MainC;
	HallAppM.SensorTimer -> SensorTimerC;
	HallAppM.SensorCollection -> SensorCollectionC;

    HallAppM.WsnControl -> WsnC.StdControl;
    HallAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    HallAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    HallAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    HallAppM.AMPacket -> WsnC.AMPacket;

}

