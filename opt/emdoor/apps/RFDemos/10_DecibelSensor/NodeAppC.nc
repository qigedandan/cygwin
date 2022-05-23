//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ�ֱ�������
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
	components DecibelAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	DecibelAppM.Boot -> MainC;
	DecibelAppM.SensorTimer -> SensorTimerC;
	DecibelAppM.SensorCollection -> SensorCollectionC;

    DecibelAppM.WsnControl -> WsnC.StdControl;
    DecibelAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    DecibelAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    DecibelAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    DecibelAppM.AMPacket -> WsnC.AMPacket;

}

