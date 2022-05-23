
module PnPSensorP
{
	provides interface PnPSensor;
	uses interface EEPROM<uint8_t>;
}
implementation
{
	enum
	{
		PNPSENSOR_CONFIG_NONE,
		PNPSENSOR_CONFIG_READ,
		PNPSENSOR_CONFIG_WRITE,
	};

	uint8_t m_state = PNPSENSOR_CONFIG_NONE;
	pnpsensor_config_t *m_config = NULL;

	command error_t PnPSensor.writeConfig(pnpsensor_config_t *config)
	{
		atomic {
			if (m_state == PNPSENSOR_CONFIG_READ  || m_state == PNPSENSOR_CONFIG_WRITE)
			{
				return EBUSY;
			}
			m_state = PNPSENSOR_CONFIG_WRITE;
			m_config = config;
		}
		
		return call EEPROM.write(PNPSENSOR_CONFIG_EEPROM_ADDR, (uint8_t *)config, sizeof(pnpsensor_config_t));
	}
	
	command error_t PnPSensor.readConfig(pnpsensor_config_t *config)
	{
		atomic {
			if (m_state == PNPSENSOR_CONFIG_READ  || m_state == PNPSENSOR_CONFIG_WRITE)
			{
				return EBUSY;
			}
			m_state = PNPSENSOR_CONFIG_READ;
			m_config = config;
		}
		

		return call EEPROM.read(PNPSENSOR_CONFIG_EEPROM_ADDR, (uint8_t *)config, sizeof(pnpsensor_config_t));
	}

	event void EEPROM.writeDone(error_t error, uint8_t addr, uint8_t *data, uint8_t len)
	{
		if (m_state == PNPSENSOR_CONFIG_WRITE)
		{
			atomic m_state = PNPSENSOR_CONFIG_NONE;
			signal PnPSensor.writeConfigDone(m_config, error);
		}
	}

	event void EEPROM.readDone(error_t error, uint8_t addr, uint8_t *data, uint8_t len)
	{
		if (m_state == PNPSENSOR_CONFIG_READ)
		{
			atomic m_state = PNPSENSOR_CONFIG_NONE;
			signal PnPSensor.readConfigDone(m_config, error);
		}
	}


	default event void PnPSensor.writeConfigDone(pnpsensor_config_t *config, error_t error) {}
	default event void PnPSensor.readConfigDone(pnpsensor_config_t *config, error_t error) {}

}

