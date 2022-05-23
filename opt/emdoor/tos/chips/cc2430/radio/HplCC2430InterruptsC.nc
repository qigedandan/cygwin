

configuration HplCC2430InterruptsC
{
  provides interface GpioCapture as CaptureSFD;
  provides interface GpioInterrupt as InterruptCCA;
  provides interface GpioInterrupt as InterruptFIFOP;
  provides interface GpioInterrupt as InterruptTXDone;
  provides interface GpioInterrupt as InterruptRFErr;
}

implementation
{
  components HplCC2430InterruptsP;  
  
  CaptureSFD = HplCC2430InterruptsP.CaptureSFD;
  InterruptCCA = HplCC2430InterruptsP.InterruptCCA;
  InterruptFIFOP = HplCC2430InterruptsP.InterruptFIFOP;
  InterruptTXDone = HplCC2430InterruptsP.InterruptTXDone;
  InterruptRFErr = HplCC2430InterruptsP.InterruptRFErr;

  components PlatformInterruptC;
  HplCC2430InterruptsP.IntRF -> PlatformInterruptC.IntRFUser;
}


