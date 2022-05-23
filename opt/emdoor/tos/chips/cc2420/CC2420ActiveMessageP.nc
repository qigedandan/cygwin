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
 
/*									tab:4
 * "Copyright (c) 2005 Stanford University. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL STANFORD UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
 * IF STANFORD UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 * 
 * STANFORD UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND STANFORD UNIVERSITY
 * HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
 * ENHANCEMENTS, OR MODIFICATIONS."
 */


/**
 * Active message implementation on top of the CC2420 radio. This
 * implementation uses the 16-bit addressing mode of 802.15.4: the
 * only additional byte it adds is the AM id byte, as the first byte
 * of the data payload.
 *
 * @author Philip Levis
 * @author Greg Hackmann
 * @author Kevin Klues
 * @author Octav Chipara
 * @version $Revision: 1.2 $ $Date: 2008/06/27 20:27:21 $
 */
 
#include "CC2420.h"
module CC2420ActiveMessageP {
  provides {
    interface AMSend[am_id_t id];
    interface Receive[am_id_t id];
    interface Receive as Snoop[am_id_t id];
    interface AMPacket;
    interface Packet;

    /* added for resource control. XLQ 20091128 */
    interface ActiveMessageResource[uint8_t id];
  }
  uses {
    interface Send as SubSend;
    interface Receive as SubReceive;
    interface CC2420Packet;
    interface CC2420PacketBody;
    interface CC2420Config;
    interface ActiveMessageAddress;

    /* added for resource control.XLQ 20091128 */
    interface Queue<uint8_t> as RequestQueue;
    interface State as RadioState;
  }
}
implementation {

  enum {
    CC2420_SIZE = MAC_HEADER_SIZE + MAC_FOOTER_SIZE,
  };


  	/* added for resource control.XLQ 20091128 */
	task void grantNext();
	
  
  /***************** AMSend Commands ****************/
  command error_t AMSend.send[am_id_t id](am_addr_t addr,
					  message_t* msg,
					  uint8_t len) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader( msg );
    header->type = id;
    
    #ifdef STARNETWORK
    header->dest = 0x0001;
    #else
    header->dest = addr;
    #endif
    
    header->destpan = call CC2420Config.getPanAddr();

   ADBG(100, "---->AMSend.send addr=0x%x, type=%d, len=0x%02x\n", (int)addr, (int)id, (int)len);
    
    //return call SubSend.send( msg, len + CC2420_SIZE );

    if (call SubSend.send( msg, len + CC2420_SIZE ) != SUCCESS)
    {
    	signal AMSend.sendDone[call AMPacket.type(msg)](msg, FAIL);

	//resource free now, XLQ 20091128
	post grantNext();
    }

    return SUCCESS;
  }

  command error_t AMSend.cancel[am_id_t id](message_t* msg) {
    return call SubSend.cancel(msg);
  }

  command uint8_t AMSend.maxPayloadLength[am_id_t id]() {
    return call Packet.maxPayloadLength();
  }

  command void* AMSend.getPayload[am_id_t id](message_t* m) {
    return call Packet.getPayload(m, NULL);
  }

  /***************** Receive Commands ****************/
  command void* Receive.getPayload[am_id_t id](message_t* m, uint8_t* len) {
    return call Packet.getPayload(m, len);
  }

  command uint8_t Receive.payloadLength[am_id_t id](message_t* m) {
    return call Packet.payloadLength(m);
  }
  
  /***************** Snoop Commands ****************/
  command void* Snoop.getPayload[am_id_t id](message_t* m, uint8_t* len) {
    return call Packet.getPayload(m, len);
  }

  command uint8_t Snoop.payloadLength[am_id_t id](message_t* m) {
    return call Packet.payloadLength(m);
  }

  /***************** AMPacket Commands ****************/
  command am_addr_t AMPacket.address() {
    return call ActiveMessageAddress.amAddress();
  }
 
  command am_addr_t AMPacket.destination(message_t* amsg) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader(amsg);
    ADBG(5,"the AMPacket.destination is called!det is %d\r\n",(int)header->dest);
    return header->dest;
  }
 
  command am_addr_t AMPacket.source(message_t* amsg) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader(amsg);
    return header->src;
  }

  command void AMPacket.setDestination(message_t* amsg, am_addr_t addr) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader(amsg);
	#ifdef STARNETWORK	
	header->dest = 0x0001;	
	#else	
	header->dest = addr;	
	#endif
  }

  command void AMPacket.setSource(message_t* amsg, am_addr_t addr) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader(amsg);
    header->src = addr;
  }

  command bool AMPacket.isForMe(message_t* amsg) {
    return (call AMPacket.destination(amsg) == call AMPacket.address() ||
	    call AMPacket.destination(amsg) == AM_BROADCAST_ADDR);
  }

  command am_id_t AMPacket.type(message_t* amsg) {
    cc2420_header_t* Header = call CC2420PacketBody.getHeader(amsg);
    return Header->type;
  }

  command void AMPacket.setType(message_t* amsg, am_id_t type) {
    cc2420_header_t* header = call CC2420PacketBody.getHeader(amsg);
    header->type = type;
  }
  
  command am_group_t AMPacket.group(message_t* amsg) {
    return (call CC2420PacketBody.getHeader(amsg))->destpan;
  }

  command void AMPacket.setGroup(message_t* amsg, am_group_t grp) {
    // Overridden intentionally when we send()
    (call CC2420PacketBody.getHeader(amsg))->destpan = grp;
  }

  command am_group_t AMPacket.localGroup() {
    return call CC2420Config.getPanAddr();
  }
  /*  reserved  XLQ
  command uint8_t AMPacket.headerSize() {
    return sizeof(cc2420_header_t);
  }
*/
  /***************** Packet Commands ****************/
  command void Packet.clear(message_t* msg) {
  }
  
  command uint8_t Packet.payloadLength(message_t* msg) {
    return (call CC2420PacketBody.getHeader(msg))->length - CC2420_SIZE;
  }
  
  command void Packet.setPayloadLength(message_t* msg, uint8_t len) {
    (call CC2420PacketBody.getHeader(msg))->length  = len + CC2420_SIZE;
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

  
  /***************** SubSend Events ****************/
  
  event void SubSend.sendDone(message_t* msg, error_t result) {
    //cc2420_header_t*  header = call CC2420PacketBody.getHeader(msg);
   // ADBG(16, "CC2420ActiveMessageP.subSend.sendDone, msg=0x%x,msg.type=%d,result=%d\n",(int)msg,(int)call AMPacket.type(msg), (int)result);//(int)call AMPacket.type(msg),(int)result);
     //ADBG(100, "CC2420ActiveMessageP.subSend.sendDone,type=%d \r\n", (int)call AMPacket.type(msg));
     signal AMSend.sendDone[call AMPacket.type(msg)](msg, result);

     //resource free now, XLQ 20091128
     post grantNext();

     ADBG(100,  "<--- AMSend.sendDone result=%d\n\n", (int)result);
     
  }

  
  /***************** SubReceive Events ****************/
  event message_t* SubReceive.receive(message_t* msg, void* payload, uint8_t len) {
  	ADBG(2,"\r\n----> AMReceive msg, msg id is:%d, isForMe? %d", (int)call AMPacket.type(msg), (int)call AMPacket.isForMe(msg));
    if (call AMPacket.isForMe(msg)) {
      return signal Receive.receive[call AMPacket.type(msg)](msg, payload, len - CC2420_SIZE);
    }
    else {
      return signal Snoop.receive[call AMPacket.type(msg)](msg, payload, len - CC2420_SIZE);
    }
  }
  

  /***************** ActiveMessageAddress Events ****************/
  async event void ActiveMessageAddress.changed() {
  }
  
  /***************** CC2420Config Events ****************/
  event void CC2420Config.syncDone( error_t error ) {
  }
  
  /***************** Defaults ****************/
  default event message_t* Receive.receive[am_id_t id](message_t* msg, void* payload, uint8_t len) {
    return msg;
  }
  
  default event message_t* Snoop.receive[am_id_t id](message_t* msg, void* payload, uint8_t len) {
    return msg;
  }

  default event void AMSend.sendDone[uint8_t id](message_t* msg, error_t err) {
    return;
  }


	/*============*/
	enum {
	    S_OFF, // off by default
	    S_TURNING_ON,
	    S_ON,
	    S_TURNING_OFF,
  	};

  	void grandNow()
  	{
  		if (call RadioState.getState() == S_ON)
  		{
			signal ActiveMessageResource.granted[call RequestQueue.head()](TRUE);
		}
		else
		{
			signal ActiveMessageResource.granted[call RequestQueue.head()](FALSE);
			
			post grantNext();
		}
  	}
  
	task void grantNext()
	{
  		if (!call RequestQueue.empty())
  		{
  			call RequestQueue.dequeue();
  		}

  		if (!call RequestQueue.empty())
  		{
  			grandNow();
  		}
	}
	
	command error_t ActiveMessageResource.request[uint8_t id]()
	{
		call RequestQueue.enqueue(id);

		if (call RequestQueue.size() == 1)
		{
			/* only one immediatly apply */
			grandNow();
		}
		
		return SUCCESS;
	}
	
	default event void ActiveMessageResource.granted[uint8_t id](bool success) {}
}
