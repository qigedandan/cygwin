

configuration ActiveMessageC {
  provides {
    interface SplitControl;

    interface AMSend[uint8_t id];
    interface Receive[uint8_t id];
    interface Receive as Snoop[uint8_t id];

    interface Packet;
    interface AMPacket;
    interface PacketAcknowledgements;
  }
}
implementation {

#ifdef CC2420_STACK
  components CC2420ActiveMessageC as AM;
#else
  components CC2430ActiveMessageC as AM;
#endif
  
  SplitControl = AM;
  
  AMSend       = AM;
  Receive      = AM.Receive;
  Snoop        = AM.Snoop;
  Packet       = AM;
  AMPacket     = AM;
  PacketAcknowledgements = AM;
}
