
interface CoreControlOwner {
	command error_t setBusy(uint8_t flag);
	command void setFree(uint8_t flag);
}

