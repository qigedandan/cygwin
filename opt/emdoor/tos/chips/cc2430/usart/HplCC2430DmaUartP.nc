#include "cc2430dma.h"

module HplCC2430DmaUartP
{
  provides interface StdControl as UartStdControl;
  provides interface UartStream;
  
  uses interface SerialByteComm as uart0;
  uses interface StdControl as uart0StdControl;
  uses interface CC2430Dma;
}
implementation
{
  norace uint8_t *m_rx_buf, *m_tx_buf;
  norace uint16_t m_rx_len, m_tx_len;
  norace uint16_t m_rx_pos, m_tx_pos;

  dma_config_t *pDmaCfg;

  command error_t UartStdControl.start()
  {
    	m_rx_buf = NULL;
	m_tx_buf = NULL;
	
	m_rx_len = 0;
	m_tx_len = 0;
	
	m_rx_pos = 0;
	m_tx_pos = 0;	

	pDmaCfg = call CC2430Dma.getConfig();

	pDmaCfg->VLEN       = VLEN_USE_LEN;      	 // Using the length field
       pDmaCfg->PRIORITY   = PRI_HIGH;          	 // Transfer Priority
       pDmaCfg->M8         = M8_USE_8_BITS;	    	 // Transferring all 8 bits in each byte.
       pDmaCfg->IRQMASK    = TRUE;			 // The DMA complete interrupt flag is set at completion.
       pDmaCfg->DESTINC    = DESTINC_0;         // The destination address is constant
       pDmaCfg->SRCINC     = SRCINC_1;          // The address for data fetch is inremented by 1 byte
										       // after each transfer.
       pDmaCfg->TRIG       = DMATRIG_UTX0;      // DMA is started by writing the DMAREQ register.
       pDmaCfg->TMODE      = TMODE_SINGLE;      // The whole block is transferred.
       pDmaCfg->WORDSIZE   = WORDSIZE_BYTE;     // One byte is transferred each time.

	SET_DMA_DEST(pDmaCfg,&(_CC2430_X_U0BUF));
	
	return call uart0StdControl.start();
  }
  
  command error_t UartStdControl.stop()
  {
    return call uart0StdControl.stop();
  }


  async command error_t UartStream.enableReceiveInterrupt()
  {
    return SUCCESS;
  }

  async command error_t UartStream.disableReceiveInterrupt()
  {
    return SUCCESS;
  }

  async command error_t UartStream.receive(uint8_t *buf, uint16_t len)
  {
    /*if (len == 0)
    {
      return FAIL;
    }

    atomic
    {
      if (m_rx_buf)
      {
        return EBUSY;
      }*/
   atomic
   {
      m_rx_buf = buf;
      m_rx_len = len;
      m_rx_pos = 0;
    }

    return SUCCESS;
  }

  async event void uart0.get(uint8_t data)
  {
    if (m_rx_buf)
    {      
      m_rx_buf[ m_rx_pos++ ] = data;
      if (m_rx_pos >= m_rx_len)
      {
        uint8_t *buf = m_rx_buf;
        m_rx_buf = NULL;
        signal UartStream.receiveDone(buf, m_rx_len, SUCCESS);
      }
    }
    else
    {
      signal UartStream.receivedByte(data);
    }
  }

  async command error_t UartStream.send(uint8_t *buf, uint16_t len)
  {
   uint8_t i=0;
    if (len == 0)
    {
      return FAIL;
    }
    if (m_tx_buf)
    {
      return EBUSY;
    }

    m_tx_buf = buf;
    m_tx_len = len;

    SET_DMA_SOURCE(pDmaCfg,buf);
    SET_DMA_LENGTH(pDmaCfg,len);

 
    call CC2430Dma.armChannel();
    call CC2430Dma.startTransfer();

    return SUCCESS;
  }

  async event void CC2430Dma.transferDone()
  {
	uint8_t *buf = m_tx_buf;
	m_tx_buf = NULL;
	signal UartStream.sendDone(buf, m_tx_len, SUCCESS);	
}
  async event void uart0.putDone(){}
  
  default async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error){}
  default async event void UartStream.receivedByte(uint8_t byte) {}
  default async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error){}
}
