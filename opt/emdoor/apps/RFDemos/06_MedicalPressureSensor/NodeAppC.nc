//=============================================================================
//	Document:		NodeAppC.nc
//	Description:	����Դ�ļ����������ýڵ�������������Ϊҽ����ѹ������
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
	components MedicalPressureAppM;
	components MainC;
	components new TimerMilliC() as SensorTimerC;
	components SensorCollectionC;
    components WsnC;
    
	MedicalPressureAppM.Boot -> MainC;
	MedicalPressureAppM.SensorTimer -> SensorTimerC;
	MedicalPressureAppM.SensorCollection -> SensorCollectionC;

    MedicalPressureAppM.WsnControl -> WsnC.StdControl;
    MedicalPressureAppM.Send -> WsnC.Send[EM_MSG_SENSOR];    
    MedicalPressureAppM.Intercept -> WsnC.Intercept[EM_MSG_SENSOR];
    MedicalPressureAppM.Snoop -> WsnC.Snoop[EM_MSG_SENSOR];
    MedicalPressureAppM.AMPacket -> WsnC.AMPacket;

}

