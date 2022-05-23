//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ��ʪ�ȴ�����
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
	components TempAndHumiAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	TempAndHumiAppM.Boot -> MainC;
	TempAndHumiAppM.SensorTimer -> SensorTimerC;
	TempAndHumiAppM.SensorCollection -> SensorCollectionC;

    TempAndHumiAppM.WsnControl -> WsnC.StdControl;
    TempAndHumiAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    TempAndHumiAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    TempAndHumiAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    TempAndHumiAppM.AMPacket -> WsnC.AMPacket;

}

