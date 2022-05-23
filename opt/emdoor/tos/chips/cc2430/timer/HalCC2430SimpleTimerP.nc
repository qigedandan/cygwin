

module HalCC2430SimpleTimerP {
  provides interface Init;
  provides interface Timer<TMilli> as Timer1;
}
implementation {

  command error_t Init.init() {

#define XOSC_STABLE (SLEEP & 0x40)
#define TICKSPD ((CLKCON & 0x38) >> 3)

   // Enabling overflow interrupt from timer 1

    /* int_timer.c

    SET_MAIN_CLOCK_SOURCE(CRYSTAL);
    TIMER1_INIT();
    timer1Period = halSetTimer1Period(800);
   if(timer1Period != 0)
   {
      TIMER1_ENABLE_OVERFLOW_INT(TRUE);
      INT_ENABLE(INUM_T1, INT_ON);
      TIMER1_RUN(TRUE);
   }
    */

    //SET_MAIN_CLOCK_SOURCE(CRYSTAL);
    //CLKCON=0; // Hat!?

    SLEEP &= ~0x04;
    while(!XOSC_STABLE);
    CLKCON &= ~0x47;
    SLEEP |= 0x04;

   /*TIMER1_INIT: */
      T1CTL  = 0x00;    
      T1CCTL0 = 0x00;   
      T1CCTL1 = 0x00;   
      T1CCTL2 = 0x00;   
      TIMIF &= ~0x40;   

   /*halSetTimer1Period Beregner Preescaler og priode
      Fup: perod=0 =>       div = 3;     period = 0x0000FFFF;
  */

      T1CTL = ((T1CTL&~0x0c) | (3/*div*/ << 2)); // Setting prescaler division value
      T1CC0L = 0xFFFF; /*(BYTE)(period);              // Setting counter value*/
      T1CC0H = 0x0000; /*(BYTE)(period >> 8);*/

      /* TIMER1_ENABLE_OVERFLOW_INT(true)*/
      TIMIF |=  0x40; // OVFIM

      /*INT_ENABLE(INUM_T1, INT_ON);*/
      T1IE    = 1;  

      /*  TIMER1_RUN(TRUE); */
      T1CTL |= 0x02;

      /*
    T1CTL =  3<<2 | 1; // Prescaler=128 | Mode=free running
    T1IE = 1;  // Set interrupt mask
    IEN1 = 0xFF; // Set the lot...

    OVFIM = 1; // Set overflow interrupt enable flag
    TIMIF = 0xFF; // Generate lots of int's...
      */

    return SUCCESS;
  }

  //event void Timer1.fired();
  command void Timer1.startPeriodicAt(uint32_t t0, uint32_t dt) {}
  command void Timer1.startOneShotAt(uint32_t t0, uint32_t dt) {}
  command void Timer1.startPeriodic(uint32_t dt) {}
  command void Timer1.startOneShot(uint32_t dt) {}
  command void Timer1.stop() {}
  command bool Timer1.isRunning() {}
  command bool Timer1.isOneShot() {}
  command uint32_t Timer1.getNow() {}
  command uint32_t Timer1.gett0() {}
  command uint32_t Timer1.getdt() {}

  MCS51_INTERRUPT(SIG_T1) {
    signal Timer1.fired();
  }
}
