
/**
 *  Wsn Base Station Module
 */

#include "message.h"

/* ������Լ��𣬲μ�Makefile��ADBG_LEVEL���壬���ô��ڵ���ADBG_LEVEL */
#define DBG_LEV	9

module EMSnifferM
{
    uses interface Boot;
	
	uses interface HALCC2420;
	uses interface StdControl as HALCC2420Control;
	
	/* ������ؽӿ� */
	uses interface StdControl as UartStdControl;
	uses interface UartStream;
	
	/* Ƶ��ɨ�賬ʱ��ʱ�� */
	uses interface Timer<TMilli> as ChannelTimer;
}
implementation
{
	/* �������� */
    message_t m_msg;
	
	
	enum 
	{
		SCAN_CHANNEL_MIN = 11,
		SCAN_CHANNEL_MAX = 26,
		SCAN_CHANNEL_DEFAULT = SCAN_CHANNEL_MIN,
		SCAN_CHANNEL_TIMEOUT = 3000,  /* ÿƵ��ɨ�賬ʱ3S */
	};
	uint8_t m_channel = SCAN_CHANNEL_DEFAULT;
	bool m_auto_channel = FALSE;  /* �Ƿ������Զ�ɨ��Ƶ�� */
   
    task void showMenu();
   
    
	
	/* ��ʾ���� */
	task void showMenu()
	{
		ADBG(DBG_LEV, "\r\n----------���˵�----------\r\n");
		ADBG(DBG_LEV, "  [a] �Զ�ɨ��Ƶ��\r\n");
		ADBG(DBG_LEV, "  [u] ��һ��Ƶ��\r\n");
		ADBG(DBG_LEV, "  [j] ��һ��Ƶ��\r\n");
		ADBG(DBG_LEV, "-----------------------------\r\n");
	}
		
   
    /* Ƶ������ */

	void showChannel(uint8_t channel)
	{ /* ��ʾ��ǰƵ�� */
		ADBG(DBG_LEV, "��ǰƵ����%d\r\n", ADBG_N(channel));
		if (channel == SCAN_CHANNEL_MIN)
		{
			ADBG(DBG_LEV, "�Ѵﵽ��СƵ��!\r\n");
		}
		else if (channel == SCAN_CHANNEL_MAX)
		{
			ADBG(DBG_LEV, "�Ѵﵽ���Ƶ��!\r\n");
		}
	}
	
	int gotoChannel(uint8_t channel)
	{ /* ���ó�ĳ��Ƶ�� */
		if (channel < SCAN_CHANNEL_MIN || channel > SCAN_CHANNEL_MAX)
		{
			return -1;
		}
		
		if (m_channel == channel)
		{ /* ����Ҫ�ı� */
			return -2;
		}
		
		m_channel = channel;
		
		call HALCC2420.setChannel(m_channel);
		
		return 0;
	}
	
	void stepChannel(uint8_t channel, int step)
	{ /* ��Ƶ */
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
		ADBG(DBG_LEV, "�Զ�ɨ��...");
		
		showChannel(m_channel);
		
		/* ��ʼ�ȴ����Ƶ������ */
		call ChannelTimer.startOneShot(SCAN_CHANNEL_TIMEOUT);
	}
	
	task void autoChannelNext()
	{ /* �Զ�������һ��Ƶ�� */
		if (m_channel == SCAN_CHANNEL_MAX)
		{ /* �ﵽ���Ƶ����������СƵ�����¿�ʼ */
			gotoChannel(SCAN_CHANNEL_MIN);
		}
		else
		{ /* ��һ��Ƶ�� */
			stepChannel(m_channel, 1);
		}
		
		post autoChannel();
	}
	
	task void incChannel()
	{ /* ��һ��Ƶ�� */
		m_auto_channel = FALSE;
		
		stepChannel(m_channel, 1);
		
		showChannel(m_channel);
	}
	
	task void decChannel()
	{ /* ��һ��Ƶ�� */
		m_auto_channel = FALSE;
		
		stepChannel(m_channel, -1);
		
		showChannel(m_channel);
	}
	
	event void ChannelTimer.fired()
	{  /* Ƶ��ɨ�賬ʱ */
		if (m_auto_channel)
		{ /* ����Ҫ�������� */
			post autoChannelNext();
		}
	}
	
	
	
	/* ���ݿ��� */
   
    void reportPacket()
    { /* ��ʾ�������� */
		uint8_t i=0;
		cc2420_header_t *header;
		cc2420_metadata_t *metadata;
		uint8_t *packet = (uint8_t *)&m_msg;
		
	
		header = (cc2420_header_t *) &m_msg.header;
		metadata = (cc2420_metadata_t *) &m_msg.metadata;
		
		metadata->rssi = u8(packet, header->length-1);
		metadata->crc = u8(packet, header->length);
		
		ADBG(DBG_LEV, "\r\n------------------------����---------------------\r\n");
		ADBG(DBG_LEV, "���س��ȣ�%d,     ˳��ţ�0x%02x,      FCF : 0x%04x\r\n", (int)header->length, (int)header->dsn, (int)header->fcf);
		ADBG(DBG_LEV, "Դ    ID��0x%04x, Ŀ��ID��0x%04x,  ����ţ�0x%04x\r\n", (int)header->src, (int)header->dest, (int)header->destpan);
		ADBG(DBG_LEV, "Ƶ    ����%d,     RSSI: %d,      CRC��   %s \r\n", (int)m_channel, (metadata->rssi & 0x80 ? -(int)(0xFF - metadata->rssi) : metadata->rssi), ((metadata->crc & 0x80) ? "OK" : "FAIL"));
		ADBG(DBG_LEV, "�������ݣ�");
		
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
	{ /* �Զ�ɨ��������յ����ݣ�˵��ɨ��ɹ� */
		ADBG(DBG_LEV, "�Զ�ɨ��Ƶ�����!\r\n");
		m_auto_channel = FALSE;
	}
		
	/* ��������׼������ */
        memcpy(&m_msg, packet, 128);
        reportPacket();
		
        return packet;
    }
	
	async event void HALCC2420.sendPacketDone(uint8_t *packet, error_t result)
	{
	}
	
	
	/* ������� */
	
	/** �Ӵ�����ÿ���յ�һ�����ݾͻᴥ�����¼� */
	async event void UartStream.receivedByte(uint8_t c)
	{
        switch (c)
		{
			case ' ':  /* �ո����ʾ�˵� */
				post showMenu();
				break;
				
			case 'u':  /* ��һ��Ƶ�� */
			case 'U':
				post incChannel();
				break;
				
			case 'j': /* ��һ��Ƶ�� */
			case 'J':
				post decChannel();
				break;
				
			case 'a':
				m_auto_channel = TRUE;
				post autoChannel();
				break;
		}
	}
	
	/** ���붨��UartStream�������¼����� */
	async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error)
	{
	}
	
	event void Boot.booted()
    {
        ADBG(DBG_LEV, "\r\n�������������.\r\n");
        
		post showMenu();
		
		/*  ������ͨѶ */
		call UartStdControl.start();
		
		/* ������Ƶ */
		call HALCC2420Control.start();	
    }
	
	
	
}

