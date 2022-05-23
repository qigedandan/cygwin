
module UartDebuggerP
{
	provides interface Init;

	uses interface AtpUart;
	uses interface StdControl as AtpUartControl;
	
	uses interface DebuggerCore;
}
implementation
{
	char m_receive_code[2] = "";

	command error_t Init.init()
	{
		return call AtpUartControl.start();
	}

	event void AtpUart.receivedByte(uint8_t byte)
	{/* only one code support now... */
		m_receive_code[0] = byte;
		m_receive_code[1] = '\0';
		
		call DebuggerCore.process(m_receive_code);
	}

	event void DebuggerCore.debugOutput(char *msg)
	{
		//call AtpUart.sendData(msg, strlen(msg));
		ADBG(50000, msg);
	}	
	
}

