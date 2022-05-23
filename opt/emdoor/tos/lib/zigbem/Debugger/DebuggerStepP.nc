
#include "DebuggerStep.h"

module DebuggerStepP
{
	provides interface DebuggerHandler;
}
implementation
{
	task void doProcess()
	{
		uint8_t i;
		
		/* print step information */
		DBGER_OUT("\r\n\r\n\r\n>>>>STEP information====\r\n");

		for (i=0; i < DBGER_STEP_SIZE; ++i)
		{
			DBGER_OUT("[STEP %d] V=%d\r\n", (int)i, (int)step_value[i]);
		}
		
		DBGER_OUT("<<<<STEP information====\r\n");
	}

	command bool DebuggerHandler.process(char *cmd)
	{
		if (*cmd == 's')
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


