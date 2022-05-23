//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为远红外传感器
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
	components InfraredAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	InfraredAppM.Boot -> MainC;
	InfraredAppM.SensorTimer -> SensorTimerC;
	InfraredAppM.SensorCollection -> SensorCollectionC;

    InfraredAppM.WsnControl -> WsnC.StdControl;
    InfraredAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    InfraredAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    InfraredAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    InfraredAppM.AMPacket -> WsnC.AMPacket;

}

