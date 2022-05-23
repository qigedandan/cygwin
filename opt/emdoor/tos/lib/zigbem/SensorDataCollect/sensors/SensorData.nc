
interface SensorData
{
	command error_t read(uint8_t* p_value);
	event void readDone(uint8_t* p_value, uint8_t length, error_t result);
}

