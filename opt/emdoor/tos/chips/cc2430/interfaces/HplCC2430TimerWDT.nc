

#include <CC2430Timer.h>

interface HplCC2430TimerWDT {

  /* 
   * Enable the WDT, once enabled it cannot be disabled
   */
  async command void enable();

  /** 
   * Set the timer mode. Once the timer is enabled in WDT mode the
   * timer cannot be disabled or swithed to timer mde.
   *
   * @param mode
   */
  async command void setMode( enum cc2430_timerWDT_mode_t mode );

  /** 
   * Enable/disable timer
   *
   */
  async command void enable();
  async command void disable();
  
  /*
   * Enable/disable interrupts (only in timer mode)
   */
  async command void enableEvents();
  async command void disableEvents();

  /** 
   * Clear WDT interval (in WDT mode) or clear counter (in timer mode)
   * This could technically be one instruction shorter in timer mode,
   * buy hey - thie is simpler.
   *
   */
  async command void clear();

  /** 
   * Set the the interval between clear sequence requirements
   * @param i 
   */
  async command void setInterval( enum cc2430_timerMAC_interval_t i );
  async command enum cc2430_timerMAC_interval_t getInterval();

  /** 
   * The timer interval expired. NOTE: in WDT mode no interrupt is
   * generated.
   * 
   */
  async event void fired();

}
