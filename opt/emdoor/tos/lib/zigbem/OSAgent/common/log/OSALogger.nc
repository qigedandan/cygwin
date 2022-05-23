

interface OSALogger
{
	command error_t clear();
	command int32_t count();
	command int32_t maxCount();
	
	command bool canStore(int32_t len);

	command int32_t readPosition();

	command uint8_t * get(int32_t *len);
	
	command error_t write(uint8_t *data, int32_t len);
	command int32_t read(uint8_t *data, int32_t len);
	command error_t seek(int32_t offset, int start_pos);
}

