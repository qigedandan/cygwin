//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ��ȼ���崫����
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
	components SmokeAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	SmokeAppM.Boot -> MainC;
	SmokeAppM.SensorTimer -> SensorTimerC;
	SmokeAppM.SensorCollection -> SensorCollectionC;

    SmokeAppM.WsnControl -> WsnC.StdControl;
    SmokeAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    SmokeAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    SmokeAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    SmokeAppM.AMPacket -> WsnC.AMPacket;

}

