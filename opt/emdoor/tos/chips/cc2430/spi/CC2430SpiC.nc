configuration CC2430SpiC {
  provides interface SpiByte;
  provides interface SpiPacket;
  provides interface SpiControl;
}
implementation {
  components CC2430SpiP as SpiMaster, HplCC2430SpiC as HplSpi;
  
  SpiControl = SpiMaster;
  SpiByte = SpiMaster;
  SpiPacket = SpiMaster;

  SpiMaster.Spi -> HplSpi;
}
