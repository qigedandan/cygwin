

includes MultiHop;

configuration EWMAMultiHopRouter {
  
  provides {
    interface Init;
    interface StdControl;
    // The interface are as parameterised by the active message id
	// only the 10 active message ids defined MultiHop.h are supported.
    interface Receive[uint8_t id];
    interface Intercept as Intercept[uint8_t id];
    interface Intercept as Snoop[uint8_t id];
    interface Send[uint8_t id];
    interface RouteControl;

  }

  uses {
    interface SplitControl as AMControl;
    interface AMSend[uint8_t id];
    interface AMPacket;
    interface Packet;
    //interface ReceiveMsg[uint8_t id];
    interface Receive as ReceiveMsg[uint8_t id];
    //interface ReceiveMsg as ReceiveDownstreamMsg[uint8_t id];
    interface Receive as ReceiveDownstreamMsg[uint8_t id];
    interface Timer<TMilli> as RouterTimer;
    interface CC2420Packet;
  }
}

implementation {
  
  // Uncomment for use with mh6
  components 
  	MultiHopEngineM,
  	MultiHopEWMA

#ifdef USE_WATCHDOG
	WDTC,
#endif

	;

  components QueuedTransmitC;
  QueuedTransmitC.AMSend = AMSend;
  QueuedTransmitC.AMPacket = AMPacket;
  QueuedTransmitC.Packet = Packet;
  QueuedTransmitC.SubReceive = ReceiveMsg;

  

  StdControl = MultiHopEngineM;
  Receive = MultiHopEngineM.ReceiveDataMsg;
  Send = MultiHopEngineM;
  Intercept = MultiHopEngineM.Intercept;
  Snoop = MultiHopEngineM.Snoop;
  RouteControl = MultiHopEngineM;
  Init = MultiHopEngineM.Init;

  MultiHopEngineM.ReceiveDownstreamMsg = ReceiveDownstreamMsg;  
  MultiHopEngineM.AMPacket = AMPacket;
  MultiHopEngineM.Packet = Packet;
 

  MultiHopEngineM.AMControl = AMControl;

  MultiHopEngineM.SubInit -> QueuedTransmitC.Init;
  MultiHopEngineM.SubInit -> MultiHopEWMA.Init;
  
  MultiHopEngineM.SubControl -> MultiHopEWMA.StdControl;

  MultiHopEngineM.RouteSelectCntl -> MultiHopEWMA.RouteControl;
  MultiHopEngineM.RouteSelect -> MultiHopEWMA;

  MultiHopEngineM.ReceiveMsg -> QueuedTransmitC.Receive;
  MultiHopEngineM.SendMsg -> QueuedTransmitC.Send;

  //MultiHopEngineM.Timer -> Timer2;
  
  //MultiHopEWMA.Timer -> TimerC.Timer[unique("Timer")];
  MultiHopEWMA.Timer = RouterTimer;

  //MultiHopEWMA.ReceiveMsg -> Comm.ReceiveMsg[AM_MULTIHOPMSG];
  
  
  MultiHopEWMA.Snoop -> MultiHopEngineM.Snoop;
  
  //MultiHopEWMA.SendMsg -> QueuedSend.SendMsg[AM_MULTIHOPMSG];
  MultiHopEWMA.SendMsg -> QueuedTransmitC.Send[AM_MULTIHOPMSG];
  MultiHopEWMA.Receive -> QueuedTransmitC.Receive[AM_MULTIHOPMSG];

  
  MultiHopEWMA.AMPacket = AMPacket;
  MultiHopEWMA.Packet = Packet;
  MultiHopEWMA.CC2420Packet = CC2420Packet;
  
  MultiHopEWMA.DebugSendMsg -> MultiHopEngineM.Send[AM_DEBUGPACKET];

  components LedsC;
  MultiHopEWMA.Leds ->LedsC;

  
}
