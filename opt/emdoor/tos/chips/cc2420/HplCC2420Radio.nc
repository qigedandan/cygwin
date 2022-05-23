

interface HplCC2420Radio
{
	command void reset();
	
	command void radioOn();
	command void radioOff();
	
	command void rxOn();
	command void rxOff();

	
	command void oscOn();
	command void oscOff();
}

