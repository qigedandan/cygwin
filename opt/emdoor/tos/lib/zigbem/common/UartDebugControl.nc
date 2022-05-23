
interface UartDebugControl {
	command error_t setLevelInput(bool enabled);
	
	event void levelChanged(int new_level);
}

