//=============================================================================
//	Document:		MQ2C.nc
//	Description:	配置源文件，用于配置MQ2可燃气体传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration MQ2C
{
	provides interface SensorData;
}
implementation
{
	components MQ2P;
	components new AdcC() as MQ2;

	SensorData = MQ2P;
	MQ2P.MQ2Control -> MQ2;
    MQ2P.MQ2Read -> MQ2;
}

