

generic configuration EEPROMC(typedef address_size_type @integer(), uint8_t i2c_addr, uint16_t size)
{
	provides interface EEPROM<address_size_type>;
}
implementation
{
	components new EEPROMP(address_size_type, i2c_addr, size);
	EEPROM = EEPROMP;

	components new CC2430I2CMasterC();
	EEPROMP.I2C -> CC2430I2CMasterC.I2CPacket ;
}

