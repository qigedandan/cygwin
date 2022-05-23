configuration CC2430TransmitC
{
  provides interface SplitControl;
  provides interface Send;
  provides interface Receive;

  provides command am_addr_t amAddress();
}
implementation
{
  components CC2430TransmitP;
  components HalCC2430RadioC;

  SplitControl = CC2430TransmitP;
  Send = CC2430TransmitP.Send;
  Receive = CC2430TransmitP.Receive;
  amAddress = CC2430TransmitP.amAddress;

  CC2430TransmitP.HALCC2420 -> HalCC2430RadioC;
  CC2430TransmitP.HALCC2420Control -> HalCC2430RadioC;


  components new TimerMilliC() as AckTimer;
  CC2430TransmitP.AckTimer -> AckTimer;

  components new TimerMilliC() as BackoffTimer;
  CC2430TransmitP.BackoffTimer -> BackoffTimer;
  
  
  components RandomLfsrC as RandomC;
  components MainC;
  MainC.SoftwareInit -> RandomC;

  CC2430TransmitP.Random -> RandomC;

  
  
}
