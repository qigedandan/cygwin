interface Leds {

  /**
   * Turn on LED 0. The color of this LED depends on the platform.
   */
  async command void RedLedOn();

  /**
   * Turn off LED 0. The color of this LED depends on the platform.
   */
  async command void RedLedOff();

  /**
   * Toggle LED 0; if it was off, turn it on, if was on, turn it off.
   * The color of this LED depends on the platform.
   */
  async command void RedLedToggle();

  /**
   * Turn on LED 1. The color of this LED depends on the platform.
   */
  async command void BlueLedOn();

  /**
   * Turn off LED 1. The color of this LED depends on the platform.
   */
  async command void BlueLedOff();

   /**
   * Toggle LED 1; if it was off, turn it on, if was on, turn it off.
   * The color of this LED depends on the platform.
   */
  async command void BlueLedToggle();

  /**
   * Turn on LED 1. The color of this LED depends on the platform.
   */
  async command void YellowLedOn();

  /**
   * Turn off LED 1. The color of this LED depends on the platform.
   */
  async command void YellowLedOff();

   /**
   * Toggle LED 1; if it was off, turn it on, if was on, turn it off.
   * The color of this LED depends on the platform.
   */
  async command void YellowLedToggle();
  
  
  
  #ifdef USE_BOARD_LED 
  /**
   * Turn on LED 2. The color of this LED depends on the platform.
   */
  async command void GreenLedOn();

  /**
   * Turn off LED 2. The color of this LED depends on the platform.
   */
  async command void GreenLedOff();

   /**
   * Toggle LED 2; if it was off, turn it on, if was on, turn it off.
   * The color of this LED depends on the platform.
   */
  async command void GreenLedToggle();
  #endif
}
