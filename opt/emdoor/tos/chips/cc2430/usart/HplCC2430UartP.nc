module HplCC2430UartP
{
  provides interface StdControl as UartStdControl;
  provides interface UartStream;
  
  uses interface SerialByteComm as uart0;
  uses interface StdControl as uart0StdControl;
}
implementation
{
  norace uint8_t *m_rx_buf, *m_tx_buf;
  norace uint16_t m_rx_len, m_tx_len;
  norace uint16_t m_rx_pos, m_tx_pos;


  command error_t UartStdControl.start()
  {
    m_rx_buf = NULL;
	m_tx_buf = NULL;
	
	m_rx_len = 0;
	m_tx_len = 0;
	
	m_rx_pos = 0;
	m_tx_pos = 0;
	
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
    if (len == 0)
    {
      return FAIL;
    }

    atomic
    {
      if (m_rx_buf)
      {
        return EBUSY;
      }

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
    m_tx_pos = 0;
    call uart0.put(m_tx_buf[ m_tx_pos++ ]);
    return SUCCESS;
  }

  async event void uart0.putDone()
  {
    if (m_tx_pos < m_tx_len)
    {
      call uart0.put(m_tx_buf[m_tx_pos++]);
    }
    else
    {
      uint8_t *buf = m_tx_buf;
      m_tx_buf = NULL;
      signal UartStream.sendDone(buf, m_tx_len, SUCCESS);
    }
  }

  default async event void UartStream.sendDone(uint8_t *buf, uint16_t len, error_t error){}
  default async event void UartStream.receivedByte(uint8_t byte) {}
  default async event void UartStream.receiveDone(uint8_t *buf, uint16_t len, error_t error){}
}
