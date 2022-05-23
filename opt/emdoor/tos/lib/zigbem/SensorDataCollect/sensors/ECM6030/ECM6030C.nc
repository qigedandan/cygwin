//=============================================================================
//	Document:		ECM6030C.nc
//	Description:	配置源文件，用于配置ECM6030驻极体电容式麦克风的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration ECM6030C
{
	provides interface SensorData;
}
implementation
{
	components ECM6030P;
	components new AdcC() as ECM6030;

	SensorData = ECM6030P;
	ECM6030P.ECM6030Control -> ECM6030;
	ECM6030P.ECM6030Read -> ECM6030;
}

