/*************************************************
*	FUNCTION NAME : SerialIoM.nc
*	FUNCTION DESCRIPTION : 串口输入输出示例程序，可从串口接收和显示数据
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#include <strings.h>

/** 定义此宏，将演示UartStream.receive函数，允许一次指定数量的数据 */
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
	
	/* 显示一个菜单提示用户  */
	void showMenu() 
	{
		strcpy(m_send_buf, "\r\n\r\nDemo of Serio I/O\r\n[1] Toggle BLUE LED\r\n[2] Toggle GREEN LED\r\n");
		
		/* 通过UartStream.send可以发送字节数据 */
		call UartStream.send(m_send_buf, strlen(m_send_buf));
	}
	
	/**  启动事件处理函数，在SerialIo.nc已经关联到MainC.Boot接口
	*    系统启动后会调用此函数
	*/
	event void Boot.booted()
	{		
		call Leds.BlueLedOn();
		call Leds.YellowLedOn();
		call CC2430UartControl.setBaudRate(9600);
		call UartStdControl.start();
		
		
		#ifdef SERIALIO_RECEIVE
		/** 演示缓冲接收功能，接收完指定长度的数据才会调用receiveDone */
			strcpy(m_send_buf, "DEMO of serial I/O, input  ");
			call UartStream.send(m_send_buf, strlen(m_send_buf));
			
			call UartStream.receive(m_receive_buf, sizeof(m_receive_buf));
		
		#else  /** 演示回显串口输入数据的功能 */
			showMenu();
		#endif
		
	}
	
	async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	
	/** 重新发送刚才接收的字符进行回显 */
	task void showMenuTask()
	{
		showMenu();
	}
	task void lightLED()
	{
		if(m_echo_buf=='1')
		{
			call Leds.BlueLedToggle();  /* 切换蓝色LED灯 */
			ADBG(DBG_LEV, "You choose to toggle BLUE LED\r\n");
		}
		else if (m_echo_buf == '2')
		{
			call Leds.YellowLedToggle();/* 切换黄色LED灯 */
			ADBG(DBG_LEV, "You choose to toggle GREEN LED\r\n");
		}
		else
		{
			ADBG(DBG_LEV, "Error Key %c\r\n", m_echo_buf);
			post showMenuTask();
		}
	}
	
	/** 如果没有调用receive接收，则每接收到一个数据就会触发此事件 */
	async event void UartStream.receivedByte(uint8_t byte)
	{
		m_echo_buf = byte;
		post lightLED();
	}
	
	/** 在接收完receive命令欲接收的长度后会调用此事件 */
	async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error)
	{
		/** 回显接收到的10个字符 */
		call UartStream.send(m_receive_buf, sizeof(m_receive_buf));
		
		/** 重新接收10个字符 */
		call UartStream.receive(m_receive_buf, sizeof(m_receive_buf));
	}
}

