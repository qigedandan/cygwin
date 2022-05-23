

#include "CC2420.h"

#include "ActiveMessageResource.h"

configuration CC2430ActiveMessageC {
  provides {
    interface SplitControl;
    interface AMSend[am_id_t id];
    interface Receive[am_id_t id];
    interface Receive as Snoop[am_id_t id];
    interface AMPacket;
    interface Packet;
    interface CC2420Packet;
    interface PacketAcknowledgements;

    /* Resource  */
    //interface ActiveMessageResource[uint8_t id];
  }
}
implementation {

  components CC2430ActiveMessageP as AM;
  //components CC2420CsmaC as Radio;
  //components ActiveMessageAddressC as Address;
  components CC2430TransmitC as Transmit;

  //components HalCC2430RadioC;
  
  //SplitControl = Radio;
  SplitControl = Transmit;
  Packet       = AM;

  AMSend   = AM;
  Receive  = AM.Receive;
  Snoop    = AM.Snoop;
  AMPacket = AM;
  
  AM.SubSend    -> Transmit.Send;
  AM.SubReceive -> Transmit.Receive;
  AM.amAddress -> Transmit;
  //Radio.AMPacket -> AM;

  //AM.HALCC2420Control -> HalCC2430RadioC.HALCC2420Control;
  //AM.HALCC2420 -> HalCC2430RadioC.HALCC2420;
  

  components CC2420PacketC;
  CC2420Packet = CC2420PacketC;
  PacketAcknowledgements = CC2420PacketC;



  /*ActiveMessageResource = AM;
  components MainC;
  components new FcfsResourceQueueC(uniqueCount(AMRESOURCE_ID));
  AM.FcfsQueue -> FcfsResourceQueueC;
  MainC.SoftwareInit -> FcfsResourceQueueC;
  */
}

