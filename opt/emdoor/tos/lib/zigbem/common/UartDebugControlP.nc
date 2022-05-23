

module UartDebugControlP
{
	provides interface UartDebugControl;
	uses interface UartInput;
}
implementation
{
	norace int m_input_level = ADBG_LEVEL;
	bool m_level_input = FALSE;
	


	task void inputDebugLevel()
	{
		if (m_level_input)
		{
			call UartInput.scanf("%d", &m_input_level);
		}
	}

	
	command error_t UartDebugControl.setLevelInput(bool enabled)
	{
		m_level_input = enabled;
		post inputDebugLevel();
	}
	
	
	event void UartInput.scanfDone(void *value, error_t error)
	{
		if (error == SUCCESS)
		{
			uart_debug_level = m_input_level;
			signal UartDebugControl.levelChanged(uart_debug_level);
		}

		post inputDebugLevel();
	}
	
	default event void UartDebugControl.levelChanged(int new_level)
	{
	}
	

}

