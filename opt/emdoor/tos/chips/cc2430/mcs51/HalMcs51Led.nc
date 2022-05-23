

interface HalMcs51Led {
  async command void on();
  async command void off();
  async command void toggle();
}
