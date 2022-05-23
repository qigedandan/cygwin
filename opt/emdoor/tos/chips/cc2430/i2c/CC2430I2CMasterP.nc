

//#include "CC2430I2C.h"
#include "I2C.h"

module CC2430I2CMasterP {
  provides interface I2CPacket<TI2CBasicAddr> as I2CPacket;
  uses interface HplCC2430I2CBus as I2CBus;
}
implementation {
	async command error_t I2CPacket.read(i2c_flags_t flags, uint16_t addr, uint8_t length, uint8_t* data)
	{
		call I2CBus.read(addr,length,data);
	}
	async command error_t I2CPacket.write(i2c_flags_t flags, uint16_t addr, uint8_t length, uint8_t* data)
	{
		call I2CBus.write(addr,length,data);
	}
	
	async event void I2CBus.readDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data)
	{
		signal I2CPacket.readDone(error,addr,length,data);
	}
	
	async event void I2CBus.writeDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data)
	{
		signal I2CPacket.writeDone(error,addr,length,data);
	}

}
