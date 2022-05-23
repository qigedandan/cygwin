

#include <CC2430Timer.h>

interface HplCC2430TimerSleep {

  /*
   * Enable/disable interrupts (only in timer mode)
   */
  async command void enableEvents();
  async command void disableEvents();

  /** 
   * Set the 24 bit compare value 
   * @param c (only lower 24 bits are used)
   */
  async command void setCompare( uint32_t c );

  /** 
   * Get the current time.
   * @return  the current time (only 24 bit are valid)
   */
  async command uint32_t get();


  /** 
   * A timer compare event has occured.
   * 
   */
  async event void fired();

}
