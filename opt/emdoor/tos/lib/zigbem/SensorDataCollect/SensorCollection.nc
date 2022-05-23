#include "Sensor.h"

interface SensorCollection
{
	command error_t startSensor(uint8_t* data, sensor_id_t sensor);
	event void sensorDone(uint8_t* data, uint8_t len, error_t result);
}
