
interface EEPROM<address_size_type>
{
	command address_size_type getMaxAddress();
	command error_t write(address_size_type addr, uint8_t *data, address_size_type len);
	command error_t read(address_size_type addr, uint8_t *data, address_size_type len);

	event void writeDone(error_t error, address_size_type addr, uint8_t *data, address_size_type len);
	event void readDone(error_t error, address_size_type addr, uint8_t *data, address_size_type len);
}

