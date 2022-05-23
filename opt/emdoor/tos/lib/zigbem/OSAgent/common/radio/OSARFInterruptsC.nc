

configuration OSARFInterruptsC
{
  provides interface GpioCapture as CaptureSFD;
  provides interface GpioInterrupt as InterruptCCA;
  provides interface GpioInterrupt as InterruptFIFOP;
  provides interface GpioInterrupt as InterruptTXDone;
  provides interface GpioInterrupt as InterruptRFErr;
}

implementation
{
  components OSARFInterruptsP;  
  
  CaptureSFD = OSARFInterruptsP.CaptureSFD;
  InterruptCCA = OSARFInterruptsP.InterruptCCA;
  InterruptFIFOP = OSARFInterruptsP.InterruptFIFOP;
  InterruptTXDone = OSARFInterruptsP.InterruptTXDone;
  InterruptRFErr = OSARFInterruptsP.InterruptRFErr;

  components PlatformInterruptC;
  OSARFInterruptsP.IntRF -> PlatformInterruptC.IntRFOSA;
}


