
module OSAMainP
{
	provides interface Boot;
	provides interface OSAMain;
	provides interface OSAMainControl;

	uses interface RealTimer<TMilli, uint32_t>;
	uses interface Scheduler;
	uses interface Init as PlatformInit;
	uses interface Init as SoftwareInit;
}
implementation
{
	task void doRunUsrApp()
	{/*FIXME: it's necessary to post a new task??*/
	

		ADBG(1, "doRunUsrApp 1\n");
		
		signal OSAMainControl.beforeUsrAppRun(SUCCESS);
		ADBG(1, "doRunUsrApp 2\n");	
		atomic {			
			call RealTimer.setTime(0x00000000);  /* Set global time to 0 before user app run */
		ADBG(1, "doRunUsrApp 3\n");
			call PlatformInit.init();
			ADBG(1, "doRunUsrApp 4\n");

			while (call Scheduler.runNextTask());
			ADBG(1, "doRunUsrApp 5\n");

			call SoftwareInit.init(); 
			ADBG(1, "doRunUsrApp 6\n");

			while (call Scheduler.runNextTask());
			ADBG(1, "doRunUsrApp 7\n");

		}

		/* Enable interrupts now that system is ready. */
		__nesc_enable_interrupt();
		ADBG(1, "doRunUsrApp 8\n");

		signal Boot.booted();
		ADBG(1, "doRunUsrApp 9\n");

		signal OSAMainControl.afterUsrAppRun(SUCCESS);
		ADBG(1, "doRunUsrApp 10\n");

	}
	command error_t OSAMain.runUsrApp()
	{
		/* because this method will be call from the user app? so we post a new task for some performance issue */
		post doRunUsrApp();

		return SUCCESS;
	}

	task void doEndUsrApp()
	{
		signal OSAMainControl.beforeUsrAppEnd(SUCCESS);
		
		signal OSAMainControl.afterUsrAppEnd(SUCCESS);
	}
	
	command error_t OSAMain.endUsrApp()
	{
		/* because this method will be call from the user app? so we post a new task for some performance issue */
		post doEndUsrApp();

		return SUCCESS;
	}

	default command error_t PlatformInit.init() { return SUCCESS; }
	default command error_t SoftwareInit.init() { return SUCCESS; }
	default event void Boot.booted() { }


	default event void OSAMainControl.beforeUsrAppRun(error_t error) {}
	default event void OSAMainControl.afterUsrAppRun(error_t error) {}
	
	default event void OSAMainControl.beforeUsrAppEnd(error_t error) {}
	default event void OSAMainControl.afterUsrAppEnd(error_t error) {}
}


