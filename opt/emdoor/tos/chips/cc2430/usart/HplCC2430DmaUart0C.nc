#include "uart.h"

configuration HplCC2430DmaUart0C
{
  provides interface StdControl as UartStdControl;
  provides interface UartStream;
  provides interface CC2430UartControl;
}
implementation
{
  components HplCC2430DmaUartP;
  components new HplCC2430DmaC(4) as DmaC;
  components new HalCC2430SimpleDmaUartC(UART_BAUDRATE);

  UartStdControl = HplCC2430DmaUartP;
  UartStream = HplCC2430DmaUartP;
  CC2430UartControl = HalCC2430SimpleDmaUartC;

  HplCC2430DmaUartP.uart0StdControl -> HalCC2430SimpleDmaUartC;
  HplCC2430DmaUartP.uart0 -> HalCC2430SimpleDmaUartC;
  HplCC2430DmaUartP.CC2430Dma -> DmaC.CC2430Dma;
  
}
