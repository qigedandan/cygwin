

generic configuration AdcC() {
  provides interface AdcControl;
  provides interface Read<int16_t>;
}

implementation {
  components MainC, AdcP;
  MainC.SoftwareInit -> AdcP.Init;

  enum { ID = unique("UNIQUE_ADC_PORT"), };

  AdcControl = AdcP.AdcControl[ID];
  Read = AdcP.Read[ID];
}
