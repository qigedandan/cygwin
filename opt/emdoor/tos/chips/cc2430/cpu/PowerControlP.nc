

module PowerControlP
{
	provides interface PowerControl;

	uses interface McuSleepControl;
}
implementation
{
	task void doSleep()
	{
		call McuSleepControl.sleep(0);
		/*
		SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | CC2430_SLEEP_POWERMODE_2;
           
		__nesc_enable_interrupt();

		PCON = 0x01; //do sleep
		*/
	}

	command error_t PowerControl.sleep()
	{
		post doSleep();
		return SUCCESS;
	}

	event void McuSleepControl.beforeSleep()
	{
	}

	event void McuSleepControl.afterWakeup()
	{
		
	}
}

