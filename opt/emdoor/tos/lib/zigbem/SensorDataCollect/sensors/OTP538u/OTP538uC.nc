//=============================================================================
//	Document:		OTP538uC.nc
//	Description:	配置源文件，用于配置OTP538u红外热电堆传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration OTP538uC
{
	provides interface SensorData;
}
implementation
{
	components OTP538uP;
	components new AdcC() as OTP538u;

	SensorData = OTP538uP;
	OTP538uP.OTP538uControl -> OTP538u;
    OTP538uP.OTP538uRead -> OTP538u;
}

