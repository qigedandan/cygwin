

module HplMcs51InterruptP {
  provides interface HplMcs51Interrupt as ext_int_0;
  provides interface HplMcs51Interrupt as ext_int_1;
}
implementation {
  // EX0 ~ IE.0   Sets the interrupt mask
  // PX0 ~ IP.0   Selects 1/0 priority level
  // IT0 ~ TCON.0 Sets edge/level trigered
  // IE0 ~ TCON.1 Interupt detected flag
  // IE1 ~ TCON.3 Interupt detected flag
  inline async command void ext_int_0.enable()  { EX0 = 1; }
  inline async command void ext_int_0.disable() { EX0 = 0; }
  inline async command void ext_int_0.clear()   { IE0 = 0; }
  inline async command void ext_int_0.priority(bool pri) { PX0 = pri ? 1 : 0;}
  inline async command void ext_int_0.edge_trig(bool edge) { IT0 = edge ? 1 : 0; }

  default async event void ext_int_0.fired() { }
  MCS51_INTERRUPT(SIG_INTERRUPT0) {
    signal ext_int_0.fired();
  }


  inline async command void ext_int_1.enable()  { EX0 = 1; }
  inline async command void ext_int_1.disable() { EX0 = 0; }
  inline async command void ext_int_1.clear()   { IE0 = 0; }
  inline async command void ext_int_1.priority(bool pri) { PX0 = pri ? 1 : 0;}
  inline async command void ext_int_1.edge_trig(bool edge) { IT0 = edge ? 1 : 0; }

  default async event void ext_int_1.fired() { }
  MCS51_INTERRUPT(SIG_INTERRUPT1) {
    signal ext_int_1.fired();
  }
}
