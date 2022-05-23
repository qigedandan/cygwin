//=============================================================================
//	Document:		SSM002C.nc
//	Description:	配置源文件，用于配置SSM002雨滴传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration SSM002C
{
	provides interface SensorData;
}
implementation
{
	components SSM002P;
	components new AdcC() as SSM002;

	SensorData = SSM002P;
	SSM002P.SSM002Control -> SSM002;
    SSM002P.SSM002Read -> SSM002;
}

