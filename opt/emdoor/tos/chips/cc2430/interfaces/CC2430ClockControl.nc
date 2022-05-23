

interface CC2430ClockControl {

  /*
   * Get/set the 32.768 kHz clock source CLKCON.OSC32K
   *
   * @param s Source (true (1) 32.768 kHz RC osc., false (0) 32.768 kHz crystal osc.)
   */
  async command void set32kClkSourceRC() {}
  async command void set32kClkSourceCrystal() {}
  async command bool get32kClkSourceRC () {}


  /*
   * Get/set the system clock source CLKCON.OSC
   *
   * @param s Source true (1) = 16 MHz RC oscilator, false (0) 32 MHz crystal osc.
   */
  async command void setSysClkSourceRC () {}
  async command void setSysClkSourceCrystal () {}
  async command bool getSysClkSourceRC () {}


  /* 
   * set/get system clock frequency CLCKCON.CLKSPD
   *
   * @param s speed (true (1) 16 MHz, false (0) 32 Mhz)
   */

  async command void setSysFreq16MHz () {}
  async command void setSysFreq32MHz () {}
  async command bool getSysFreq16MHz () {}
  /* 
   * set/get system clock frequency divider value CLKCON.TICKSPD
   *
   * @param 
   */

  async command void setSysClockDiv (uint8_t d) {}
  async command uint8_t getSysClockDiv () {}

}
