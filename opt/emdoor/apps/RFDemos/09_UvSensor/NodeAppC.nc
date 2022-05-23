//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ�����ߴ�����
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
	components UvAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	UvAppM.Boot -> MainC;
	UvAppM.SensorTimer -> SensorTimerC;
	UvAppM.SensorCollection -> SensorCollectionC;

    UvAppM.WsnControl -> WsnC.StdControl;
    UvAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    UvAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    UvAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    UvAppM.AMPacket -> WsnC.AMPacket;

}

