//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ��ѹ������
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
	components AirPressureAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	AirPressureAppM.Boot -> MainC;
	AirPressureAppM.SensorTimer -> SensorTimerC;
	AirPressureAppM.SensorCollection -> SensorCollectionC;

    AirPressureAppM.WsnControl -> WsnC.StdControl;
    AirPressureAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    AirPressureAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    AirPressureAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    AirPressureAppM.AMPacket -> WsnC.AMPacket;

}

