

#include <CC2430Timer.h>

interface HplCC2430Timer8 {

  /** 
   * Get the current time.
   * @return  the current time
   */
  async command uint8_t get();

  /** 
   * Set the current time.
   * @param t     the time to set
   */
  async command void set( uint8_t t );

  /** 
   * Set the timer mode
   */
  async command void setMode( enum cc2430_timer3_4_mode_t mode );

  /** 
   * Get the timer mode
   * @return timer mode
   */
  async command enum cc2430_timer3_4_mode_t getMode();

  /* 
   * Set the T1IE flag to enable/disable interrupts altogether:
   * capture, compare and overflow. Remember to set the overflow
   * interrupt mask as well if overflow interrupts are desired.
   *
   */
  async command void enableEvents();
  async command void disableEvents();


  /* 
   * Enable/disable the timer. The timer is stopped until this command
   * called (set/clr T3|4CTL.START)
   */
  async command void enable();
  async command void disable();

  /* 
   * Set/clear the overflow interrupt enable flag T1CLT.OVFIM.  No
   * interrupts will be generated on overflow unless this flag is set.
   */
  async command void enableOverflow();
  async command void disableOverflow();

  /*
   *corresponding to the mask
   * from the enum cc2430_timer34_if
   *
   * @param if_mask Mask to check/clear bit
   */

  async command bool isIfPending(enum cc2430_timer34_if_t if_mask);
  async command void clearIf(enum cc2430_timer34_if_t if_mask);


  /* 
   *  Check/clear interrupt status flags. These are single instruction
   *  variants of isIfPending/clearIf (the registers are bit
   *  addressable and these operations can be implemented with a
   *  single instruction).
   *
   *  The enum types for a single pending/clear command would not work
   *  as well for T3 and T4 since they use different bit masks to for
   *  the same interrupt flags - meaning we would need two interfaces
   *  (or parametric).
   *
   */

  async command bool isOVFIFending();
  async command void clearOVFIF();

  async command bool isCH0IFPending();
  async command void clearCH0IF();

  async command bool isCH1IFPending();
  async command void clearCH1IF();

  /** 
   * Set the prescaler (clock divider) according to the predefined
   * division values. See CC2430Timer.h.
   *
   * @param scale One of 4 predefined prescaler settings.
   */
  async command void setScale( enum cc2430_timer3_4_prescaler_t);

  /** 
   * Get prescaler setting.
   * @return  Prescaler setting of clock -- see Atm128Timer.h
   */
  async command enum cc2430_timer3_4_prescaler_t getScale();

  /** 
   * The timer has fired - the type of 
   * @return  Prescaler setting of clock -- see Atm128Timer.h
   */
  async event void fired();

}
