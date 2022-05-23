//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	配置源文件，用于配置节点的驱动程序组件为震动传感器
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
	components VibrationAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	VibrationAppM.Boot -> MainC;
	VibrationAppM.SensorTimer -> SensorTimerC;
	VibrationAppM.SensorCollection -> SensorCollectionC;

    VibrationAppM.WsnControl -> WsnC.StdControl;
    VibrationAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    VibrationAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    VibrationAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    VibrationAppM.AMPacket -> WsnC.AMPacket;

}

