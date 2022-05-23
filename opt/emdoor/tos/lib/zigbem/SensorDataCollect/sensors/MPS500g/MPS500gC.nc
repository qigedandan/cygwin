//=============================================================================
//	Document:		MPS500gC.nc
//	Description:	配置源文件，用于配置MPS500g医用气压传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration MPS500gC
{
	provides interface SensorData;
}
implementation
{
	components MPS500gP;
	components new AdcC() as MPS500g;

	SensorData = MPS500gP;
	MPS500gP.MPS500gControl -> MPS500g;
	MPS500gP.MPS500gRead -> MPS500g;
}
