/* Place all CC2430 Interrupt here... For OSAgent Design  */

interface PlatformInterrupt
{
	command void setIntRFtoUser();
	command void setIntRFtoOSA();
	
	command void setIntUARTtoUser();
	command void setIntUARTtoOSA();

	command void setIntTimertoUser();
	command void setIntTimertoOSA();
	
	command bool isIntTimerToUser();
	command bool isIntTimerToOSA();
}


