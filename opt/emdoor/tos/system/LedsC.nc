/*************************************************
*	FUNCTION NAME : LedC.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

configuration LedsC {
  provides interface Leds;
}
implementation {
  components LedsP, PlatformLedsC;

  Leds = LedsP;

  LedsP.Init <- PlatformLedsC.Init;
  LedsP.RedLed -> PlatformLedsC.RedLed;
  LedsP.BlueLed -> PlatformLedsC.BlueLed;
  LedsP.YellowLed -> PlatformLedsC.YellowLed;
#ifdef USE_BOARD_LED  
  LedsP.BoardRedLed -> PlatformLedsC.BoardRedLed;
  LedsP.BoardBlueLed -> PlatformLedsC.BoardBlueLed;
  LedsP.BoardGreenLed -> PlatformLedsC.BoardGreenLed;
  LedsP.BoardYellowLed -> PlatformLedsC.BoardYellowLed;
#endif
  
}

