
module DebuggerCoreP
{
	provides interface DebuggerCore;
	uses interface DebuggerHandler;
}
implementation
{
	char m_debug_buf[256];

	command bool DebuggerCore.process(char *cmd)
	{
		return call DebuggerHandler.process(cmd);
	}
	

	event char *DebuggerHandler.getDebugBuf()
	{
		return m_debug_buf;
	}
	
	event void DebuggerHandler.debugOutput(char *msg)
	{
		signal DebuggerCore.debugOutput(msg);
	}
	
}

