interface SpiPacket {
	async command error_t send(uint8_t len,uint8_t *value);
	event void sendDone(error_t result);
}
