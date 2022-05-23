//=============================================================================
//	Document:		UVA1210C.nc
//	Description:	配置源文件，用于配置UVA1210紫外线传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration UVA1210C
{
	provides interface SensorData;
}
implementation
{
	components UVA1210P;
	components new AdcC() as UVA1210;

	SensorData = UVA1210P;
	UVA1210P.UVA1210Control -> UVA1210;
    UVA1210P.UVA1210Read -> UVA1210;
}

