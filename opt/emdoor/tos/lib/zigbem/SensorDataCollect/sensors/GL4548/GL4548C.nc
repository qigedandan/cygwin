//=============================================================================
//	Document:		GL4548C.nc
//	Description:	����Դ�ļ�����������GL4548�����������������
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration GL4548C
{
	provides interface SensorData;
}
implementation
{
	components GL4548P;
	components new AdcC() as GL4548;

	SensorData = GL4548P;
	GL4548P.GL4548Control -> GL4548;
    GL4548P.GL4548Read -> GL4548;
}
