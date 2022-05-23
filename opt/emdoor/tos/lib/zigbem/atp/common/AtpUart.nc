
interface AtpUart
{
	command error_t sendData(uint8_t *buf, uint16_t len);
	
	event void receivedByte(uint8_t byte);
}

