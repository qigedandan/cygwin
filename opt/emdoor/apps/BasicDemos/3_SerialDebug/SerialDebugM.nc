/*************************************************
*	FUNCTION NAME : SerialDebugM.nc
*	FUNCTION DESCRIPTION : ���ڵ�����Ϣ��ӡ
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/* ������Լ��𣬲μ�Makefile��ADBG_LEVEL���壬���ô��ڵ���ADBG_LEVEL */
#define DBG_LEV	9

module SerialDebugM
{
	uses interface Boot;
}
implementation
{
	/** ����:  ͨ�����ڴ�ӡ��Ϣ������ */
	task void DebugSerial()
	{
		uint8_t num1 = 0x39;		
		uint32_t num2 = 0x12345678;
		float float1 = 123.1234;
		
		/** ADBG����ʽ������printf,
		*	��һ������Ϊ���Եȼ������Բμ�tos/lib/common/antdebug.h 
		*/
		
		/** ��ӡ�ַ����ַ��� */
		ADBG(DBG_LEV, "\r\n\r\nDEMO of Serial Debug\r\n", 'x');
		ADBG(DBG_LEV, "1. Hello,Welcome to WSN!\r\n", 'x');
		
		/** ��ӡ8λ������ */
		ADBG(DBG_LEV, "2. NUM1: HEX=0x%x, DEC=%d\r\n", (int)(num1), (int)(num1));
		
		/** ��ӡ32λ���� */
		ADBG(DBG_LEV, "2. NUM2: HEX=0x%lx, DEC=%ld\r\n", (uint32_t)(num2), (uint32_t)(num2));
		
		/** ��ӡ������*/
		ADBG(DBG_LEV, "3. FLOAT: %f\r\n", float1);
	}

	/**  �����¼�����������SerialDebug.nc�Ѿ�������MainC.Boot�ӿ�
	*	 ϵͳ���������ô˺���
	*/
	event void Boot.booted()
	{
		post DebugSerial();
	}
}

