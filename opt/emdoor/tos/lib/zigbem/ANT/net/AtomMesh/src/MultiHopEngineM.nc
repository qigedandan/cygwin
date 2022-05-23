

includes AM;
includes MultiHop;

#ifndef MHOP_QUEUE_SIZE
#define MHOP_QUEUE_SIZE	2
#endif

module MultiHopEngineM {
  provides {
    interface Init;
    interface StdControl;
    
    interface Receive[uint8_t id];
    interface Send[uint8_t id];
    interface Intercept as Intercept[uint8_t id];
    interface Intercept as Snoop[uint8_t id];
    interface Receive as ReceiveDataMsg[uint8_t id];
    interface RouteControl;

    command   message_t *SendDownStreamMsg(message_t *pMsg);
    interface MultiHop;    
  }

  uses {
    event void MultiHopForward(message_t *pMsg);
    //interface ReceiveMsg[uint8_t id];
    interface Receive as ReceiveMsg[uint8_t id];
    
    //interface SendMsg[uint8_t id];
    interface Send as SendMsg[uint8_t id];
    
    interface RouteControl as RouteSelectCntl;
    interface RouteSelect;
    
    interface StdControl as SubControl;
    interface Init as SubInit;
    
    //interface CommControl;    
    //interface StdControl as CommStdControl;
    
    interface Receive as ReceiveDownstreamMsg[uint8_t id];
    
    //interface RadioPower;
    
    //interface Timer<TMilli>;
    //command void set_power_mode(uint8_t mode);

    interface AMPacket;
    interface Packet;

    interface SplitControl as AMControl;

  }
}

implementation {
  enum {
    //FWD_QUEUE_SIZE = MHOP_QUEUE_SIZE, 
    FWD_QUEUE_SIZE = 2, 
    EMPTY = 0xff
  };
  
  /*
  struct TOS_Msg FwdBuffers[FWD_QUEUE_SIZE];
  struct TOS_Msg *FwdBufList[FWD_QUEUE_SIZE];
  */

  message_t FwdBuffers[FWD_QUEUE_SIZE];
  message_t *FwdBufList[FWD_QUEUE_SIZE];
  
  uint8_t FwdBufBusy[FWD_QUEUE_SIZE];

  uint8_t iFwdBufHead, iFwdBufTail;

  int timer_rate,timer_ticks;

  default event bool MultiHop.BeforeForward(message_t *msg)
  {
  	return TRUE;
  }
  
  static void initialize() {
    int n;

    for (n=0; n < FWD_QUEUE_SIZE; n++) {
      FwdBufList[n] = &FwdBuffers[n];
      FwdBufBusy[n] = 0;
    } 

    iFwdBufHead = iFwdBufTail = 0;
  }

  command error_t Init.init() {
    XDBG(0, "MultiHopEngineM Init.init\r\n");
    
    initialize();
    //call CommStdControl.init();
    //return call SubControl.init();
    return call SubInit.init();
  }

  command error_t StdControl.start() {
    //call CommStdControl.start();
    XDBG(0, "MultiHopEngineM StdControl.start\r\n");
    call AMControl.start();
    call SubControl.start();
    //return call CommControl.setPromiscuous(TRUE);
    return TRUE;
  }

  event void AMControl.startDone(error_t result)
  {
  }
  event void AMControl.stopDone(error_t result)
  {
  }

  command error_t StdControl.stop() {
    call SubControl.stop();
    
    //return call CommStdControl.stop();
    return TRUE;
  }

  command error_t Send.cancel[uint8_t id](message_t *pMsg)
  {
      return SUCCESS;
  }

  command uint8_t Send.maxPayloadLength[uint8_t id]()
  {
	return 100;
  }

  command void * Send.getPayload[uint8_t id](message_t *msg)
  {
       TOS_MHopMsg * pMHopMsg = (TOS_MHopMsg *)(call SendMsg.getPayload[id](msg));
      
  	return &(pMHopMsg->data[0]);
  }

  command error_t Send.send[uint8_t id](message_t *pMsg, uint8_t PayloadLen) {

    uint16_t usMHLength = offsetof(TOS_MHopMsg, data) + PayloadLen;

    ADBG(1, "MultiHopEngineM Send.send usMHLength=0x%x", ADBG_N(usMHLength));
    
    if (usMHLength > TOSH_DATA_LENGTH) {
      return FAIL;
    }   

    call RouteSelect.initializeFields(pMsg,id);

    if (call RouteSelect.selectRoute(pMsg,id, 0, 1) != SUCCESS) {
      return FAIL;
    } 
	
    if (call SendMsg.send[id](pMsg, usMHLength) != SUCCESS) {
      return FAIL;
    }

    return SUCCESS;    
  } 
/*
  command void *Send.getBuffer[uint8_t id](message_t *pMsg, uint16_t* length) {
    
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)pMsg->data;
    
    *length = TOSH_DATA_LENGTH - offsetof(TOS_MHopMsg,data);

    return (&pMHMsg->data[0]);

  }
*/  
    int8_t get_buff(uint8_t down){
    int8_t n;
    uint8_t val = 1;
    if(down == 1) val = 2;
    for (n=0; n < FWD_QUEUE_SIZE; n++) {
	uint8_t done = 0;
        atomic{
		if(FwdBufBusy[n] == 0){
			FwdBufBusy[n] = val;
			done = 1;
		}
        }
	if(done == 1) return n;
      
    } 
    return -1;
	} 
	
    int8_t is_ours(message_t * ptr){
    int8_t n;
    for (n=0; n < FWD_QUEUE_SIZE; n++) {
       if(FwdBufList[n] == ptr){
		return n;
       }
    } 
    return -1;
  }
   
   uint16_t seconds;
/*
  event void Timer.fired() {
       if(seconds & 0x8000){
               seconds &= 0x7fff;
               //call RadioPower.SetListeningMode(0);
               //call RadioPower.SetTransmitMode(0);
 	       //call set_power_mode(1);
               //TOSH_CLR_YELLOW_LED_PIN();
       }

       if(seconds > 0){
               seconds --;
               call Timer.startOneShot(1000);
       }else{
               //call RadioPower.SetListeningMode(1);
               //call RadioPower.SetTransmitMode(1);
 	       //call set_power_mode(0);
               //TOSH_SET_YELLOW_LED_PIN();
       }

       //return SUCCESS;
   }
*/
     void ReceivePowerMsg(message_t *pMsg, void* payload, uint16_t payloadLen) {
       uint8_t command_type = ((char*)payload)[0];
       if(command_type == 1){
               seconds = ((char*)payload)[1];
               seconds |= 0x8000;
               //call Timer.startOneShot(2000);
       }else if(command_type == 0){
               seconds = 0;
               //call Timer.startOneShot(1000);
       }
   }

  static message_t * mForward(message_t * pMsg, uint8_t id, uint8_t direction)
  {
        signal MultiHopForward(pMsg);

        if(direction == 0){                                      
    	    if ((call RouteSelect.selectRoute(pMsg,id, 0, 0)) != SUCCESS) {
      		return pMsg;
    	    }
         }else{                                                   
    	    if ((call RouteSelect.selectDescendantRoute(pMsg,id, 0, 0)) != SUCCESS) {                            
      		return pMsg;
	    }
        }

        signal MultiHop.BeforeForward(pMsg);
    
        call SendMsg.send[id](pMsg, call Packet.payloadLength(pMsg));

        return pMsg;
  }
  /*
   static message_t * mForward(message_t * pMsg, uint8_t id, uint8_t direction) {

    message_t *	pNewBuf = pMsg;
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)pMsg->data;
    int8_t buf = get_buff(direction);


    signal MultiHopForward(pMsg);

    //if(pMsg->type == 248 ||	pMsg->type == 249) {
    if (call AMPacket.type(pMsg) == 248 ||call AMPacket.type(pMsg) == 249) {
  	  ReceivePowerMsg(pMsg, pMHMsg->data, sizeof(pMHMsg->data));
    }
    
    if (buf == -1) return pNewBuf;

    if(direction == 0){                                      
    	if ((call RouteSelect.selectRoute(pMsg,id, 0, 0)) != SUCCESS) {
      		FwdBufBusy[buf] = 0; 
      		return pNewBuf;
    	}
    }else{                                                   
    	if ((call RouteSelect.selectDescendantRoute(pMsg,id, 0, 0)) != SUCCESS) {
      		FwdBufBusy[buf] = 0;                             
      		return pNewBuf;
	    }
    }
 
    
    
    //if (call AMSend.send[id](pMsg->addr,pMsg->length,pMsg) == SUCCESS) {
   if (call SendMsg.send[id](pMsg, call Packet.payloadLength(pMsg)) == SUCCESS)
   {
    
      pNewBuf = FwdBufList[buf];
      FwdBufList[buf] = pMsg;
    }else{
      FwdBufBusy[buf] = 0;
    }
    
    return pNewBuf;
    
  }
*/
  
   command message_t * SendDownStreamMsg(message_t * pMsg){
       message_t * pTmp;
//	uint16_t PayloadLen = pMsg->length - offsetof(TOS_MHopMsg,data);
   uint8_t		PayloadLen = call Packet.payloadLength(pMsg);

       uint8_t id = call AMPacket.type(pMsg); //pMsg->type;
       pTmp = mForward(pMsg,id, 1);
       return pTmp;
   }

  
    event message_t * ReceiveDownstreamMsg.receive[uint8_t id](message_t * pMsg, void *payload, uint8_t len) {
       TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)pMsg->data;
       //uint16_t PayloadLen = pMsg->length - offsetof(TOS_MHopMsg,data);
       uint8_t	PayloadLen = call Packet.payloadLength(pMsg)  - offsetof(TOS_MHopMsg,data);
       //if(pMHMsg->originaddr == TOS_LOCAL_ADDRESS){
       if(pMHMsg->originaddr == call AMPacket.address()){
           //if(pMsg->type == 248 || pMsg->type == 249) {
           if (call AMPacket.type(pMsg) ==248 ||  call AMPacket.type(pMsg)  == 249) {
              ReceivePowerMsg(pMsg, pMHMsg->data, sizeof(pMHMsg->data));
           }
           pMsg = signal ReceiveDataMsg.receive[id](pMsg, pMHMsg->data, sizeof(pMHMsg->data));
           signal Snoop.forward[id](pMsg,&pMHMsg->data[0],PayloadLen);
       
	   }else if (call AMPacket.destination(pMsg) == call AMPacket.address() || call AMPacket.destination(pMsg) == TOS_BCAST_ADDR){
           pMsg = mForward(pMsg,id, 1);
       } else {
           
           signal Snoop.forward[id](pMsg,&pMHMsg->data[0],PayloadLen);
       }
       return pMsg;
   }

  event message_t *ReceiveMsg.receive[uint8_t id](message_t * pMsg, void *payload, uint8_t len) {
    TOS_MHopMsg		*pMHMsg = (TOS_MHopMsg *)pMsg->data;
   // uint16_t		PayloadLen = pMsg->length - offsetof(TOS_MHopMsg,data);
   uint8_t		PayloadLen = call Packet.payloadLength(pMsg) - offsetof(TOS_MHopMsg,data);

      ADBG(1, "Engine ReceiveMsg.receive payloadlen=%d", ADBG_N(PayloadLen));

	
    if (call AMPacket.destination(pMsg) == call AMPacket.address()) { 
      ADBG(1, "for me");
      if ((signal Intercept.forward[id](pMsg,&pMHMsg->data[0],PayloadLen)) == TRUE) {
        pMsg = mForward(pMsg,id, 0);
      }
    }
    else {
      ADBG(1, "not for me snoop forward");
      signal Snoop.forward[id](pMsg,&pMHMsg->data[0],PayloadLen);
    }

      ADBG(1, "\r\n");

    return pMsg;
  }

  
  uint8_t fail_count = 0;  
  event void SendMsg.sendDone[uint8_t id](message_t * pMsg, error_t success) {
    uint8_t downstream = 0;
    //int8_t buf = is_ours(pMsg);

    ADBG(1, "Engine AMSend.sendDone\r\n");
       
    /*
    if (buf != -1) { 
        if(FwdBufBusy[buf] == 2) downstream = 1;
    }
    */

//  if(pMsg->ack == 0 && call AMPacket.destination(pMsg) != TOS_BCAST_ADDR && call AMPacket.destination(pMsg) != TOS_UART_ADDR && fail_count < 8){
    if (success != SUCCESS 
    && call AMPacket.destination(pMsg) != TOS_BCAST_ADDR 
    && call AMPacket.destination(pMsg) != TOS_UART_ADDR 
    && fail_count < SEND_FAIL_RETRY_MAX) {
        ADBG(1, "\r\nsend to somebody fail.");
        
        call RouteSelect.forwardFailed();

        if(downstream){
            call RouteSelect.selectDescendantRoute(pMsg,id, 1, 0);
        }else{
            call RouteSelect.selectRoute(pMsg,id, 1, 0);
        }
        if (call SendMsg.send[id](pMsg, call Packet.payloadLength(pMsg)) == SUCCESS)
        {
            fail_count ++;
            return;
        }
	 
 //    } else if(pMsg->ack == 0 && call AMPacket.destination(pMsg) != TOS_BCAST_ADDR && call AMPacket.destination(pMsg) != TOS_UART_ADDR && downstream){	
    } 
    else if (success != SUCCESS 
    && call AMPacket.destination(pMsg) != TOS_BCAST_ADDR 
    && call AMPacket.destination(pMsg) != TOS_UART_ADDR 
    && downstream)
    {
        ADBG(1, "\r\nselectDescendantRoute.");
        call RouteSelect.selectDescendantRoute(pMsg,id, 1, 0);
        call AMPacket.setDestination(pMsg, TOS_BCAST_ADDR);
        if (call SendMsg.send[id](pMsg, call Packet.payloadLength(pMsg)) == SUCCESS) {
               return;
        }
    }
     
    fail_count = 0;

    /*
    if (buf != -1) { 
        FwdBufBusy[buf] = 0;
    } else {
        signal Send.sendDone[id](pMsg, success);
    } 
    */

    
    signal Send.sendDone[id](pMsg, success);

    return;
  }

  command uint16_t RouteControl.getParent() {
    return call RouteSelectCntl.getParent();
  }

  command uint8_t RouteControl.getQuality() {
    return call RouteSelectCntl.getQuality();
  }

  command uint8_t RouteControl.getDepth() {
    return call RouteSelectCntl.getDepth();
  }

  command uint8_t RouteControl.getOccupancy() {
    uint16_t uiOutstanding = (uint16_t)iFwdBufTail - (uint16_t)iFwdBufHead;
    uiOutstanding %= FWD_QUEUE_SIZE;
    return (uint8_t)uiOutstanding;
  }
/*
  command uint16_t RouteControl.getSender(message_t * msg) {
    TOS_MHopMsg	 *pMHMsg = (TOS_MHopMsg *)msg->data;
    return pMHMsg->sourceaddr;
  }
*/
  command error_t RouteControl.setUpdateInterval(uint16_t Interval) {
    return call RouteSelectCntl.setUpdateInterval(Interval);
  }

  command error_t RouteControl.manualUpdate() {
    return call RouteSelectCntl.manualUpdate();
  }

  default event void  MultiHopForward(message_t * pMsg){
 }

/***** TO DO:  ***/
  command void * ReceiveDataMsg.getPayload[uint8_t id](message_t *pMsg, uint8_t *len)
  {
  	return NULL;
  }

   command uint8_t ReceiveDataMsg.payloadLength[uint8_t id](message_t *pMsg)
  {
  	return 20;
  }
  command void * Receive.getPayload[uint8_t id](message_t *pMsg, uint8_t *len)
  {
  	return NULL;
  }

   command uint8_t Receive.payloadLength[uint8_t id](message_t *pMsg)
  {
  	return 20;
  }
/***** TO DO:  ***/

  default event message_t * ReceiveDataMsg.receive[uint8_t id](message_t * pMsg, void* payload, uint8_t payloadLen) {
     return pMsg;
  }

  default event void Send.sendDone[uint8_t id](message_t * pMsg, error_t success) {
    //return SUCCESS;
  }

  default event bool Intercept.forward[uint8_t id](message_t * pMsg, void* payload, 
							 uint16_t payloadLen) {
    return TRUE;
  }

  default event bool Snoop.forward[uint8_t id](message_t * pMsg, void* payload, 
                                                     uint16_t payloadLen) {
    return TRUE;
  }

}
