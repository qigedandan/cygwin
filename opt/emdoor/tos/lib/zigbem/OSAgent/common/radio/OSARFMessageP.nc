#include "OSARF.h"

module OSARFMessageP
{
	provides interface Init;
	provides interface StdControl;

	uses interface Init as SubInit;
	uses interface StdControl as SubControl;
}
implementation
{
	command error_t Init.init()
	{
		return call SubInit.init();
	}

	command error_t StdControl.start()
	{
		return call SubControl.start();
	}

	command error_t StdControl.stop()
	{
		return call SubControl.stop();
	}
}



