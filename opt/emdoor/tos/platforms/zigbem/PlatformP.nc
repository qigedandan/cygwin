
#include <Timer.h>
#include <CC2430Timer.h>

module PlatformP { 
  provides interface Init;
  uses interface Init as LedsInit;
  uses interface Init as GIOInit;
  #ifdef ZIGBEM
  uses interface Init as WsnInit;
  #endif

   #ifndef NO_FLASHIEE
   uses interface Init as FlashIEEEInit;
   uses interface FlashIEEE;
   #endif
}
implementation {
  command error_t Init.init() {
    uint8_t new_clkcon;

    SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | CC2430_SLEEP_POWERMODE_0; 

    // Power up all oscilators (Must be cleared when toggling CLKCON.OSC)
    // See section 13.10.3
    SLEEP  &= ~_BV(CC2430_SLEEP_OSC_PD);
    while (!(SLEEP & _BV(CC2430_SLEEP_XOSC_STB))); // Wait for XOSC powered up and stable

    new_clkcon = 0x0;
    /* Timer ticks divder = 1 */
    //new_clkcon = (new_clkcon & ~CC2430_CLKCON_TICKSPD_MASK) | CC2430_TICKF_DIV_1;
	/* Timer ticks divder = 8 */
    new_clkcon = (new_clkcon & ~CC2430_CLKCON_TICKSPD_MASK) | CC2430_TICKF_DIV_8;

    // Select 32768Hz oscilator source (crystal or internal)
    new_clkcon &= ~_BV(CC2430_CLKCON_OSC32K); // crystal

    /* Select system clock source = 32 MHz crystal*/
    /* If the osc. is not powered up and stable this powers it up and the switch takes effect
     * when the crystal is stable       
     */
    //new_clkcon |= _BV(CC2430_CLKCON_OSC); // 16 MHz CPU
    new_clkcon &= ~_BV(CC2430_CLKCON_OSC); // 32 MHz CPU

    //new_clkcon |= _BV(CC2430_CLKCON_TICKSPD);

    CLKCON = new_clkcon;


    #ifdef UART_DEBUG
    uartDebugInit();
    #endif
    
    
    call LedsInit.init();
   
    #ifdef ZIGBEM
    call WsnInit.init();
    #else
        #ifndef NO_FLASHIEEE
        call FlashIEEEInit.init();
        call FlashIEEE.WriteToRegister();
        call FlashIEEE.WriteToAM();
        #endif  /* NO_FLASHIEEE */
    #endif /* ZIGBEM */
    
    return SUCCESS;
  }

  default command error_t LedsInit.init() { return SUCCESS; }
}
