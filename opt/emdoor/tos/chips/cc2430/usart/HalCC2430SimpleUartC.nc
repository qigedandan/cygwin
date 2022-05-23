#include "Uart.h"

generic configuration HalCC2430SimpleUartC(uint32_t baudrate)  {
  provides interface StdControl as uart0StdControl;
  provides interface SerialByteComm as uart0;
  provides interface CC2430UartControl;
}
implementation {

  components new HalCC2430SimpleUartP(baudrate);

  HalCC2430SimpleUartP.uart0StdControl = uart0StdControl;
  HalCC2430SimpleUartP.uart0 = uart0;
  CC2430UartControl = HalCC2430SimpleUartP;
}
