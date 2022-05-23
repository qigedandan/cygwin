/**
 * @ xxl
 */
 #define DBG_LEV 20
#include "message.h"
module testCollectionC{
	uses{
		interface Boot;
		interface Send;
		interface Receive;
		interface Packet;
		interface AMPacket;
		interface SplitControl;
		interface StdControl;
		interface RootControl;
	#ifdef CC2420_LQI
		interface RouteControl;
	#endif
		interface Timer<TMilli>;
		interface CollectionPacket;
		interface Random;
	}
}
implementation{
	message_t* msgPtr;
	message_t msg;
	uint8_t counter;

	task void SendTask() {
		uint8_t* packet = (uint8_t*)call Packet.getPayload(msgPtr,0);
		packet[0] = counter;
		ADBG(DBG_LEV,"sendTask!\r\n");
		call Send.send(msgPtr, 1);
		
	}
	event void Boot.booted() {
		ADBG(DBG_LEV,"###### Boot.booted #######\r\n");
		counter =0;
		msgPtr = &msg;
		if( TOS_NODE_ID == 1){
			call RootControl.setRoot();
			// call LowPowerListening.setLocalSleepInterval(500);
		}else{
			// call LowPowerListening.setLocalSleepInterval(500);
		}
	#ifdef CC2420_LQI
		call RouteControl.setUpdateInterval(4);
	#endif
		call StdControl.start();
		call SplitControl.start(); 		
	}

	event void SplitControl.startDone(error_t err) {
		call Timer.startOneShot(call Random.rand16()%10000);
	}
	event void SplitControl.stopDone(error_t err) {
	}
	event void Timer.fired() {
		//ADBG(15, "\r\n###################\r\n");
		//ADBG(15, "the radioDutyCycle is:%d, the radioStartCount is:%d, the radioStop is:%d\r\n",(int)radioDutyCycle,(int)radioStartCount, (int)radioStopCount);
		//ADBG(15,"#####################\r\n");
		
		radioDutyCycle = 0;
		radioStartCount = 0;
		radioStopCount = 0;
		
		counter++; 
		/* if(! call RootControl.isRoot()){ && call RouteControl.getParent() != TOS_BCAST_ADDR) {			
			//call LowPowerListening.setLocalSleepInterval(500+500*(call RouteControl.getDepth()-1));
		} */
		if(! call RootControl.isRoot()){
			post SendTask();
		}
		
		call Timer.startOneShot(10000);
	}
	event void Send.sendDone(message_t* m_msg, error_t err){
		if(err == SUCCESS) {
			ADBG(DBG_LEV,"sendDone SUCCESS!\r\n");
		}
	}
	event message_t* Receive.receive(message_t* m_msg, void* payload, uint8_t len) {
		uint8_t* packet = (uint8_t*)payload;
		ADBG(DBG_LEV,"received Packet %d from node %d, forwarded from node %d \r\n", (int)*packet, (int) call CollectionPacket.getOrigin(m_msg), (int)call AMPacket.source(m_msg) );
	}
}
