//=============================================================================
//	Document:		D203sC.nc
//	Description:	����Դ�ļ�����������D203sԶ���⴫��������������
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration D203sC
{
	provides interface SensorData;
}
implementation
{
	components D203sP;
	components new AdcC() as D203s;

	SensorData = D203sP;
	D203sP.D203sControl -> D203s;
    D203sP.D203sRead -> D203s;
}

