/*************************************************
*	FUNCTION NAME : SerialDebug.nc
*	FUNCTION DESCRIPTION : ���ڵ�����Ϣ��ӡ
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration SerialDebug
{
}
implementation
{
	components SerialDebugM;  /* SerialDebugģ���������ʵ�־������ */
	components MainC;  		  /* TinyOS2��ģ�飬�������ڹ���ϵͳ���� */

	/* SerialDebugģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	*  ����ϵͳ����ʱ�����SerialDebugM��Boot�ӿ�
	*/
	SerialDebugM.Boot -> MainC.Boot;	
}

