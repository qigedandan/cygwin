//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为分贝传感器
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

