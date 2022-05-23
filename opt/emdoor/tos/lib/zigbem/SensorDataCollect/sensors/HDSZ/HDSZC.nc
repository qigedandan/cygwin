//=============================================================================
//	Document:		HDSZC.nc
//	Description:	����Դ�ļ�����������HDSZ�𶯴���������������
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

