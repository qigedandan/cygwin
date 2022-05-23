//=============================================================================
//	Document:		MPS150aC.nc
//	Description:	配置源文件，用于配置MPS150a气压传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration MPS150aC
{
	provides interface SensorData;
}
implementation
{
	components MPS150aP;
	components new AdcC() as MPS150a;

	SensorData = MPS150aP;
	MPS150aP.MPS150aControl -> MPS150a;
    MPS150aP.MPS150aRead -> MPS150a;
}
