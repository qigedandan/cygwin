configuration HplCC2430SpiC {
    provides interface CC2430Spi as SpiBus;
}
implementation
{
  components HplCC2430GeneralIOC as IO, HplCC2430SpiP as HplSpi;
  SpiBus = HplSpi;

  HplSpi.SS   -> IO.P14;  // Slave set line
  HplSpi.SCK  -> IO.P15;  // SPI clock line
  HplSpi.MOSI -> IO.P16;  // Master out, slave in
  HplSpi.MISO -> IO.P17;  // Master in, slave out
}
