

configuration HalCC2430RadioDmaC
{
  provides interface HALCC2420;
  provides interface StdControl as HALCC2420Control;

}
implementation
{
  components MainC, HalCC2430RadioDmaP;
  MainC.SoftwareInit -> HalCC2430RadioDmaP.Init;

  HALCC2420 = HalCC2430RadioDmaP.HALCC2420;
  HALCC2420Control = HalCC2430RadioDmaP.HALCC2420Control;

  components HplCC2430InterruptsC;
  HalCC2430RadioDmaP.InterruptTXDone -> HplCC2430InterruptsC.InterruptTXDone;
  HalCC2430RadioDmaP.InterruptRFErr -> HplCC2430InterruptsC.InterruptRFErr;

  components new DmaC() as DmaSend;
  HalCC2430RadioDmaP.DmaSend -> DmaSend;
  
  components new DmaC() as DmaReceive;
  HalCC2430RadioDmaP.DmaReceive -> DmaReceive;

  components DEBUG_STDOUTC;
  HalCC2430RadioDmaP.StdOut -> DEBUG_STDOUTC;
}
