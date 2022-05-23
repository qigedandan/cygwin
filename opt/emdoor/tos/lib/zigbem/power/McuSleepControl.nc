interface McuSleepControl
{
    //sleep us
    command error_t sleep(uint32_t ms);


    event void beforeSleep();

    event void afterWakeup();
}

