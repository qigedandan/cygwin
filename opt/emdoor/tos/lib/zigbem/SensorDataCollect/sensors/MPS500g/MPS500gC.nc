//=============================================================================
//	Document:		MPS500gC.nc
//	Description:	����Դ�ļ�����������MPS500gҽ����ѹ����������������
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
