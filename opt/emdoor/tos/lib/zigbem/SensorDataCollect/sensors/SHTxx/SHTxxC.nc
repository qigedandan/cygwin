//=============================================================================
//	Document:		SHTxxC.nc
//	Description:	����Դ�ļ�����������SHTxx��ʪ�ȴ���������������
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration SHTxxC
{
	provides interface SensorData;
}
implementation
{
	components SHTxxP;
	components SHTxxDataC;

	SensorData = SHTxxP;
	SHTxxP.SHTxxData -> SHTxxDataC;
}
