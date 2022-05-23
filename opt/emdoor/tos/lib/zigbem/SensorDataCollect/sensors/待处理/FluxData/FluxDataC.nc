#include "Sensor.h"

configuration FluxDataC
{
	provides interface SensorData;
}
implementation
{
	components FluxDataP;
	components new CaptureSensorC(FLUX_TIMEOUT) as FluxSensorC;

	SensorData = FluxDataP;
	FluxDataP.FluxSensor -> FluxSensorC;
}
