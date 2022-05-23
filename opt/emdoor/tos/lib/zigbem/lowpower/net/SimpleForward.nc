
interface SimpleForward {

	command error_t forward(message_t *msg, uint8_t len);
	command uint16_t getNextAddress();
	
}

