#include "uart.h"

generic configuration HalCC2430SimpleDmaUartC(uint32_t baudrate)  {
  provides interface StdControl as uart0StdControl;
  provides interface SerialByteComm as uart0;
  provides interface CC2430UartControl;
}
implementation {

  components new HalCC2430SimpleDmaUartP(baudrate);

  HalCC2430SimpleDmaUartP.uart0StdControl = uart0StdControl;
  HalCC2430SimpleDmaUartP.uart0 = uart0;
  CC2430UartControl = HalCC2430SimpleDmaUartP;
}
