

#include <io8051.h>
#include <ioCC2430.h>

module HplMcs51GeneralIOC {
  provides interface GeneralIO as P00;
  provides interface GeneralIO as P01;
  provides interface GeneralIO as P02;
  provides interface GeneralIO as P03;
  provides interface GeneralIO as P04;
  provides interface GeneralIO as P05;
  provides interface GeneralIO as P06;
  provides interface GeneralIO as P07;

  provides interface GeneralIO as P10;
  provides interface GeneralIO as P11;
  provides interface GeneralIO as P12;
  provides interface GeneralIO as P13;
  provides interface GeneralIO as P14;
  provides interface GeneralIO as P15;
  provides interface GeneralIO as P16;
  provides interface GeneralIO as P17;
}
implementation {
#define MAKE_NEW_PIN(name, pin, pin_dir, pin_dir_bit) \
  inline async command bool name.get()        { return ( pin != 0); } \
  inline async command void name.set()        { pin = 1; } \
  inline async command void name.clr()        { pin = 0; } \
  async command void        name.toggle()     { atomic { pin = ~pin; } } \
  inline async command bool name.isInput()    { IS_IO_PIN_INPUT(pin_dir, pin_dir_bit); } \
  inline async command bool name.isOutput()   { IS_IO_PIN_OUTPUT(pin_dir, pin_dir_bit); } \
  inline async command void name.makeInput()  { MAKE_IO_PIN_INPUT (pin_dir, pin_dir_bit); } \
  inline async command void name.makeOutput() { MAKE_IO_PIN_OUTPUT(pin_dir, pin_dir_bit); }

  // The syntax for defining the sbit (bit accessible registers) is
  // compiler specfic, but the usage should be compiler independant

  MAKE_NEW_PIN(P00, P0_0, P0_DIR, 0);
  MAKE_NEW_PIN(P01, P0_1, P0_DIR, 1);
  MAKE_NEW_PIN(P02, P0_2, P0_DIR, 2);
  MAKE_NEW_PIN(P03, P0_3, P0_DIR, 3);
  MAKE_NEW_PIN(P04, P0_4, P0_DIR, 4);
  MAKE_NEW_PIN(P05, P0_5, P0_DIR, 5);
  MAKE_NEW_PIN(P06, P0_6, P0_DIR, 6);
  MAKE_NEW_PIN(P07, P0_7, P0_DIR, 7);

  MAKE_NEW_PIN(P10, P1_0, P1_DIR, 0);
  MAKE_NEW_PIN(P11, P1_1, P1_DIR, 1);
  MAKE_NEW_PIN(P12, P1_2, P1_DIR, 2);
  MAKE_NEW_PIN(P13, P1_3, P1_DIR, 3);
  MAKE_NEW_PIN(P14, P1_4, P1_DIR, 4);
  MAKE_NEW_PIN(P15, P1_5, P1_DIR, 5);
  MAKE_NEW_PIN(P16, P1_6, P1_DIR, 6);
  MAKE_NEW_PIN(P17, P1_7, P1_DIR, 7);
}
