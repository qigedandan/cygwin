
module NullCC2430ActiveMessageC {
  provides {
    interface AMSend[am_id_t id];
    interface Receive[am_id_t id];
    interface Receive as Snoop[am_id_t id];
    interface AMPacket;
    interface Packet;

  }
}
implementation {

  cc2420_header_t* getHeader( message_t* msg ) {
    return (cc2420_header_t*)( msg->data - sizeof(cc2420_header_t) );
  }

  command error_t AMSend.send[am_id_t id](am_addr_t addr,
					  message_t* msg,
					  uint8_t len) {


  }

  command error_t AMSend.cancel[am_id_t id](message_t* msg) {
    //return call SubSend.cancel(msg);
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

  command am_addr_t AMPacket.address() {
    //return call amAddress();
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


}
