//=============================================================================
//	Document:		SHTxxC.nc
//	Description:	配置源文件，用于配置SHTxx温湿度传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration SHTxxC
{
	provides interface SensorData;
}
implementation
{
	components SHTxxP;
	components SHTxxDataC;

	SensorData = SHTxxP;
	SHTxxP.SHTxxData -> SHTxxDataC;
}
