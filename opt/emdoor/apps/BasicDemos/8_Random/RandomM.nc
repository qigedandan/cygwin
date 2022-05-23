/*************************************************
*	FUNCTION NAME : RandomM.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

/* ������Լ��𣬲μ�Makefile��ADBG_LEVEL���壬���ô��ڵ���ADBG_LEVEL */
#define DBG_LEV	9
#define RANDOM_TEXT_LEN 80

module RandomM
{
	uses interface Boot;
	uses interface Init as RandomInit;
	uses interface Random;
	uses interface StdControl as UartStdControl;
	uses interface UartStream;
}
implementation
{	
	task void GenerateRandomText();
	task void GenerateRandomNum();
	task void showMenu();

	event void Boot.booted()
	{
		ADBG(DBG_LEV, "\r\n##################################\r\n");
        ADBG(DBG_LEV, " [RandomM] \r\n");
        ADBG(DBG_LEV, "##################################\r\n");
		call RandomInit.init();
		call UartStdControl.start();
		post showMenu();
	}

	/** �Ӵ�����ÿ���յ�һ�����ݾͻᴥ�����¼� */
	async event void UartStream.receivedByte(uint8_t c)
	{
		if(c == 't' || c == 'T')
		{
			post GenerateRandomText();
		}
		if(c == 'n' || c == 'N')
		{
			post GenerateRandomNum();
		}

	}
	
	task void GenerateRandomText()
	{
		uint8_t i;
		uint8_t rand;
		uint8_t randChar;

		ADBG(DBG_LEV,"\r\nNow ! GeneratingRandomText....\r\n");

		for(i=0;i<RANDOM_TEXT_LEN;i++)
		{
			rand  = (uint8_t )call Random.rand16();
			randChar = 'a' + (rand % ('z' - 'a')) ;
			ADBG(DBG_LEV,"%c",randChar);
		}

		post showMenu();
	}

	task void GenerateRandomNum()
	{
		ADBG(DBG_LEV,"\r\nNow ! GeneratingRandomNum....\r\n");
		ADBG(DBG_LEV,"RandomNum = 0x%x",(int)call Random.rand16());

		post showMenu();

	}
	task void showMenu()
	{
		ADBG(DBG_LEV, " \r\n\r\n press 't' or 'T' to generate random text ");
		ADBG(DBG_LEV, " \r\n press 'n' or 'N' to generate random number \r\n");
	}
	
	/** ���붨��UartStream�������¼����� */
	async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
}


