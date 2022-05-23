
interface DebuggerHandler
{
	command bool process(char *cmd);
	event char *getDebugBuf();
	event void debugOutput(char *msg);
}

