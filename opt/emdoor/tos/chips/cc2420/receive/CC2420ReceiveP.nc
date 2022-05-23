/*
 * "Copyright (c) 2007-2008 Washington University in St. Louis.
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 *
 * IN NO EVENT SHALL WASHINGTON UNIVERSITY IN ST. LOUIS BE LIABLE TO ANY PARTY
 * FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
 * OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF WASHINGTON
 * UNIVERSITY IN ST. LOUIS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * WASHINGTON UNIVERSITY IN ST. LOUIS SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND WASHINGTON UNIVERSITY IN ST. LOUIS HAS NO
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
 * MODIFICATIONS."
 */
 
/*
 * Copyright (c) 2005-2006 Arch Rock Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Arch Rock Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * ARCHED ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */

/**
 * @author Jonathan Hui <jhui@archrock.com>
 * @author David Moss
 * @author Jung Il Choi
 * @author Greg Hackmann
 * @version $Revision: 1.2 $ $Date: 2007/07/06 18:09:44 $
 */

#include "CC2420.h"
#include "crc.h"
#include "message.h"
#include "packet.h"

module CC2420ReceiveP {

  provides interface Init;
  provides interface AsyncStdControl;
  provides interface CC2420Receive;
  provides interface AsyncReceive as Receive;
  provides interface ReceiveIndicator as PacketIndicator;

  uses interface GeneralIO as CSN;
  uses interface GeneralIO as FIFO;
  uses interface GeneralIO as FIFOP;
  uses interface GpioInterrupt as InterruptFIFOP;
  uses interface GpioInterrupt as InterruptRFErr;

  uses interface CC2420Strobe as SACK;
  uses interface CC2420Strobe as SFLUSHRX;
  uses interface CC2420PacketBody;
  uses interface CC2420Config;
  
  uses interface Leds;
}

implementation {

  typedef enum {
    S_STOPPED,
    S_STARTED,
    S_RX_LENGTH,
    S_RX_FCF,
    S_RX_PAYLOAD,
  } cc2420_receive_state_t;

  enum {
    RXFIFO_SIZE = 128,
    TIMESTAMP_QUEUE_SIZE = 8,
    SACK_HEADER_LENGTH = 5/*found on  CC2430 data sheet*/  /*7*/,
  };

  uint16_t m_timestamp_queue[ TIMESTAMP_QUEUE_SIZE ];
  
  uint8_t m_timestamp_head;
  
  uint8_t m_timestamp_size;
  
  /** Number of packets we missed because we were doing something else */
  uint8_t m_missed_packets;
  
  /** TRUE if we are receiving a valid packet into the stack */
  bool receivingPacket;
  
  /** The length of the frame we're currently receiving */
  norace uint8_t rxFrameLength;
  
  norace uint8_t m_bytes_left;
  
  norace message_t* m_p_rx_buf;

  message_t m_rx_buf;
  
  cc2420_receive_state_t m_state;

  uint16_t tmprfdhead=0;
  uint16_t tmprfdtail=0;
  uint16_t frameLength = 0;
  uint8_t receivedPacketTaskRetries = 0;
  bool flushBufferTaskPosted = FALSE;
  
  /***************** Prototypes ****************/
  void reset_state();
  
  void receiveDone();

  task void receivedPacketTask();
  task void flushBufferTask();



   /*=========================================*/
  /* Software RFD */
  #define RFD_SIZE  512
  uint16_t rfd_head = 0;
  uint16_t rfd_tail = 0;
  UINT8_PM0_T rfd_buffer[RFD_SIZE] = {0};
  
  void initRFD()
  {
  	atomic
  	{
	  	memset(rfd_buffer, 0, sizeof(rfd_buffer));
	}
  }
  
  uint8_t readRFD()
  {
	uint8_t byte = 0;
  	atomic
  	{
	  	if (rfd_head != rfd_tail)
	  	{
	  		byte =  rfd_buffer[rfd_head];
	  		rfd_head = (rfd_head + 1) % RFD_SIZE;
	  	}

	  	//ADBG(100, "read -> head=%d, tail=%d\n", rfd_head, rfd_tail);
  	}


  	tmprfdhead = rfd_head;
  	tmprfdtail = rfd_tail;
	  	
	return byte;
  }

  void writeRFD(uint8_t byte)
  {

  	atomic
  	{
  		if (((rfd_tail+1) % RFD_SIZE) == rfd_head)
  		{
  			/* overflow */
  			
  		}
  		
  		rfd_buffer[rfd_tail] = byte;
  		rfd_tail = (rfd_tail + 1) % RFD_SIZE;

  		//ADBG(100, "write -> head=%d, tail=%d\n", rfd_head, rfd_tail);
  	}

  	tmprfdhead = rfd_head;
  	tmprfdtail = rfd_tail;
  }

  uint16_t countRFD()
  {
  	atomic
  	{
	  	if (rfd_tail == rfd_head)
	  	{
		  	return 0;
	  	}
	  	else if (rfd_tail > rfd_head)
	  	{
	  		return rfd_tail - rfd_head;
	  	}
	  	else
	  	{
	  		return (RFD_SIZE - rfd_head + rfd_tail);
	  	}
  	}
  }

  #define BUFFER_RFD_ALL() atomic {	\
  		while (_CC2430_RXFIFOCNT > 0) \
    		{ \
    			writeRFD(RFD); \
    		} \
  } 
  
  
  
  /*=========================================*/
  
  /***************** Init Commands ****************/
  command error_t Init.init() {
    m_p_rx_buf = &m_rx_buf;

    
    return SUCCESS;
  }

  /***************** AsyncStdControl ****************/
  async command error_t AsyncStdControl.start() {
    ADBG(5, "CC2420ReceiveP.AsyncStdControl.start\n");
    atomic {
      reset_state();
      m_state = S_STARTED;
      atomic receivingPacket = FALSE;
      call InterruptFIFOP.enableRisingEdge();
    }
    return SUCCESS;
  }
  
  async command error_t AsyncStdControl.stop() {
    ADBG(5, "CC2420ReceiveP.AsyncStdControl.stop\n");
    atomic {
      m_state = S_STOPPED;
      reset_state();
      call CSN.set();
      call InterruptFIFOP.disable();
      
      initRFD();  //reset Software RFD, XLQ 2009      
    }
    return SUCCESS;
  }

  /***************** Receive Commands ****************/
  async command void* Receive.getPayload(message_t* m, uint8_t* len) {
    if (len != NULL) {
      *len = ((uint8_t*) (call CC2420PacketBody.getHeader( m_p_rx_buf )))[0];
    }
    return m->data;
  }

  async command uint8_t Receive.payloadLength(message_t* m) {
    uint8_t* buf = (uint8_t*)(call CC2420PacketBody.getHeader( m_p_rx_buf ));
    return buf[0];
  }
  
  
  /***************** CC2420Receive Commands ****************/
  /**
   * Start frame delimiter signifies the beginning/end of a packet
   * See the CC2420 datasheet for details.
   */
  async command void CC2420Receive.sfd( uint16_t time ) {
    if ( m_timestamp_size < TIMESTAMP_QUEUE_SIZE ) {
      uint8_t tail =  ( ( m_timestamp_head + m_timestamp_size ) % 
                        TIMESTAMP_QUEUE_SIZE );
      m_timestamp_queue[ tail ] = time;
      m_timestamp_size++;
    }
  }

  async command void CC2420Receive.sfd_dropped() {
    if ( m_timestamp_size ) {
      m_timestamp_size--;
    }
  }

  /***************** PacketIndicator Commands ****************/
  command bool PacketIndicator.isReceiving() {
    bool receiving;
    atomic {
      receiving = receivingPacket;
    }
    return receiving;
  }


 
  
  /***************** InterruptFIFOP Events ****************/
  async event void InterruptFIFOP.fired() {
    uint8_t receive_packet_len =0;
  // ADBG(500, "\n\nInterruptFIFOP.fired, m_state=%d, _CC2430_RXFIFOCNT=%d\n", (int)m_state, (int)_CC2430_RXFIFOCNT);
    
    if (m_state == S_STARTED)
    {
    	BUFFER_RFD_ALL();

    	ADBG(10, "\r\nthe receive_packet_len = %d, IOCFG0=%d\r\n", (int)receive_packet_len, _CC2430_IOCFG0);

    	receivingPacket = TRUE;
    	post receivedPacketTask();
    	
    	/*
       ADBG(5, "receivedPacketTaskPosted=%d\n", (int)receivingPacket);
       if (!receivingPacket && (_CC2430_RXFIFOCNT > 0) )
       {
		receivingPacket = TRUE;
		post receivedPacketTask();
       }*/
    }
  }
  


  /***************** receiveTask ****************/
  void receiveEnd()
  {
	atomic receivingPacket = FALSE;
	frameLength = 0;
	receivedPacketTaskRetries = 0;
  }

  
  task void flushBufferTask()
  {
	call SFLUSHRX.strobe();

	atomic flushBufferTaskPosted = FALSE;

	initRFD();

	receiveEnd();
	

	ADBG(500, "MAC: Buffer flushed\r\n");
  }

  
  task void receivedPacketTask()
  {
	cc2420_header_t* header = call CC2420PacketBody.getHeader( m_p_rx_buf );
	cc2420_metadata_t* metadata = call CC2420PacketBody.getMetadata( m_p_rx_buf );
	uint8_t* receivedPacketPtr = (uint8_t*) header;
	uint8_t i = 0;
	uint8_t correlation = 0;
	uint16_t ii = 0;

	//ADBG(200, "receivedPacketTask _CC2430_RXFIFOCNT=%d\n", (int)countRFD());

	if (countRFD() <= 0)
	{
		return;
	}



	/* read frame length if not done so already */
	if (frameLength == 0)
	{
		frameLength = readRFD();

		if (frameLength == 0)
		{/* length == 0, start read next packet */
			post receivedPacketTask();
			return;
		}
		else if (frameLength >= SACK_HEADER_LENGTH && frameLength < 127)
		{
			receivedPacketPtr[0] = frameLength;
		}
		else
		{/* Bad packet! */
			ADBG(500, " Bad packet frameLength=%d\n", (int)frameLength);
			post flushBufferTask();
                	receiveEnd();
			return;
		}
	}

	/* check if entire frame has been received */
	if (frameLength > countRFD())
	{
		/* frame not complete */
		/* repost task if buffer is not overrun */
		/* or if this is not the 10th try       */
		BUFFER_RFD_ALL();
		
		atomic
		{
			if (flushBufferTaskPosted || receivedPacketTaskRetries > 100) 
			{
				ADBG(500, " flushBufferTaskPosted || receivedPacketTaskRetries=%d, frameLength= %d, countRFD= %d\n", (int)receivedPacketTaskRetries,
								(int)frameLength, (int)countRFD());
				post flushBufferTask();
				receiveEnd();
			}
			else
			{
				post receivedPacketTask();
				receivedPacketTaskRetries++;
			}
		}

		return;
	}

	/* reset retry counter */
	receivedPacketTaskRetries = 0;

	/* read FCF */
	for (i = 0; i < SACK_HEADER_LENGTH; i++)
	{
		if ( countRFD() > 0)
		{
			receivedPacketPtr[i+1] = readRFD();
		}
		else
		{/* Fail! */
			ADBG(500, " receive FCF fail at i=%d, RXFIFOCNT=%d\n", (int)i, (int)_CC2430_RXFIFOCNT);
			receiveEnd();
			return;
		}
	}

	/* Whether to ACK manual */

	if(call CC2420Config.isAutoAckEnabled() && !call CC2420Config.isHwAutoAckDefault()) {
        if (((( header->fcf >> IEEE154_FCF_ACK_REQ ) & 0x01) == 1)
            /*&& (header->dest == call CC2420Config.getShortAddr())  TODO,!!!!2009 XLQ*/
            && ((( header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7) == IEEE154_TYPE_DATA)) {
		// CSn flippage cuts off our FIFO; SACK and begin reading again
		call SACK.strobe();
		ADBG(500, " call SACK.strobe()\n");
        }
      }     
            
	/* read data from receive buffer */
	for (i = 0; i < frameLength-SACK_HEADER_LENGTH; i++)
	{
		if ( (countRFD() > 0))
		{
			receivedPacketPtr[i+1+SACK_HEADER_LENGTH] = readRFD();
		}
		else
		{
			/* Fail! */
			ADBG(500, " receive data fail at i=%d, RXFIFOCNT=%d\n", (int)i, (int)countRFD());
			receiveEnd();
			return;
		}
	}

	/* read CORRELATION */
	correlation = receivedPacketPtr[frameLength];

	ADBG(5, "RADIO received: len=%x DATA:", ADBG_N(frameLength));
	for (i=0; i < frameLength+1; i++)
	{
		ADBG(5, "%02x ", ADBG_N(u8(receivedPacketPtr, i)));
	}

	ADBG(5, "\r\n");

	rxFrameLength = frameLength;


	/* reset frameLength so next frame is read from the top */
	frameLength = 0;

        /***********************************************
        ** Process this frame
        ***********************************************/

       /* only signal packet if not corrupt */        
	if (correlation & FCS_CRC_OK_MASK) 
       {
	        uint8_t type = ( header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7;
	        signal CC2420Receive.receive( type, m_p_rx_buf );
	        if ( type == IEEE154_TYPE_DATA ) {
	          receiveDone();
          	   receiveEnd();
	          return;
	        }
	}
	else
	{
		ADBG(500, "MAC: CRC Failed\n\r");

		/* corrupt packet might indicate misaligned frame */        
		atomic receivingPacket = FALSE;
		post flushBufferTask();
	}

       /***********************************************
       ** Check if other frames are available
        ***********************************************/
       atomic
       { 
		/* if there are more bytes in rxfifo then get them */
		if ( (countRFD() > 0) /*&& (_CC2430_RXFIFOCNT < 129) */) 
			post receivedPacketTask();
		else 
		{
			receivingPacket = FALSE;

			/* check if buffer has overrun while processing frame   */
			/* and post flushBufferTask if it has           */
			if (flushBufferTaskPosted)
			{
				ADBG(500, "flushBufferTaskPosted\n");
				post flushBufferTask();
			}
		}
        }

        /* buggy hardware - enable interrupt when frame has been read */
        RFIF &= ~_BV(CC2430_RFIF_FIFOP);
        ADBG(5, "receivedPacketTask OVER\n");
  }
  /**************************************************************************
  * RFErr fired
  **************************************************************************/
  async event void InterruptRFErr.fired()
  {
	ADBG(500, "MAC: Buffer overrun\r\n");

	/* buffer overrun detected      *
	* if no receivedPacketTask is posted,  *
	* then flush buffer            *
	* else flag buffer to be flushed   */   
	
//	if (flushBufferTaskPosted)
//	{
		post flushBufferTask();
//	}

	atomic flushBufferTaskPosted = TRUE;
	
/*
	call SFLUSHRX.strobe();

	//atomic flushBufferTaskPosted = FALSE;

	initRFD();

	if (receivingPacket)
	{
		receiveEnd();
	}*/
  }

#if 0
  /***************** RXFIFO Events ****************/
  /**
   * We received some bytes from the SPI bus.  Process them in the context
   * of the state we're in.  Remember the length byte is not part of the length
   */
  async event void RXFIFO.readDone( uint8_t* rx_buf, uint8_t rx_len,
                                    error_t error ) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader( m_p_rx_buf );
    cc2420_metadata_t* metadata = call CC2420PacketBody.getMetadata( m_p_rx_buf );
    uint8_t* buf = (uint8_t*) header;


    
    
    ADBG(5, "RXFIFO.readDone, m_state=%d, rxFrameLength=%d, m_bytes_left=%d\n", (int)m_state, (int)rxFrameLength, (int)m_bytes_left);
    return;
    
    rxFrameLength = buf[ 0 ];

    switch( m_state ) {

    case S_RX_LENGTH:
      m_state = S_RX_FCF;
      if ( rxFrameLength + 1 > m_bytes_left ) {
        // Length of this packet is bigger than the RXFIFO, flush it out.
        flush();
        
      } else {
        if ( !call FIFO.get() && !call FIFOP.get() ) {
          m_bytes_left -= rxFrameLength + 1;
        }
        
        if(rxFrameLength <= MAC_PACKET_SIZE) {
          if(rxFrameLength > 0) {
            if(rxFrameLength > SACK_HEADER_LENGTH) {
              // This packet has an FCF byte plus at least one more byte to read
              call RXFIFO.continueRead(buf + 1, SACK_HEADER_LENGTH);
              
            } else {
              // This is really a bad packet, skip FCF and get it out of here.
              m_state = S_RX_PAYLOAD;
              call RXFIFO.continueRead(buf + 1, rxFrameLength);
            }
                            
          } else {
            // Length == 0; start reading the next packet
            atomic receivingPacket = FALSE;
            call CSN.set();
            call SpiResource.release();
            waitForNextPacket();
          }
          
        } else {
          // Length is too large; we have to flush the entire Rx FIFO
          flush();
        }
      }
      break;
      
    case S_RX_FCF:
      m_state = S_RX_PAYLOAD;
      
      /*
       * The destination address check here is not completely optimized. If you 
       * are seeing issues with dropped acknowledgements, try removing
       * the address check and decreasing SACK_HEADER_LENGTH to 2.
       * The length byte and the FCF byte are the only two bytes required
       * to know that the packet is valid and requested an ack.  The destination
       * address is useful when we want to sniff packets from other transmitters
       * while acknowledging packets that were destined for our local address.
       */
      if(call CC2420Config.isAutoAckEnabled() && !call CC2420Config.isHwAutoAckDefault()) {
        if (((( header->fcf >> IEEE154_FCF_ACK_REQ ) & 0x01) == 1)
            && (header->dest == call CC2420Config.getShortAddr())
            && ((( header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7) == IEEE154_TYPE_DATA)) {
          // CSn flippage cuts off our FIFO; SACK and begin reading again
          call CSN.set();
          call CSN.clr();
          call SACK.strobe();
          call CSN.set();
          call CSN.clr();
          call RXFIFO.beginRead(buf + 1 + SACK_HEADER_LENGTH, 
              rxFrameLength - SACK_HEADER_LENGTH);
          return;
        }
      }
      
      // Didn't flip CSn, we're ok to continue reading.
      call RXFIFO.continueRead(buf + 1 + SACK_HEADER_LENGTH, 
          rxFrameLength - SACK_HEADER_LENGTH);
      break;
    
    case S_RX_PAYLOAD:
      call CSN.set();
      
      if(!m_missed_packets) {
        // Release the SPI only if there are no more frames to download
        call SpiResource.release();
      }
      
      if ( m_timestamp_size ) {
        if ( rxFrameLength > 10 ) {
          metadata->time = m_timestamp_queue[ m_timestamp_head ];
          m_timestamp_head = ( m_timestamp_head + 1 ) % TIMESTAMP_QUEUE_SIZE;
          m_timestamp_size--;
        }
      } else {
        metadata->time = 0xffff;
      }
      
      // We may have received an ack that should be processed by Transmit
      // buf[rxFrameLength] >> 7 checks the CRC
      if ( ( buf[ rxFrameLength ] >> 7 ) && rx_buf ) {
        uint8_t type = ( header->fcf >> IEEE154_FCF_FRAME_TYPE ) & 7;
        signal CC2420Receive.receive( type, m_p_rx_buf );
        if ( type == IEEE154_TYPE_DATA ) {
          receiveDone();
          receiveEnd();
          return;
        }
      }
      
      waitForNextPacket();
      break;

    default:
      atomic receivingPacket = FALSE;
      call CSN.set();
      call SpiResource.release();
      break;
      
    }
    
  }

  async event void RXFIFO.writeDone( uint8_t* tx_buf, uint8_t tx_len, error_t error ) {
  }  
#endif /*  */  
  /***************** Tasks *****************/
  /**
   * Fill in metadata details, pass the packet up the stack, and
   * get the next packet.
   */
  void receiveDone()
  {
    cc2420_metadata_t* metadata = call CC2420PacketBody.getMetadata( m_p_rx_buf );
    uint8_t* buf = (uint8_t*) call CC2420PacketBody.getHeader( m_p_rx_buf );;
    
    metadata->crc = buf[ rxFrameLength ] >> 7;
    metadata->rssi = buf[ rxFrameLength - 1 ];
    metadata->lqi = metadata->rssi + 0x7F;
    signal Receive.receive( m_p_rx_buf, m_p_rx_buf->data, 
                                         rxFrameLength );
  }
  
  command void Receive.updateBuffer(message_t * msg)
  {
    ADBG(5, "Receive.updateBuffer\n");
    
    //m_p_rx_buf = msg;
    atomic receivingPacket = FALSE;
  }
  
  /****************** CC2420Config Events ****************/
  event void CC2420Config.syncDone( error_t error ) {
  }
  
  /****************** Functions ****************/
  
  
  /**
   * Reset this component
   */
  void reset_state() {
    m_bytes_left = RXFIFO_SIZE;
    atomic receivingPacket = FALSE;
    m_timestamp_head = 0;
    m_timestamp_size = 0;
    m_missed_packets = 0;
  }

}
