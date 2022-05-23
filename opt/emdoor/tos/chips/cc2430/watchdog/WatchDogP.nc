
module WatchDogP
{
	provides interface WatchDog;
}
implementation
{
	command void WatchDog.resetCpu()
	{/* We'are about to reset the CC2430 throught the WatchDog guy */
		atomic {
			WDCTL = 0x0B;  /* reset the CPU in the smallest period */
		}
	}
	
	command void WatchDog.enable()
	{
		atomic {
			WDCTL = 0x08;
		}
	}

	command void WatchDog.disable()
	{
		atomic {
			WDCTL &= ~0x08;
		}
	}

	command void WatchDog.tickle()
	{
		atomic {
			WDCTL = 0xa8;
			WDCTL = 0x58;
		}
		ADBG(900,"\r\nWatchDog.tickle()\r\n");
	}
	

}

