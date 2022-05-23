

configuration HalCC2430RadioC
{
  provides interface HALCC2420;
  provides interface StdControl as HALCC2420Control;
}
implementation
{
  components MainC;
  components HalCC2430RadioP;
  MainC.SoftwareInit -> HalCC2430RadioP;

  components HplCC2430InterruptsC;
  HalCC2430RadioP.InterruptTXDone -> HplCC2430InterruptsC.InterruptTXDone;
  HalCC2430RadioP.InterruptFIFOP -> HplCC2430InterruptsC.InterruptFIFOP;
  HalCC2430RadioP.InterruptRFErr -> HplCC2430InterruptsC.InterruptRFErr;
  HalCC2430RadioP.CaptureSFD -> HplCC2430InterruptsC.CaptureSFD;

  components LedsC;
  HalCC2430RadioP.Leds -> LedsC;

  HALCC2420 = HalCC2430RadioP.HALCC2420;
  HALCC2420Control = HalCC2430RadioP.HALCC2420Control;

}
