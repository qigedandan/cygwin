interface SpiByte {
	async command void write( uint8_t tx );
	async command uint8_t read();
}
