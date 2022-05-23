
/**
 *  Wsn Base Station Module
 */

#include "message.h"

/* 定义调试级别，参加Makefile的ADBG_LEVEL定义，设置大于等于ADBG_LEVEL */
#define DBG_LEV	9

module EMSnifferM
{
    uses interface Boot;
	
	uses interface HALCC2420;
	uses interface StdControl as HALCC2420Control;
	
	/* 串口相关接口 */
	uses interface StdControl as UartStdControl;
	uses interface UartStream;
	
	/* 频道扫描超时定时器 */
	uses interface Timer<TMilli> as ChannelTimer;
}
implementation
{
	/* 变量定义 */
    message_t m_msg;
	
	
	enum 
	{
		SCAN_CHANNEL_MIN = 11,
		SCAN_CHANNEL_MAX = 26,
		SCAN_CHANNEL_DEFAULT = SCAN_CHANNEL_MIN,
		SCAN_CHANNEL_TIMEOUT = 3000,  /* 每频道扫描超时3S */
	};
	uint8_t m_channel = SCAN_CHANNEL_DEFAULT;
	bool m_auto_channel = FALSE;  /* 是否正在自动扫描频道 */
   
    task void showMenu();
   
    
	
	/* 显示控制 */
	task void showMenu()
	{
		ADBG(DBG_LEV, "\r\n----------主菜单----------\r\n");
		ADBG(DBG_LEV, "  [a] 自动扫描频道\r\n");
		ADBG(DBG_LEV, "  [u] 下一个频道\r\n");
		ADBG(DBG_LEV, "  [j] 上一个频道\r\n");
		ADBG(DBG_LEV, "-----------------------------\r\n");
	}
		
   
    /* 频道控制 */

	void showChannel(uint8_t channel)
	{ /* 显示当前频道 */
		ADBG(DBG_LEV, "当前频道：%d\r\n", ADBG_N(channel));
		if (channel == SCAN_CHANNEL_MIN)
		{
			ADBG(DBG_LEV, "已达到最小频道!\r\n");
		}
		else if (channel == SCAN_CHANNEL_MAX)
		{
			ADBG(DBG_LEV, "已达到最大频道!\r\n");
		}
	}
	
	int gotoChannel(uint8_t channel)
	{ /* 设置成某个频道 */
		if (channel < SCAN_CHANNEL_MIN || channel > SCAN_CHANNEL_MAX)
		{
			return -1;
		}
		
		if (m_channel == channel)
		{ /* 不需要改变 */
			return -2;
		}
		
		m_channel = channel;
		
		call HALCC2420.setChannel(m_channel);
		
		return 0;
	}
	
	void stepChannel(uint8_t channel, int step)
	{ /* 变频 */
		channel += step;
		if (channel < SCAN_CHANNEL_MIN)
		{
			channel = SCAN_CHANNEL_MIN;
		}
		else if (channel > SCAN_CHANNEL_MAX)
		{
			channel = SCAN_CHANNEL_MAX;
		}
		
		gotoChannel(channel);
	}
	
	task void autoChannel()
	{
		ADBG(DBG_LEV, "自动扫描...");
		
		showChannel(m_channel);
		
		/* 开始等待这个频道内容 */
		call ChannelTimer.startOneShot(SCAN_CHANNEL_TIMEOUT);
	}
	
	task void autoChannelNext()
	{ /* 自动搜索下一个频道 */
		if (m_channel == SCAN_CHANNEL_MAX)
		{ /* 达到最大频道，跳到最小频道重新开始 */
			gotoChannel(SCAN_CHANNEL_MIN);
		}
		else
		{ /* 下一个频道 */
			stepChannel(m_channel, 1);
		}
		
		post autoChannel();
	}
	
	task void incChannel()
	{ /* 下一个频道 */
		m_auto_channel = FALSE;
		
		stepChannel(m_channel, 1);
		
		showChannel(m_channel);
	}
	
	task void decChannel()
	{ /* 上一个频道 */
		m_auto_channel = FALSE;
		
		stepChannel(m_channel, -1);
		
		showChannel(m_channel);
	}
	
	event void ChannelTimer.fired()
	{  /* 频道扫描超时 */
		if (m_auto_channel)
		{ /* 还需要往后搜索 */
			post autoChannelNext();
		}
	}
	
	
	
	/* 数据控制 */
   
    void reportPacket()
    { /* 显示包的内容 */
		uint8_t i=0;
		cc2420_header_t *header;
		cc2420_metadata_t *metadata;
		uint8_t *packet = (uint8_t *)&m_msg;
		
	
		header = (cc2420_header_t *) &m_msg.header;
		metadata = (cc2420_metadata_t *) &m_msg.metadata;
		
		metadata->rssi = u8(packet, header->length-1);
		metadata->crc = u8(packet, header->length);
		
		ADBG(DBG_LEV, "\r\n------------------------捕获---------------------\r\n");
		ADBG(DBG_LEV, "负载长度：%d,     顺序号：0x%02x,      FCF : 0x%04x\r\n", (int)header->length, (int)header->dsn, (int)header->fcf);
		ADBG(DBG_LEV, "源    ID：0x%04x, 目标ID：0x%04x,  网络号：0x%04x\r\n", (int)header->src, (int)header->dest, (int)header->destpan);
		ADBG(DBG_LEV, "频    道：%d,     RSSI: %d,      CRC：   %s \r\n", (int)m_channel, (metadata->rssi & 0x80 ? -(int)(0xFF - metadata->rssi) : metadata->rssi), ((metadata->crc & 0x80) ? "OK" : "FAIL"));
		ADBG(DBG_LEV, "负载内容：");
		
		for (i=0; i < header->length; ++i)
		{
			ADBG(DBG_LEV, "%02x ", (int)packet[i]);
		}
		
		ADBG(DBG_LEV, "\r\n");
		
		ADBG(DBG_LEV, "--------------------------------------------------\r\n");
    }


    event uint8_t * HALCC2420.receivedPacket(uint8_t * packet)
    {
	if (m_auto_channel)
	{ /* 自动扫描过程中收到数据，说明扫描成功 */
		ADBG(DBG_LEV, "自动扫描频道完成!\r\n");
		m_auto_channel = FALSE;
	}
		
	/* 保存数据准备发送 */
        memcpy(&m_msg, packet, 128);
        reportPacket();
		
        return packet;
    }
	
	async event void HALCC2420.sendPacketDone(uint8_t *packet, error_t result)
	{
	}
	
	
	/* 程序控制 */
	
	/** 从串口则每接收到一个数据就会触发此事件 */
	async event void UartStream.receivedByte(uint8_t c)
	{
        switch (c)
		{
			case ' ':  /* 空格键显示菜单 */
				post showMenu();
				break;
				
			case 'u':  /* 下一个频道 */
			case 'U':
				post incChannel();
				break;
				
			case 'j': /* 上一个频道 */
			case 'J':
				post decChannel();
				break;
				
			case 'a':
				m_auto_channel = TRUE;
				post autoChannel();
				break;
		}
	}
	
	/** 必须定义UartStream的其他事件处理 */
	async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	
	event void Boot.booted()
    {
        ADBG(DBG_LEV, "\r\n捕获程序已启动.\r\n");
        
		post showMenu();
		
		/*  允许串口通讯 */
		call UartStdControl.start();
		
		/* 开启射频 */
		call HALCC2420Control.start();	
    }
	
	
	
}

