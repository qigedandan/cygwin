module CC2430ActiveMessageP {
  provides {
    interface AMSend[am_id_t id];
    interface Receive[am_id_t id];
    interface Receive as Snoop[am_id_t id];
    interface AMPacket;
    interface Packet;

    //interface ActiveMessageResource[uint8_t id];
  }
  uses {
    //interface Send as SubSend;
    //interface Receive as SubReceive;
      // interface StdControl as HALCC2420Control;
       //interface HALCC2420;
	interface Send as SubSend;
	interface Receive as SubReceive;

       command am_addr_t amAddress();


       // resource
       //interface ResourceQueue as FcfsQueue;
  }
}
implementation {

  enum {
    CC2420_SIZE = MAC_HEADER_SIZE + MAC_FOOTER_SIZE,
  };

  
  
  cc2420_header_t* getHeader( message_t* msg ) {
    return (cc2420_header_t*)( msg->data - sizeof(cc2420_header_t) );
  }

  message_t receivedPacket;
  message_t * receivedPacketPtr;

  bool m_sending = FALSE;
  bool m_send_timeout = FALSE;
  message_t *m_msg = NULL;
  uint8_t m_len = 0;
  uint8_t m_send_dsn;

  //task void grantTask();
  
  error_t trySend()
  {
      ADBG(1, "try send\n");
      return (call SubSend.send( m_msg, m_len));
  }

  error_t doTimeoutSend()
  {
    return trySend();
  }


  command error_t AMSend.send[am_id_t id](am_addr_t addr,
					  message_t* msg,
					  uint8_t len) {
    uint8_t i, length;

    cc2420_header_t* header = getHeader( msg );

    atomic
    {
        if (m_sending)
        {
            return FAIL;
        }
        
        m_sending = TRUE;
    }

    
    header->type = id;

	#ifdef STARNETWORK
	header->dest = 0x0001;
	#else
	header->dest = addr;
	#endif
	
    //header->destpan = TOS_AM_GROUP;
    header->destpan = TOS_IEEE_PANID;
    //header->destpan = 0x0023;
    
    //header->group = call AMPacket.group();
    header->dsn = ++m_send_dsn;

    ADBG(10, "AMSend.send type=%d, len=%d", ADBG_N(id), ADBG_N(len));

    m_msg = msg;
    m_len = len;
    

    if (doTimeoutSend() != SUCCESS)
    {
        m_sending = FALSE;
        return FAIL;
    }

    return SUCCESS;
  }

  command error_t AMSend.cancel[am_id_t id](message_t* msg) {
    return call SubSend.cancel(msg);
    return SUCCESS;
  }

  command uint8_t AMSend.maxPayloadLength[am_id_t id]() {
    return call Packet.maxPayloadLength();
  }

  command void* AMSend.getPayload[am_id_t id](message_t* m) {
    return call Packet.getPayload(m, NULL);
  }

  command void* Receive.getPayload[am_id_t id](message_t* m, uint8_t* len) {
    return call Packet.getPayload(m, len);
  }

  command uint8_t Receive.payloadLength[am_id_t id](message_t* m) {
    return call Packet.payloadLength(m);
  }
  
  command void* Snoop.getPayload[am_id_t id](message_t* m, uint8_t* len) {
    return call Packet.getPayload(m, len);
  }

  command uint8_t Snoop.payloadLength[am_id_t id](message_t* m) {
    return call Packet.payloadLength(m);
  }
  
  event void SubSend.sendDone(message_t* msg, error_t result)
  {
      bool send_end = TRUE;

      ADBG(10, "SubSend.sendDone\n");

      signal AMSend.sendDone[call AMPacket.type(msg)](msg, result);
      m_sending = FALSE;

      //
      //post grantTask();
  }

  /* Receiving a packet */
  
  event message_t* SubReceive.receive(message_t* msg, void* payload, uint8_t len) {
    if (call AMPacket.isForMe(msg)) {
      //return signal Receive.receive[call AMPacket.type(msg)](msg, payload, len - CC2420_SIZE);
      return signal Receive.receive[call AMPacket.type(msg)](msg, payload, len);
    }
    else {
      return signal Snoop.receive[call AMPacket.type(msg)](msg, payload, len);
    }
   }

  command am_addr_t AMPacket.address() {
        return TOS_IEEE_SADDR;
  }
 
  command am_addr_t AMPacket.destination(message_t* amsg) {
    cc2420_header_t* header = getHeader(amsg);
    return header->dest;
  }
 
  command am_addr_t AMPacket.source(message_t* amsg) {
    cc2420_header_t* header = getHeader(amsg);
    return header->src;
  }

  command void AMPacket.setDestination(message_t* amsg, am_addr_t addr) {
    cc2420_header_t* header = getHeader(amsg);
    	#ifdef STARNETWORK
	header->dest = 0x0001;
	#else
	header->dest = addr;
	#endif
  }

  command void AMPacket.setSource(message_t* amsg, am_addr_t addr) {
    cc2420_header_t* header = getHeader(amsg);
    header->src = addr;
  }

  command bool AMPacket.isForMe(message_t* amsg) {
    return (call AMPacket.destination(amsg) == call AMPacket.address() ||
	    call AMPacket.destination(amsg) == AM_BROADCAST_ADDR);
  }

  command am_id_t AMPacket.type(message_t* amsg) {
    cc2420_header_t* header = getHeader(amsg);
    return header->type;
  }

  command void AMPacket.setType(message_t* amsg, am_id_t type) {
    cc2420_header_t* header = getHeader(amsg);
    header->type = type;
  }
  command am_group_t AMPacket.group(message_t *amsg) {
    return getHeader(amsg)->group;
  }
  command void AMPacket.setGroup(message_t *amsg, am_group_t group) {
    getHeader(amsg)->group = group;
  }

  command am_group_t AMPacket.localGroup() {
    return TOS_AM_GROUP;
  }


  default event message_t* Receive.receive[am_id_t id](message_t* msg, void* payload, uint8_t len) {
    return msg;
  }
  
  default event message_t* Snoop.receive[am_id_t id](message_t* msg, void* payload, uint8_t len) {
    return msg;
  }

 default event void AMSend.sendDone[uint8_t id](message_t* msg, error_t err) {
   return;
 }

 
 command void Packet.clear(message_t* msg) {}
 
 command uint8_t Packet.payloadLength(message_t* msg) {
   return getHeader(msg)->length;
 }


 command void Packet.setPayloadLength(message_t* msg, uint8_t len) {
   getHeader(msg)->length  = len;
 }

 command uint8_t Packet.maxPayloadLength() {
   return TOSH_DATA_LENGTH;
 }
 
 command void* Packet.getPayload(message_t* msg, uint8_t* len) {
   if (len != NULL) {
     *len = call Packet.payloadLength(msg);
   }
   return msg->data;
 }


 /* ActiveMessageResource */
 /*
 	bool grantNext(bool result)
 	{
		uint8_t next_id = 0xFF;
		if (!call FcfsQueue.isEmpty())
		{
			next_id = call FcfsQueue.dequeue();
		}

		if (next_id != 0xFF)
		{
			signal ActiveMessageResource.granted[next_id](result);
 		}

 		return !(call FcfsQueue.isEmpty());
 	}
 
 	task void grantTask()
 	{
 		grantNext(TRUE);
 	}
 
	command error_t ActiveMessageResource.request[uint8_t id]()
	{
		ADBG(DBG_LEV, "requesting m_sending =%d\n", (int)m_sending);
		if (m_sending)
		{
			if (!call FcfsQueue.isEnqueued(id))
			{
				call FcfsQueue.enqueue(id);
			}
		}
		else
		{
			signal ActiveMessageResource.granted[id](TRUE);
		}

		return SUCCESS;
	}

	default event void ActiveMessageResource.granted[uint8_t id](bool success) { }
*/
}
