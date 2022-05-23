

interface SleepNodeCoreControl {
	command bool isBusy();
	
	event void busy();
	event void free();
}

