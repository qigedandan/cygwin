
generic configuration HplCC2430I2CBusC()
{
  provides interface HplCC2430I2CBus as I2C;
}
implementation {

  components HplGeneralIOC as IO;
  components HplCC2430I2CBusP as Bus;
  
  I2C = Bus.I2C;

  Bus.I2CClk  -> IO.PIN[1];
  Bus.I2CData -> IO.PIN[0];
  
  //Bus.I2CClk  -> IO.P01;
  //Bus.I2CData -> IO.P00;

  //Bus.I2CClk  -> IO.PIN[clk_pin];
  //Bus.I2CData  -> IO.PIN[data_pin];
}
