//=============================================================================
//	Document:		D203sC.nc
//	Description:	配置源文件，用于配置D203s远红外传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration D203sC
{
	provides interface SensorData;
}
implementation
{
	components D203sP;
	components new AdcC() as D203s;

	SensorData = D203sP;
	D203sP.D203sControl -> D203s;
    D203sP.D203sRead -> D203s;
}

