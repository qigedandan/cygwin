

configuration PlatformC
{
  provides interface Init;
  provides interface WatchDog;
}
implementation
{
  components PlatformLedsC;
  components PlatformP, HplCC2430GeneralIOC;

  Init = PlatformP;
  PlatformP.GIOInit -> HplCC2430GeneralIOC.Init;

  #ifdef ZIGBEM
  components WsnC;
  PlatformP.WsnInit -> WsnC;
  #endif

  #ifndef NO_FLASHIEEE
  components FlashIEEEC;
  PlatformP.FlashIEEEInit -> FlashIEEEC;
  PlatformP.FlashIEEE-> FlashIEEEC;
  #endif

  components WatchDogC;
  WatchDog = WatchDogC;

}
