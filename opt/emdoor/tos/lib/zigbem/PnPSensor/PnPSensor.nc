
#include "PnPSensor.h"

interface PnPSensor
{
	command error_t writeConfig(pnpsensor_config_t *config);
	command error_t readConfig(pnpsensor_config_t *config);

	event void writeConfigDone(pnpsensor_config_t *config, error_t error);
	event void readConfigDone(pnpsensor_config_t *config, error_t error);
}

