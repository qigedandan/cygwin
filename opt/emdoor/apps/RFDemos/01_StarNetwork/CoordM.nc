/*************************************************
*	FUNCTION NAME : CoordM.nc
*	FUNCTION DESCRIPTION : 接收RF数据，并通过串口显示
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#include "message.h"
module CoordM {
    uses interface Boot;
    uses interface StdControl as WsnControl;    
    uses interface Intercept;
    uses interface ABS;
    uses interface AMPacket;
    uses interface Packet;
}
implementation {
    message_t m_msg;
    message_t *p_msg;
   
    event void Boot.booted() {
        p_msg = &m_msg;

        ADBG(1, "\r\nBoot.booted");
        
        call WsnControl.start();
    }

    task void reportPacket() {
    }

    event void ABS.reportPacketDone(uint8_t *src, uint16_t len, error_t result) {
    }

    event bool Intercept.forward(message_t * msg, void *payload, uint16_t len) {
        uint8_t len8;
        payload = call Packet.getPayload(msg, &len8);
 
        ADBG(1, "\r\CoordM receive len=%d", len);
        len = (uint16_t)len8;
        
        call ABS.reportPacket(call AMPacket.group(msg), payload, len);
        return FALSE;
    }
}

