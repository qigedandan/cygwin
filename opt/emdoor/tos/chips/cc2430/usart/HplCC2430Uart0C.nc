#include "uart.h"

configuration HplCC2430Uart0C
{
  provides interface StdControl as UartStdControl;
  provides interface UartStream;
  provides interface CC2430UartControl;
}
implementation
{
  components HplCC2430UartP, new HalCC2430SimpleUartC(UART_BAUDRATE);

  UartStdControl = HplCC2430UartP;
  UartStream = HplCC2430UartP;
  CC2430UartControl = HalCC2430SimpleUartC;

  HplCC2430UartP.uart0StdControl -> HalCC2430SimpleUartC;
  HplCC2430UartP.uart0 -> HalCC2430SimpleUartC;
  
}
