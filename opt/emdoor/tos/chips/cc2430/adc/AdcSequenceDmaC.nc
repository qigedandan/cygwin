

generic configuration AdcSequenceDmaC() {
  provides interface AdcControl;
  provides interface StdControl as PortControl0;
  provides interface Read<int16_t> as Read0;
  provides interface StdControl as PortControl1;
  provides interface Read<int16_t> as Read1;
  provides interface StdControl as PortControl2;
  provides interface Read<int16_t> as Read2;
  provides interface StdControl as PortControl3;
  provides interface Read<int16_t> as Read3;
  provides interface StdControl as PortControl4;
  provides interface Read<int16_t> as Read4;
  provides interface StdControl as PortControl5;
  provides interface Read<int16_t> as Read5;
  provides interface StdControl as PortControl6;
  provides interface Read<int16_t> as Read6;
  provides interface StdControl as PortControl7;
  provides interface Read<int16_t> as Read7;
}

implementation {
  components MainC, AdcSequenceDmaP;
  MainC.SoftwareInit -> AdcSequenceDmaP.Init;

  AdcControl = AdcSequenceDmaP;
  Read0 = AdcSequenceDmaP.Read[0];
  Read1 = AdcSequenceDmaP.Read[1];
  Read2 = AdcSequenceDmaP.Read[2];
  Read3 = AdcSequenceDmaP.Read[3];
  Read4 = AdcSequenceDmaP.Read[4];
  Read5 = AdcSequenceDmaP.Read[5];
  Read6 = AdcSequenceDmaP.Read[6];
  Read7 = AdcSequenceDmaP.Read[7];
  PortControl0 = AdcSequenceDmaP.PortControl[0];
  PortControl1 = AdcSequenceDmaP.PortControl[1];
  PortControl2 = AdcSequenceDmaP.PortControl[2];
  PortControl3 = AdcSequenceDmaP.PortControl[3];
  PortControl4 = AdcSequenceDmaP.PortControl[4];
  PortControl5 = AdcSequenceDmaP.PortControl[5];
  PortControl6 = AdcSequenceDmaP.PortControl[6];
  PortControl7 = AdcSequenceDmaP.PortControl[7];
  
  components StdNullC as StdOutC;
  AdcSequenceDmaP.StdOut -> StdOutC;
  
  components new DmaC() as Dma1;
  AdcSequenceDmaP.Dma1 -> Dma1;

  components new DmaC() as Dma2;
  AdcSequenceDmaP.Dma2 -> Dma2;
}
