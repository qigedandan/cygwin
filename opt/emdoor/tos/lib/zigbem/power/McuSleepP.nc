#include <CC2430Timer.h>

module McuSleepP
{
    provides interface McuSleep;
    provides interface McuSleepControl;
    
    uses interface McuSleepLockMan;
}
implementation
{
    uint32_t m_sleep_ms = 0x000000;
    bool m_need_sleep = FALSE;

    #define CAN_SLEEP   (m_need_sleep &&  ( !call McuSleepLockMan.isLocked()))
    
    command error_t McuSleepControl.sleep(uint32_t ms)
    {
        atomic
        {
            m_sleep_ms = ms;
            m_need_sleep = TRUE;
        }
    }


    async command void McuSleep.sleep()
    {
        //ADBG(1, "McuSleep.sleep\n");

        if (CAN_SLEEP)
        {
            ADBG(10, "CPU SLEEP\n");
            SLEEP = (SLEEP & ~CC2430_SLEEP_MODE_MASK) | CC2430_SLEEP_POWERMODE_2;

            signal McuSleepControl.beforeSleep();
            
            __nesc_enable_interrupt();

            PCON = 0x01; //do sleep
            ADBG(10, "CPU WAKE UP\n");
            
            atomic m_need_sleep = FALSE;
            
            signal McuSleepControl.afterWakeup();
        }
        else
        {
            //ADBG(1, "canNOT sleep\n");
        }
    }


    default event void McuSleepControl.beforeSleep()
    { }

    default event void McuSleepControl.afterWakeup()
    { }

}

