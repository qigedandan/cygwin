//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ��δ�����
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
	components RainAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	RainAppM.Boot -> MainC;
	RainAppM.SensorTimer -> SensorTimerC;
	RainAppM.SensorCollection -> SensorCollectionC;

    RainAppM.WsnControl -> WsnC.StdControl;
    RainAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    RainAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    RainAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    RainAppM.AMPacket -> WsnC.AMPacket;

}

