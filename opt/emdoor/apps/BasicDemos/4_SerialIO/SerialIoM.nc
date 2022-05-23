/*************************************************
*	FUNCTION NAME : SerialIoM.nc
*	FUNCTION DESCRIPTION : �����������ʾ�����򣬿ɴӴ��ڽ��պ���ʾ����
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#include <strings.h>

/** ����˺꣬����ʾUartStream.receive����������һ��ָ������������ */
//#define SERIALIO_RECEIVE

#define DBG_LEV	9

module SerialIoM
{
	uses interface Boot;
	uses interface Leds;
	uses interface CC2430UartControl;
	uses interface StdControl as UartStdControl;
	uses interface UartStream;
}
implementation
{
	uint8_t m_receive_len;
	uint8_t m_echo_buf;
	uint8_t m_receive_buf[10];
	uint8_t m_send_buf[100];
	
	/* ��ʾһ���˵���ʾ�û�  */
	void showMenu() 
	{
		strcpy(m_send_buf, "\r\n\r\nDemo of Serio I/O\r\n[1] Toggle BLUE LED\r\n[2] Toggle GREEN LED\r\n");
		
		/* ͨ��UartStream.send���Է����ֽ����� */
		call UartStream.send(m_send_buf, strlen(m_send_buf));
	}
	
	/**  �����¼�����������SerialIo.nc�Ѿ�������MainC.Boot�ӿ�
	*    ϵͳ���������ô˺���
	*/
	event void Boot.booted()
	{		
		call Leds.BlueLedOn();
		call Leds.YellowLedOn();
		call CC2430UartControl.setBaudRate(9600);
		call UartStdControl.start();
		
		
		#ifdef SERIALIO_RECEIVE
		/** ��ʾ������չ��ܣ�������ָ�����ȵ����ݲŻ����receiveDone */
			strcpy(m_send_buf, "DEMO of serial I/O, input  ");
			call UartStream.send(m_send_buf, strlen(m_send_buf));
			
			call UartStream.receive(m_receive_buf, sizeof(m_receive_buf));
		
		#else  /** ��ʾ���Դ����������ݵĹ��� */
			showMenu();
		#endif
		
	}
	
	async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	
	/** ���·��͸ղŽ��յ��ַ����л��� */
	task void showMenuTask()
	{
		showMenu();
	}
	task void lightLED()
	{
		if(m_echo_buf=='1')
		{
			call Leds.BlueLedToggle();  /* �л���ɫLED�� */
			ADBG(DBG_LEV, "You choose to toggle BLUE LED\r\n");
		}
		else if (m_echo_buf == '2')
		{
			call Leds.YellowLedToggle();/* �л���ɫLED�� */
			ADBG(DBG_LEV, "You choose to toggle GREEN LED\r\n");
		}
		else
		{
			ADBG(DBG_LEV, "Error Key %c\r\n", m_echo_buf);
			post showMenuTask();
		}
	}
	
	/** ���û�е���receive���գ���ÿ���յ�һ�����ݾͻᴥ�����¼� */
	async event void UartStream.receivedByte(uint8_t byte)
	{
		m_echo_buf = byte;
		post lightLED();
	}
	
	/** �ڽ�����receive���������յĳ��Ⱥ����ô��¼� */
	async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error)
	{
		/** ���Խ��յ���10���ַ� */
		call UartStream.send(m_receive_buf, sizeof(m_receive_buf));
		
		/** ���½���10���ַ� */
		call UartStream.receive(m_receive_buf, sizeof(m_receive_buf));
	}
}

