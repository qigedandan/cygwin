
module OSAUsrAppP
{
	provides interface OSAUsrApp;

	uses interface PlatformInterrupt;
}
implementation
{
	command error_t OSAUsrApp.setAsOSA()
	{
		ADBG(6, "OSAUsrApp.setAsOSA\n");
		call PlatformInterrupt.setIntRFtoOSA();
		call PlatformInterrupt.setIntUARTtoOSA();
		call PlatformInterrupt.setIntTimertoOSA();
		
		return SUCCESS;
	}

	
	command error_t OSAUsrApp.setAsUsrApp()
	{
		ADBG(6, "OSAUsrApp.setAsUsrApp\n");
		call PlatformInterrupt.setIntRFtoUser();
		call PlatformInterrupt.setIntUARTtoUser();
		call PlatformInterrupt.setIntTimertoUser();
		return SUCCESS;
	}

	
	command error_t OSAUsrApp.clearUsrApp()
	{
		
		call OSAUsrApp.setAsOSA();

		/* TODO, add Timer and Alarm recycle process...  */

		
		return SUCCESS;
	}
}

