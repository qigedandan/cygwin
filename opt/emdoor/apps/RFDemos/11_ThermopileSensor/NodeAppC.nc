//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊ�����ȵ�Ѵ�����
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
	components ThermopileAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	ThermopileAppM.Boot -> MainC;
	ThermopileAppM.SensorTimer -> SensorTimerC;
	ThermopileAppM.SensorCollection -> SensorCollectionC;

    ThermopileAppM.WsnControl -> WsnC.StdControl;
    ThermopileAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    ThermopileAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    ThermopileAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    ThermopileAppM.AMPacket -> WsnC.AMPacket;

}

