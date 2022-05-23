//=============================================================================
//	Document:		OTP538uC.nc
//	Description:	����Դ�ļ�����������OTP538u�����ȵ�Ѵ���������������
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

