//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ�¶ȴ�����
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
	components TemperatureAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	TemperatureAppM.Boot -> MainC;
	TemperatureAppM.SensorTimer -> SensorTimerC;
	TemperatureAppM.SensorCollection -> SensorCollectionC;

    TemperatureAppM.WsnControl -> WsnC.StdControl;
    TemperatureAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    TemperatureAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    TemperatureAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    TemperatureAppM.AMPacket -> WsnC.AMPacket;

}

