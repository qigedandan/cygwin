//=============================================================================
//	Document:		DS18B20C.nc
//	Description:	配置源文件，用于配置DS18B20温度传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration DS18B20C
{
	provides interface SensorData;	
}
implementation
{
	components DS18B20P;
	components DS18B20DataC;

	SensorData=DS18B20P;
	DS18B20P.DS18B20Data -> DS18B20DataC;
}
