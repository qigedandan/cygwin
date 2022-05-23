/*************************************************
*	FUNCTION NAME : SerialIo.nc
*	FUNCTION DESCRIPTION : �����������ʾ�����򣬿ɴӴ��ڽ��պ���ʾ����
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

configuration SerialIo
{
}
implementation
{
	components SerialIoM;  /* SerialIoģ���������ʵ�־������ */
	components MainC;  	   /* TinyOS��ģ�飬�������ڹ���ϵͳ���� */
	components LedsC;	   /* Ledģ������ṩ��LED�Ŀ���*/

	/** SerialIoģ������Boot�ӿ���ϵͳBoot�ӿڹ���
	    ����ϵͳ����ʱ�����SerialIoM��Boot�ӿ�
	*/
	SerialIoM.Boot -> MainC.Boot;
	
	/**����ģ�������Ledģ�����
	*
	*/
	
	SerialIoM.Leds -> LedsC;
	
	/** PlatformSerialC
	*/
	components PlatformSerialC;
	SerialIoM.CC2430UartControl -> PlatformSerialC.CC2430UartControl;
	SerialIoM.UartStdControl -> PlatformSerialC.UartStdControl;
	SerialIoM.UartStream -> PlatformSerialC.UartStream;
}
