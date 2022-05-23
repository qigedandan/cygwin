module AtomMeshControlP
{
    provides interface Init;
    provides interface AtomMeshControl;

    uses interface StdControl as WsnControl;
    uses interface McuSleepControl;
    uses interface Timer<TMilli> as ControlTimer;

    uses interface StdControl as RadioControl;
}
implementation
{
    #define AMC_STATE_ACTIVE    0
    #define AMC_STATE_SLEEP      1
    
    uint8_t m_state = AMC_STATE_ACTIVE;
    
    bool m_lowpower_enabled = FALSE;
    uint32_t m_sleep_ms = MCU_SLEEP_TIME;
    uint32_t m_active_ms = MCU_ACTIVE_TIME;

    void switchToState(uint8_t state)
    {
        m_state = state;

        if (m_state == AMC_STATE_SLEEP)
        {
            ADBG(2, "Enter sleep = %d\n", ADBG_N(m_sleep_ms));
            call McuSleepControl.sleep(m_sleep_ms);
        }
        else
        {
            ADBG(2, "Enter active = %d\n", ADBG_N(m_active_ms));
            call ControlTimer.startOneShot(m_active_ms);
        }
    }

    void doWakeup()
    {
        ADBG(2, "haha, I'm awake now \n");
        switchToState(AMC_STATE_ACTIVE);
        //call WsnControl.start();
        call RadioControl.start();
        
        //while (_CC2430_RFSTATUS & 0x01);
        ADBG(2, "RF=%x\n", ADBG_N(_CC2430_RFSTATUS));
    }

    command error_t Init.init()
    {
        m_lowpower_enabled = FALSE;
        m_sleep_ms = MCU_SLEEP_TIME;
        m_active_ms = MCU_ACTIVE_TIME;
        
        return SUCCESS;
    }

    command void AtomMeshControl.enableLowPower(bool enabled)
    {        
        m_lowpower_enabled = enabled;

        if (m_lowpower_enabled)
        {// Enable low power, start from active state
            doWakeup();
        }
    }

    command void AtomMeshControl.setSleepTime(uint32_t ms)
    {
        m_sleep_ms = ms;
    }

    command uint32_t AtomMeshControl.getSleepTime()
    {
        return m_sleep_ms;
    }

    command void AtomMeshControl.setActiveTime(uint32_t ms)
    {
        m_active_ms = ms;
    }

    command uint32_t AtomMeshControl.getActiveTime()
    {
        return m_active_ms;
    }

    command uint32_t AtomMeshControl.getTotalTime()
    {
        return (m_sleep_ms + m_active_ms);
    }

    event void ControlTimer.fired()
    {
        ADBG(1, "ControlTimer.fired\n");


        if (m_lowpower_enabled)
        {
            if (m_state == AMC_STATE_ACTIVE)
            {
                switchToState(AMC_STATE_SLEEP);
            }
            else
            {
                switchToState(AMC_STATE_ACTIVE);
            }
        }

    }
    event void McuSleepControl.beforeSleep()
    {
        ADBG(2, "now sleeping...\n");
        //call WsnControl.stop();
    }

    event void McuSleepControl.afterWakeup()
    {
        doWakeup();
    }
}

