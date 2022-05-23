

generic configuration AdcDmaC() {
  provides interface AdcControl;
  provides interface Read<int16_t>;
}

implementation {
  components MainC, AdcDmaP;
  MainC.SoftwareInit -> AdcDmaP.Init;

  enum { ID = unique("UNIQUE_ADC_PORT"), };

  AdcControl = AdcDmaP.AdcControl[ID];
  Read = AdcDmaP.Read[ID];
  
  
  components new DmaC();
  AdcDmaP.Dma -> DmaC;
}
