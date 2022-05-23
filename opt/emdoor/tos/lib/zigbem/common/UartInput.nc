
interface UartInput {
	command error_t scanf(char *format, void *value);
	event void scanfDone(void *value, error_t error);
}

