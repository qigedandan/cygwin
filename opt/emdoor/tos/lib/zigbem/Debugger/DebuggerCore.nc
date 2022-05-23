
interface DebuggerCore
{
	command bool process(char *cmd);
	event void debugOutput(char *msg);
}

