#include "Debugger.h"

module DebuggerLevelP
{
	provides interface DebuggerHandler;
	
	uses interface UartInput;
}
implementation
{
	norace int m_input_level = ADBG_LEVEL;

	task void doProcess()
	{
		call UartInput.scanf("%d", &m_input_level);
	}

	command bool DebuggerHandler.process(char *cmd)
	{
		if (*cmd == 'v')
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

	event void UartInput.scanfDone(void *value, error_t error)
	{
		if (error == SUCCESS)
		{
			uart_debug_level = m_input_level;
		}
	}
}

