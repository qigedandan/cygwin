interface McuSleepLock
{
    /* Disable sleep */
    command void lock();

    
    /* Enable sleep */
    command void unlock();
}

