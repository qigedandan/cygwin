

generic module RealTimerP()
{
	provides interface RealTimer<TMilli, uint32_t>;
	uses interface Counter<TMilli, uint32_t>;
}
implementation
{
	norace uint32_t time_init_value = 0;

	uint32_t getRealTime()
	{
		uint32_t counter_value = call Counter.get();

		if (counter_value >= time_init_value)
		{
			return counter_value - time_init_value;
		}
		else
		{
			return counter_value + ( (~(uint32_t)0) - time_init_value);
		}
	}
	
	command uint32_t RealTimer.getTime()
	{
		return getRealTime();
	}
	
	command void RealTimer.setTime(uint32_t time)
	{
		uint32_t counter_value = call Counter.get();
		atomic
		{
			time_init_value = counter_value - time - 1;  /* will be elapsed in 1 tick */
		}
	}

	async event void Counter.overflow()
	{
	}
}

