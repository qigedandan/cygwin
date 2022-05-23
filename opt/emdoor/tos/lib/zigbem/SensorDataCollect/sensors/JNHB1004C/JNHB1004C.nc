//=============================================================================
//	Document:		JNHB1004C.nc
//	Description:	����Դ�ļ�����������JNHB1004���洫��������������
//	Date:			2011/04/17
//	Author:			Paul.Jia
//	Copyright:		Emdoor
//=============================================================================

configuration JNHB1004C
{
	provides interface SensorData;
}
implementation
{
	components JNHB1004P;
	components new AdcC() as JNHB1004;

	SensorData = JNHB1004P;
	JNHB1004P.JNHB1004Control -> JNHB1004;
    JNHB1004P.JNHB1004Read -> JNHB1004;
}

