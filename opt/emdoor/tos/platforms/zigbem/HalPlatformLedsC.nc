

configuration HalPlatformLedsC
{
  provides interface HalMcs51Led as Led1;
  provides interface HalMcs51Led as Led3;
}
implementation
{
  components HplMcs51GeneralIOC,
    OSA_MainC as MainC,
    new Halcc2430emLedPinP() as Led1_in,
    new Halcc2430emLedPinP() as Led3_in;

  Led1_in.Led_pin -> HplMcs51GeneralIOC.P10;
  Led3_in.Led_pin -> HplMcs51GeneralIOC.P13;

  Led1 = Led1_in;
  Led3 = Led3_in;

  MainC.SoftwareInit -> Led1_in.Init;
  MainC.SoftwareInit -> Led3_in.Init;

}
