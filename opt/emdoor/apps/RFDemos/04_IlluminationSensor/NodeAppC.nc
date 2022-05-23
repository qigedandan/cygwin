//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为光照传感器
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
	components IlluminationAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	IlluminationAppM.Boot -> MainC;
	IlluminationAppM.SensorTimer -> SensorTimerC;
	IlluminationAppM.SensorCollection -> SensorCollectionC;

    IlluminationAppM.WsnControl -> WsnC.StdControl;
    IlluminationAppM.Send -> WsnC.Send[EM_MSG_SENSOR];
    IlluminationAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    IlluminationAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    IlluminationAppM.AMPacket -> WsnC.AMPacket;
}

