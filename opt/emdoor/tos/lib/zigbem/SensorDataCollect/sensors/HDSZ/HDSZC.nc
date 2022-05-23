//=============================================================================
//	Document:		HDSZC.nc
//	Description:	配置源文件，用于配置HDSZ震动传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration HDSZC
{
	provides interface SensorData;
}
implementation
{
	components HDSZP;
	components new AdcC() as HDSZ;

	SensorData = HDSZP;
	HDSZP.HDSZControl -> HDSZ;
    HDSZP.HDSZRead -> HDSZ;
}

