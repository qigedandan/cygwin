

module HplCC2430ClockControlP {
  provides interface CC2430ClockControl;
} implementation {

  async command void set32kClkSourceRC (bool s) {
    CLKCON = s ? (CLKCON & _BV(CC2430_CLKCON_OSC32K))
    CLKCON |= _BV(CC2430_CLKCON_OSC32K);
}
  async command bool get32kClkSourceRC () {}

  async command void setSysClkSourceRC (bool s) {}
  async command bool getSysClkSourceRC () {}

  async command void setSysFreq16MHz (bool s) {}
  async command bool getSysFreq16MHz () {}

  async command void setSysClockDiv (bool d) {}
  async command bool getSysClockDiv () {}
  
}
