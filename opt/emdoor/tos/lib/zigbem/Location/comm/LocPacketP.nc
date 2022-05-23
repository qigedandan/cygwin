#include "LocPacket.h"
module LocPacketP
{
	provides interface LocPacket;

	uses interface AMSend as Send;
	uses interface Receive;
	uses interface CC2420PacketBody;
	uses interface Packet;
}
implementation
{    
#define MAX_SEND_TIME 16
	message_t m_msg;
    uint16_t dest_address = 0;
    uint8_t m_len = 0;
    uint8_t sendTime = 0;
    loc_packet_t LocPack;
    
    task void doSend();

    void sendFail()
    {
		if(sendTime < MAX_SEND_TIME)
		{
	              sendTime ++;
		 	post doSend();
		 }
		 else
		 {
		 	sendTime = 0;
                	signal LocPacket.SendDone(FAIL);
		 }
   }

    task void doSend()
    {
        error_t result;
	 cc2420_header_t* header = (cc2420_header_t *)( &(m_msg.header));
	 cc2420_metadata_t* metadata = (cc2420_metadata_t *)( &(m_msg.metadata));

        
	 ADBG(200, "send to dest_address=0x%04x\n", dest_address);

	 header->dest = dest_address;

        result = call Send.send(dest_address,&m_msg, m_len);

	 ADBG(200, "AMSend.send result=%d\n", (int)result);

	 if (result != SUCCESS)
	 {
	 	sendFail();
	 }
    
    }
 
    command void LocPacket.Send(loc_packet_t* lp_t)
	{
        uint8_t i = 0;
        uint8_t len = 0;
        //uint8_t *payload = (uint8_t *)(&m_msg.data);
        uint8_t* payload = (uint8_t*) call Packet.getPayload(&m_msg, NULL);
        ADBG(8, " \r\n\r\n[LocPacket] call send\r\n\r\n");

        
        dest_address = lp_t->header.addr ;
        len = lp_t -> header.len;
        m_len = len + 3;
        
        payload[0] = LOC_PACKET_KEY;
        payload[1] = lp_t -> type;
        payload[2] = len;
        if(len)
        {
            for(i=0;i < len;i++)
            {
                payload[i+3] = (lp_t -> data)[i + LP_HEADER_LEN];
            }
        }

	 post doSend();
        
	}
    
	event void Send.sendDone(message_t *msg, error_t success)
    {
        ADBG(2, "* Sent %s!\r\n", (success == SUCCESS) ? "OK" : "FAIL");
                  
        if(success == SUCCESS)
        {
            sendTime = 0;
            signal LocPacket.SendDone(success);
        }
        else
        {
		sendFail();
        }
    }
	
	event message_t *Receive.receive(message_t *msg, void *payload, uint8_t len)
    {
        uint8_t i;
        uint8_t headerLen;
        uint8_t *DataPtr = (uint8_t *)payload;
	cc2420_header_t* header = call CC2420PacketBody.getHeader(msg);//(cc2420_header_t *)( &(msg->header));
	cc2420_metadata_t* metadata =call CC2420PacketBody.getMetadata(msg); //(cc2420_metadata_t *)( &(msg->metadata));

            //signal LocPacket.Receive(&LocPack);
            
//    ADBG(200,"\r\nReceive.receive");
//		ADBG(200,"*");
        if(DataPtr[0] == LOC_PACKET_KEY )
        {
            LocPack.type = DataPtr[1] ;
            LocPack.header.addr = header->src ;
            LocPack.header.len = DataPtr[2] ;
            for(i=0;i<(LocPack.header.len);i++)
            {
                (LocPack.data)[i + LP_HEADER_LEN ] = DataPtr[i + 3];
            }

  	     	ADBG(2,"rssi=[%d], _CC2430_TXCTRLH = %x, _CC2430_TXCTRLL = %x\n", (int)((int8_t)metadata->rssi), (int)_CC2430_TXCTRLH, (int)_CC2430_TXCTRLL);
       	     	
            if( LocPack.type == LT_BN_2RN_REQ)
            {
	            if (metadata->rssi & 0x80)
       	     {
              	  metadata->rssi = -(0x80 - (metadata->rssi&0x7F));
	            }
       	     LocPack.lp_bn2rn_req.rssi = 45 - (metadata->rssi) ;
            }
            if( LocPack.type == LT_RN_2BN_LOC)
            {
//            	ADBG(200,"\r\nLT_RN_2BN_LOC __ rssi= %d\r\n",(int)(metadata->rssi));


	            if (metadata->rssi & 0x80)
       	     	{
              	  metadata->rssi = -(0x80 - (metadata->rssi&0x7F));
	            }
       	     	LocPack.lp_rn2bn_loc.rssi = 45 - (metadata->rssi) ;
            }
            signal LocPacket.Receive(&LocPack);
        } 

        return msg;
	}
}

