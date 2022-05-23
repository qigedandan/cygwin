
interface ActiveMessageResource {
	command error_t request();
	event void granted(bool success);
}

