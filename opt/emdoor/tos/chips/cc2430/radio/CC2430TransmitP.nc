#include <IEEE802154.h>
#include <hplcc2420.h>


module CC2430TransmitP
{
  provides interface Send;
  provides interface Receive;
  provides interface SplitControl;

  provides command am_addr_t amAddress();

  uses interface HALCC2420;
  uses interface StdControl as HALCC2420Control;

  uses interface Timer<TMilli> as AckTimer;
  uses interface Timer<TMilli> as BackoffTimer;

  uses interface Random;

}
implementation
{
  #ifdef EM_RADIO_ACK_TIME
    #define ACK_TIMEOUT   EM_RADIO_ACK_TIME
  #else
    #define ACK_TIMEOUT   500
  #endif

  enum
  {
      S_STOPPED,
      S_STARTED,
      S_SENDING,
      S_BACKOFF,
      S_SENT,
      S_ACKED,
  };

  uint8_t m_state = S_STOPPED;

  #define BACKOFF_INIT      0x1f
  #define BACKOFF_RETRY     0x7

  uint8_t m_backoff_timer = BACKOFF_INIT;
  message_t *m_send_msg;
  uint8_t m_send_dsn = 0;
  error_t m_send_error;

  bool m_send_timeout = FALSE;

  #define getHeader(msg) ((cc2420_header_t*)msg->header)
  #define getMetadata(msg) ((cc2420_metadata_t*)msg->metadata)
  
  task void sendDoneTask();
  /***********************************************************************/
    void startBackoff()
    {
        uint16_t time = ( call Random.rand16() & m_backoff_timer ) + 1;

        m_state = S_BACKOFF;

        ADBG(1, "\r\nstartBackoff Timer=%d", ADBG_N(time));
        
        call BackoffTimer.startOneShot(time * CC2420_BACKOFF_PERIOD);
    }

    error_t doSend()
    {
        cc2420_header_t *header = getHeader(m_send_msg);
        
        ADBG(1,"\r\ndo sent");
        
        m_state = S_SENT;
        m_send_error = call HALCC2420.sendPacket((uint8_t*)header);

        if (m_send_error != SUCCESS)
        {
            post sendDoneTask();
            
            return FAIL;
        }

        if (header->fcf & (1<<IEEE154_FCF_ACK_REQ))
        {	//need ack
            call AckTimer.startOneShot(ACK_TIMEOUT);
        }
    }

    event void BackoffTimer.fired()
    {
        call BackoffTimer.stop();
		
		if (m_state == S_BACKOFF)
		{        
			if ( (_CC2430_RFSTATUS & _BV(CC2430_RFSTATUS_CCA)) )
			{
				ADBG(1, "\r\n CCA");
				doSend();
			}
			else
			{//retry backoff
			
				ADBG(1, "\r\n retry backoff");
				
				m_backoff_timer = BACKOFF_RETRY;
				startBackoff();
			}
		}
    }
  
  /***********************************************************************/

  command am_addr_t amAddress()
  {
      return *(call HALCC2420.getAddress());
  }

  command error_t SplitControl.start()
  {
      m_state = S_STOPPED;
       
      call AckTimer.stop();
      call BackoffTimer.stop();
  
      call HALCC2420Control.start();
      #ifdef EM_RADIO_CHANNEL
      call HALCC2420.setChannel(EM_RADIO_CHANNEL);
      #else
      call HALCC2420.setChannel(11);
      #endif

      m_state = S_STARTED;
       
      signal SplitControl.startDone(SUCCESS);
	
      return SUCCESS;
  }

  command error_t SplitControl.stop()
  {
       call AckTimer.stop();
       call BackoffTimer.stop();
       call HALCC2420Control.stop();
       
	m_state = S_STOPPED;
	
	signal SplitControl.stopDone(SUCCESS);
	
	return SUCCESS;
  }

  default event void SplitControl.startDone(error_t result) { }
  default event void SplitControl.stopDone(error_t result) { }

  /* ******************************************************************/
  command error_t Send.send(message_t *msg, uint8_t len)
  {
    cc2420_header_t *header = getHeader(msg);
    cc2420_metadata_t *metadata = getMetadata(msg);
	
    atomic
    {
        ADBG(1, "\r\nm_state=%d##", ADBG_N(m_state));
        
        if (m_state != S_STARTED)
        {
            if (m_state >= S_STOPPED  &&  m_state <= S_ACKED)
            {
                return FAIL;
            }
            else
            {
                m_state = S_STARTED;
            }
        }

      m_state = S_SENDING;
      m_send_msg = msg;
      header->dsn = ++m_send_dsn;   /*tivacc修改此行为未注释状态*/
    }

    header->length = len;

    header->fcf = 0x0000;

    if (header->dest == AM_BROADCAST_ADDR)
    {
        metadata->ack = TRUE;
    }
    else
    {	//need ack
        header->fcf |= 1 << IEEE154_FCF_ACK_REQ;
        metadata->ack = FALSE;
    }
    
    header->fcf |= ( ( IEEE154_TYPE_DATA << IEEE154_FCF_FRAME_TYPE ) |
		     ( 1 << IEEE154_FCF_INTRAPAN ) |
		     ( IEEE154_ADDR_SHORT << IEEE154_FCF_DEST_ADDR_MODE ) |
		     ( IEEE154_ADDR_SHORT << IEEE154_FCF_SRC_ADDR_MODE ) );


    header->src = TOS_IEEE_SADDR;

    ADBG(3, "\r\nCC2430TransmitP send\r\n");
	ADBG(3, "length=0x%x, ", ADBG_N(header->length));
	ADBG(3, "fcf=%x, ", ADBG_N(header->fcf));

	ADBG(3, "dsn=%x, ", ADBG_N(header->dsn));

	ADBG(3, "src=%x, ", ADBG_N(header->src));

	ADBG(3, "dest=%x, ", ADBG_N(header->dest));
	
	ADBG(3, "destpan=%x, ", ADBG_N(header->destpan));

	ADBG(3, "type=0x%x, ", ADBG_N(header->type));

	ADBG(3, "group=%x", ADBG_N(header->group));

    m_backoff_timer = BACKOFF_INIT;
	
    startBackoff();

	return SUCCESS;
  }

  command void *Send.getPayload(message_t *msg)
  {
    return msg->data;
  }

  command uint8_t Send.maxPayloadLength()
  {
    return TOSH_DATA_LENGTH;
  }

  command error_t Send.cancel(message_t *msg)
  {
    return FAIL;
  }

  async event void HALCC2420.sendPacketDone(uint8_t *packet, error_t result)
  {
       uint16_t dest = u16(packet, 6);
       uint16_t fcf = u16(packet, 1); 
       atomic m_send_error = result;

       ADBG(1, " HALCC2420.sendPacketDone");

       if (m_send_error != SUCCESS)
       {	//send fail!
            ADBG(1, " error");
            call AckTimer.stop();
			post sendDoneTask();
       }
       else if ( !(fcf & (1<<IEEE154_FCF_ACK_REQ)))
       {
            ADBG(1, "sucess without ack!");
			post sendDoneTask();
       }
  }

  task void sendDoneTask()
  {
    error_t tmp;
    cc2420_metadata_t *send_metadata = getMetadata(m_send_msg);
       
	atomic tmp = m_send_error;

	atomic m_state = S_STARTED;

    if (tmp == SUCCESS &&  send_metadata->ack != TRUE)
	{	//NO ACK
		tmp = CC2420_ERROR_ACK_TIMEOUT;
	}

	signal Send.sendDone(m_send_msg, tmp);	
  }

  default event void Send.sendDone(message_t *msg, error_t result)  {}

  /* *******************************************************/
  message_t *m_receive_msg;
  message_t m_receive_msg_obj;

  event void AckTimer.fired()
  {
      ADBG(1, "\r\nAckTimer.fired");

	  if (m_state > S_STARTED  &&  m_state <= S_ACKED)
      {//when transmit, and timeout
      		atomic m_send_error = CC2420_ERROR_ACK_TIMEOUT;
      		post sendDoneTask();
      }
  }

  event uint8_t *HALCC2420.receivedPacket(uint8_t *packet)
  {
    uint8_t i, length;

    cc2420_header_t *header;
	cc2420_metadata_t *metadata;

	m_receive_msg = &m_receive_msg_obj;

	header = getHeader(m_receive_msg);
	metadata = getMetadata(m_receive_msg);

    header->length = u8(packet, 0);
	length = header->length;

	header->fcf = u16(packet, 1); 
    header->dsn = u8(packet, 3);
	
	header->destpan = u16(packet, 4);
	header->dest = u16(packet, 6);

       header->src = u16(packet, 8);
	header->type = u8(packet, 10);
	header->group = u8(packet, 11);


    for (i=12; i < length-1; i++)
	{
	  u8(m_receive_msg->data, (i-12)) = u8(packet, i);
	}
	
	/* 2009-2 XLQ */
	metadata->rssi = u8(packet, length-1);
	metadata->crc = u8(packet, length);
	
    //its ack message
	if (header->fcf == IEEE154_TYPE_ACK)
	{
		cc2420_header_t *send_headerdata = getHeader(m_send_msg);
		cc2420_metadata_t *send_metadata= getMetadata(m_send_msg);

		if ((send_headerdata->dest != AM_BROADCAST_ADDR) && (m_state == S_SENT) && header->dsn == send_headerdata->dsn)
		{
			ADBG(1, "\r\nreceive ACK");
			send_metadata->ack = TRUE;
			call AckTimer.stop();
			post sendDoneTask();
		}
	}
	else
	{
	    ADBG(1, "CC2430TransmitP receive\r\n");

		ADBG(1, "length=%x, ", ADBG_N(header->length));
		
           ADBG(1, "fcf=%x, ", ADBG_N(header->fcf));

	    ADBG(1, "dsn=%x, ", ADBG_N(header->dsn));

	    ADBG(1, "src=%x, ", ADBG_N(header->src));

	    ADBG(1, "dest=%x, ", ADBG_N(header->dest));
    
		ADBG(1, "type=%x, ", ADBG_N(header->type));

        ADBG(1, "group=%x", ADBG_N(header->group));

        //everything ok, strip the CC2420 MAC PROTOCOL DATA SIZE
        if (header->length > MAC_PROTOCOL_SIZE)
        {	//only valid data length allow
            header->length = header->length - MAC_PROTOCOL_SIZE;
            m_receive_msg = signal Receive.receive(m_receive_msg, m_receive_msg->data, header->length);
        }
    }

	return packet;
  }

  command void *Receive.getPayload(message_t *msg, uint8_t *len)
  {
    if (len != NULL)
	{
	  *len = call Receive.payloadLength(msg);
	}

    return msg->data;
  }

  command uint8_t Receive.payloadLength(message_t *msg)
  {
       cc2420_header_t *header = getHeader(msg);
	return header->length;
  }


  default event message_t *Receive.receive(message_t *msg, void *payload, uint8_t len)
  {
  }
}
