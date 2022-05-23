//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为火焰传感器
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
	components FireAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	FireAppM.Boot -> MainC;
	FireAppM.SensorTimer -> SensorTimerC;
	FireAppM.SensorCollection -> SensorCollectionC;

    FireAppM.WsnControl -> WsnC.StdControl;
    FireAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    FireAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    FireAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    FireAppM.AMPacket -> WsnC.AMPacket;

}

