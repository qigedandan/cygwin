//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为气压传感器
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

