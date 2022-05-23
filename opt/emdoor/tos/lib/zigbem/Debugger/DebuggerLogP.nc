
#include "DebuggerLog.h"

module DebuggerLogP
{
	provides interface DebuggerHandler;
}
implementation
{
	task void doProcess()
	{
		uint8_t i;
		
		/* print step information */
		DBGER_OUT("\r\n\r\n\r\n>>>>LOG information====\r\n");

		for (i=0; i < DBGER_LOG_SIZE; ++i)
		{
			DBGER_OUT("[LOG %d] (%s)\r\n", (int)i, log_value[i]);
		}
		
		DBGER_OUT("<<<<LOG information====\r\n");
	}

	command bool DebuggerHandler.process(char *cmd)
	{
		if (*cmd == 'l')
		{
			post doProcess();
			return TRUE;
		}

		return FALSE;
	}

	default event char *DebuggerHandler.getDebugBuf()
	{
		return NULL;
	}
	
	default event void DebuggerHandler.debugOutput(char *cmd)
	{
	}
}


