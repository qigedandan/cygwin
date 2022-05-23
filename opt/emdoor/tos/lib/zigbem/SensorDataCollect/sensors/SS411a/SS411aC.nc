//=============================================================================
//	Document:		SS411aC.nc
//	Description:	配置源文件，用于配置SS411a紫外线传感器的驱动程序
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration SS411aC
{
	provides interface SensorData;
}
implementation
{
	components SS411aP;
	components SS411aDataC;

	SensorData = SS411aP;
	SS411aP.SS411aData-> SS411aDataC;    	
}
