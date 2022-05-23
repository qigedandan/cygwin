#include "OSARF.h"

module OSARFTransmitP
{
	provides interface StdControl;
	provides interface Send;

	uses interface OSARF;
	uses interface Receive as ReceiveAll;  /* Receive any message received include ACK message */

	uses interface Alarm<T32khz,uint32_t> as BackoffTimer;
	
	uses interface ActiveMessageAddress;
	uses interface Random;
}
implementation
{	
	enum
	{
		S_STOPPED,
		S_STARTED,
		S_SAMPLE_CCA,
		S_BEGIN_TRANSMIT,
		S_ACK_WAIT,
	};
	uint8_t m_state = S_STOPPED;
	message_t *m_msg;
	uint8_t m_dsn;

	/*================================*/
	error_t send();
	void congestionBackoff();
	void attemptSend();
	void signalDone( error_t err );

	
	uint16_t defaultInitialBackoff();  
	uint16_t defaultCongestionBackoff();

	/*================================*/
	
	command error_t StdControl.start()
	{
		m_state = S_STARTED;

		m_dsn = call ActiveMessageAddress.amAddress() & 0xFF;  /* not a good idea, just to fix some strange error when transfer, MUST FIXME!! */
		ADBG(4, "OSARFTransmitP.StdControl.start\n");
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{
		m_state = S_STOPPED;
		
		return SUCCESS;
	}
	/*================================*/

	command error_t Send.cancel(message_t* msg)
	{/* Not support now */
		return FAIL;
	}
  
	command uint8_t Send.maxPayloadLength()
	{
		return TOSH_DATA_LENGTH;
	}

	command void* Send.getPayload(message_t* msg)
	{
		return msg->data;
	}
	
	command error_t Send.send(message_t* p_msg, uint8_t payload_len)
	{
	    OSARF_HEADER_T* header = OSARF_HEADER_PTR( p_msg );
	    OSARF_METADATA_T* metadata = OSARF_METADATA_PTR( p_msg );
	    
		ADBG(4, "OSARFTransmitP.Send.send\n");
		
	    atomic {
	    	m_msg = p_msg;
	    }

	    /* calculate the length */
	    header->length = payload_len + MAC_HEADER_SIZE + MAC_FOOTER_SIZE;

	    /* set the FCF */
	    if (header->dest == AM_BROADCAST_ADDR)
	    {
		    header->fcf = 0;
	    }
	    else
	    {
		   header->fcf = 1 << IEEE154_FCF_ACK_REQ;
	    }
	    header->fcf |= ( ( IEEE154_TYPE_DATA << IEEE154_FCF_FRAME_TYPE ) |
			     ( 1 << IEEE154_FCF_INTRAPAN ) |
			     ( IEEE154_ADDR_SHORT << IEEE154_FCF_DEST_ADDR_MODE ) |
			     ( IEEE154_ADDR_SHORT << IEEE154_FCF_SRC_ADDR_MODE ) );

	   if (header->destpan == 0x0000)
	   {/* NULL PAN, set automaticly */
	   	header->destpan = call ActiveMessageAddress.amGroup(); /* FIXME: because now the amGroup() return uint8_t, but destpan is uint16_t  */
	   }

	   header->dsn = m_dsn++;
	    
	    header->src =call ActiveMessageAddress.amAddress();
	    metadata->ack = FALSE;
	    metadata->rssi = 0;
	    metadata->lqi = 0;
	    metadata->time = 0;

	    /* check whether to wait ACK */
	    return send();
	}

	
	
	async event void BackoffTimer.fired()
	{
		ADBG(5, "BackoffTimer.fired m_state=%d\n", (int)m_state);
		atomic {
		switch( m_state )
		{
        	      case S_SAMPLE_CCA :
		        // sample CCA and wait a little longer if free, just in case we
		        // sampled during the ack turn-around window
				//ADBG(10, "_CC2430_RFSTATUS = 0x%x\n", (int)_CC2430_RFSTATUS);
				
				if ( call OSARF.getCCA() ) {
					m_state = S_BEGIN_TRANSMIT;
					call BackoffTimer.start( CC2420_TIME_ACK_TURNAROUND );   
				} else {
					congestionBackoff();
				}
				break;
                
			case S_BEGIN_TRANSMIT:
				attemptSend();
				break;
        
			case S_ACK_WAIT:
				signalDone( FAIL );  /* It should be an error?? XLQ */
				break;

			default:
				break;
		}}
	}

	async event void OSARF.sendPacketDone(uint8_t * packet, error_t result)
	{
		message_t *p_msg = (message_t *)packet;
		OSARF_HEADER_T* header = OSARF_HEADER_PTR( p_msg );
		OSARF_METADATA_T* metadata = OSARF_METADATA_PTR( p_msg );

		if (m_state == S_ACK_WAIT  && !(header->fcf & (1<<IEEE154_FCF_ACK_REQ)) && (packet == (uint8_t *)m_msg))
		{
			signalDone(result);
		}
	}
	
	event uint8_t * OSARF.receivedPacket(uint8_t * packet)
	{
	}

	event message_t* ReceiveAll.receive(message_t* msg, void* payload, uint8_t len)
	{
		ADBG(4, "ReceiveAll.receive \n");
		if (m_state == S_ACK_WAIT)
		{
			OSARF_HEADER_T* header = OSARF_HEADER_PTR( m_msg );
			OSARF_METADATA_T* metadata = OSARF_METADATA_PTR( m_msg );
		
			OSARF_HEADER_T* receive_header = OSARF_HEADER_PTR( msg );

		#ifndef OSARF_ACK_MANUAL
			if (((( receive_header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7) ==  IEEE154_TYPE_ACK)
			&&  (header->fcf & (1<<IEEE154_FCF_ACK_REQ))
			&&  (header->dsn == receive_header->dsn))
			{
				uint8_t* ack_buf = (uint8_t *)receive_header;
				
				call BackoffTimer.stop();
				metadata->ack = TRUE;
			       metadata->rssi = ack_buf[ receive_header->length - 1 ];
			       metadata->lqi = ack_buf[ receive_header->length ] & 0x7f;
				
				ADBG(4, "ReceiveAll.receive ACK\n");
				signalDone(SUCCESS);
				
				return NULL;
			}
		#else
			if (((( receive_header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7) ==  IEEE154_TYPE_DATA)
			&&  (header->fcf & (1<<IEEE154_FCF_ACK_REQ))
			&&  (header->dsn == receive_header->dsn)
			&&  (header->src == receive_header->dest)
			&&  (receive_header->type == OSARF_ACK_MANUAL_TYPE)
			)
			{
				uint8_t* ack_buf = (uint8_t *)receive_header;
				
				call BackoffTimer.stop();
				metadata->ack = TRUE;
			       metadata->rssi = ack_buf[ receive_header->length - 1 ];
			       metadata->lqi = ack_buf[ receive_header->length ] & 0x7f;
				
				ADBG(4, "ReceiveAll.receive ACK\n");
				signalDone(SUCCESS);

				return NULL;
			}
		#endif
		}

		return msg;
	}

	async event void ActiveMessageAddress.changed()
	{
	}
	/*================================*/
	

	error_t send()
	{
		if ( m_state != S_STARTED )
		{
			return FAIL;
		}

		m_state = S_SAMPLE_CCA;
		call BackoffTimer.start( defaultInitialBackoff() );

		return SUCCESS;
	}

	/**  
	* Congestion Backoff
	*/
	void congestionBackoff()
	{
		call BackoffTimer.start( defaultCongestionBackoff() );
  	}
	
	void attemptSend()
	{
		if (!call OSARF.getCCA())
		{
			congestionBackoff();
		}
		else
		{
			OSARF_HEADER_T* header = OSARF_HEADER_PTR( m_msg );
			
			m_state = S_ACK_WAIT;
			
			if (call OSARF.sendPacket((uint8_t *)m_msg) != SUCCESS)
			{
				signalDone(FAIL);
			}
			else
			{
				call BackoffTimer.start(CC2420_ACK_WAIT_DELAY*20);
			}
		}
	}


	void signalDone( error_t err )
	{    
		atomic m_state = S_STARTED;

		signal Send.sendDone( m_msg, err );
	}

	uint16_t defaultInitialBackoff()
	{
  		return (call Random.rand16() 
	        % (0x1F * CC2420_BACKOFF_PERIOD) + CC2420_MIN_BACKOFF);
	}
  
	uint16_t defaultCongestionBackoff()
	{
		return ( call Random.rand16() % (0x7 * CC2420_BACKOFF_PERIOD) + CC2420_MIN_BACKOFF);
	}

}



