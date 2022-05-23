configuration PlatformSerialC
{
  provides interface StdControl as UartStdControl;
  provides interface UartStream;
  provides interface CC2430UartControl;
}
implementation
{
  #ifdef NO_DMA_UART
  components HplCC2430Uart0C as SerialC;
  #else
  components HplCC2430DmaUart0C as SerialC;
  #endif

  UartStdControl = SerialC;
  UartStream = SerialC;
  CC2430UartControl = SerialC;
}
