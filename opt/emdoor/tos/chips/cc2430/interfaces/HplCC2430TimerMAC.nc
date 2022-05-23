

#include <CC2430Timer.h>

interface HplCC2430TimerMAC {

  /** 
   * Set the timer mode
   */
  async command void setMode( enum cc2430_timerMAC_mode_t mode );

  /** 
   * Get the timer mode
   * @return timer mode
   */
  async command enum cc2430_timerMAC_mode_t getMode();

  /** 
   * Get the current adjustment (delta) counter
   * @return current delta
   */
  async command uint16_t getAdjust();

  /** 
   * Set the current adjustment (delta) counter
   * @param d   the time to set
   */
  async command void setAdjust ( uint16_t d );

  /** 
   * Get the current 20 bit overflow count
   * @return Current overflow count (only 20 valid bits)
   */
  async command uint32_t getOverflow();

  /** 
   * Set the current 20 bit overflow count
   * @param o Set the current overflow count (bits above 20 will be ignored)
   */
  async command void setOverflow ( uint32_t o );

  /* 
   *
   */
  async command void setSyncStop();
  async command void clrSyncStop();

  /* 
   * Enable or disable events of this timer:
   *   Cmp       Compare interrupt
   *   Overflow  Overflow interrupt
   *   OvfCmp    Overflow count compare interrupt
   */
  async command void enableCmpEvents();
  async command void disableCcmEvents();

  async command void enableOverflowEvent();
  async command void disableOverflowEvent();

  async command void enableOvfCmpEvent();
  async command void disableOvfCmpEvent();


  /*
   * Check/clear the interrupt status flag corresponding to the mask
   * from the enum cc2430_timer1_if
   *
   * @param if_mask Mask to check/clear bit in T1CTL
   */

  async command bool isIfPending(enum cc2430_timerMAC_if_t if_mask);
  async command void clearIf(enum cc2430_timerMAC_if_t if_mask);

  /** 
   * The timer has fired - the reasen must be checked separately
   *
   */
  async event void fired();

}
