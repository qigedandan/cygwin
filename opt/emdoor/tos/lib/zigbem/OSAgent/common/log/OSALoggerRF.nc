
interface OSALoggerRF
{
	command error_t addLog(uint8_t type, uint16_t src, uint16_t dest, uint16_t packet_size);

	/* log with less information, but in the normal case, it's enough */
	command error_t addSmallLog(uint8_t type, uint8_t src, uint8_t dest, uint8_t packet_size);
}

