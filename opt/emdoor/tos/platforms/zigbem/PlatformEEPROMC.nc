
configuration PlatformEEPROMC
{
	provides interface EEPROM<uint8_t> as EEPROM_2Kb;  /* 2Kbit ROM */
}
implementation
{
	components new EEPROMC(uint8_t, 0x50, 2*1024/8);  /* 0x50, is the I2C address of AT24C02 */
	EEPROM_2Kb = EEPROMC;
}

