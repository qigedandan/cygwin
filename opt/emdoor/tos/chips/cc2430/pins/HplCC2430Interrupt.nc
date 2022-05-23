

interface HplCC2430Interrupt
{

  async command void P0_edge(bool low_to_high);
  // PICTL.P0ICON
  async command void P1_edge(bool low_to_high);
  // PICTL.P1ICON
  async command void P2_edge(bool low_to_high);
  // PICTL.P2ICON

  command void disable_P0(); // Disable interrupts from entire P0
  // IEN1.P0IE 

  command void disable_P0_0_3(); // Disable interrupts from pin 0-3 of P0
  // PICTL.POIENH

  command void disable_P0_3_7(); // Disable interrupts from pin 3-7 of P0
  // PICTL.POIENL

  command void disable_P1(); // Disable interrupts from entire P1
  // IEN2.P1IE 

  // Bellow P1IEN.0-7
  command void disable_P1_0(); // Disable interrupts from pin 0 of P1
  command void disable_P1_1(); // Disable interrupts from pin 1 of P1
  command void disable_P1_2(); // Disable interrupts from pin 2 of P1
  command void disable_P1_3(); // Disable interrupts from pin 3 of P1
  command void disable_P1_4(); // Disable interrupts from pin 4 of P1
  command void disable_P1_5(); // Disable interrupts from pin 5 of P1
  command void disable_P1_6(); // Disable interrupts from pin 6 of P1
  command void disable_P1_7(); // Disable interrupts from pin 7 of P1

  command void disable_P2(); // Disable interrupts from entire P2
  // IEN2.P2IE
  command void disable_P2_0_3(); // Disable interrupts from pin 0-4 of P2
  // PICT.P2IEN

  /**
   * Signalled when any of the pins of P0 triggers an interrupt
   */
  async event void P0_fired();
  // Signal: IRCON2.P0IF

  /**
   * Signalled when any of the pins of P0 triggers an interrupt
   */
  async event void P1_fired();
  // Signal: IRCON2.P1IF

  /**
   * Signalled when any of the pins of P0 triggers an interrupt
   */
  async event void P2_fired();
  // Signal: IRCON2.P2IF
}
