//=============================================================================
//	Document:		SS411aC.nc
//	Description:	����Դ�ļ�����������SS411a�����ߴ���������������
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
