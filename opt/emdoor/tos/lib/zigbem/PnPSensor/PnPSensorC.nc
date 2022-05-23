
configuration PnPSensorC
{
	provides interface PnPSensor;
}
implementation
{
	components PnPSensorP;
	PnPSensor = PnPSensorP;

	components PlatformEEPROMC;
	PnPSensorP.EEPROM -> PlatformEEPROMC.EEPROM_2Kb;
}

