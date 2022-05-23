

generic configuration HplCC2430DmaC(uint8_t DmaChannel) {
  provides interface CC2430Dma;
}

implementation {
  components MainC, HplCC2430DmaP;
  MainC.SoftwareInit -> HplCC2430DmaP.Init;

//  enum { ID = unique("UNIQUE_DMA_CHANNEL"), };

  CC2430Dma = HplCC2430DmaP.CC2430Dma[DmaChannel];
}
