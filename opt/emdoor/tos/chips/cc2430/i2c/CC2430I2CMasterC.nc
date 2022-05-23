
#include "I2C.h"

generic configuration CC2430I2CMasterC()
{
  provides interface I2CPacket<TI2CBasicAddr> as I2CPacket;
}
implementation {

  components CC2430I2CMasterP;
  components new HplCC2430I2CBusC();
  
  I2CPacket	= CC2430I2CMasterP.I2CPacket;
  CC2430I2CMasterP.I2CBus -> HplCC2430I2CBusC.I2C;
}
