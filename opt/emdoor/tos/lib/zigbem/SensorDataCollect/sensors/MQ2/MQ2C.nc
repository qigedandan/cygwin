//=============================================================================
//	Document:		MQ2C.nc
//	Description:	����Դ�ļ�����������MQ2��ȼ���崫��������������
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

