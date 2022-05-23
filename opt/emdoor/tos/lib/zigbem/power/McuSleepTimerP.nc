module McuSleepTimerP
{
    provides interface Alarm<T32khz, uint32_t> as Alarm;

    //es interface McuGlobalTimer;
}
implementation
{

    #define ST_INT_ENABLE    { STIF=0; IEN0 |=  _BV(CC2430_IEN0_STIE); EA = 1;}//EA or EAL???
    #define ST_INT_DISABLE   {IEN0 &=  ~ _BV(CC2430_IEN0_STIE);}
    #define ST_INT_IS_ENABLE      (IEN0 & _BV(CC2430_IEN0_STIE))
    #define ST_INT_RESET    {STIF = 0;IRCON2 &= 0xF7;P1IFG = 0xFD;SLEEP &= 0XFC;}

    #define ST_VALUE(v)  ((v)&0xFFFFFF)

    #define ST_ADJ_TICK  (9)
    
    /* ST0 must read first */
    #define ST_READ_VALUE(v) {\
        u8((&v), 3) = ST0;\
        u8((&v), 2) = ST1;\
        u8((&v), 1) = ST2;\
        u8((&v), 0) = 0;\
    }

    /* ST0 must write first */
    #define ST_WRITE_COMPARE(c){\
        ST2 = u8((&c), 1);\
        ST1 = u8((&c), 2);\
        ST0 = u8((&c), 3);\
    }

    uint32_t m_alarm = 0x000000;
    uint32_t m_dt = 0x000000;

    async command void Alarm.stop()
    {
        ST_INT_DISABLE;
    }
    
    async command bool Alarm.isRunning()
    {
        return (ST_INT_IS_ENABLE);
    }

    async command uint32_t Alarm.getAlarm()
    {
        return (ST_VALUE(m_alarm));
    }

    async command uint32_t Alarm.getNow()
    {
        uint32_t now;
        ST_READ_VALUE(now);
        return now;
    }

    async command void Alarm.start(uint32_t dt)
    {
        uint32_t value;

        atomic
        {
            dt = ST_VALUE(dt);

            m_dt = dt;
            
            ST_READ_VALUE(value);

            value += dt;

            value -= ST_ADJ_TICK;

            /* Bug of this hardward */
            if (ST_VALUE(value) > 0xFFFF7F)
            {
                value = 0xFFFF7F;
            }

            ST_INT_ENABLE;
            ST_WRITE_COMPARE(value);

            m_alarm = value;

           ADBG(15, "McuSleepTimerP Alarm.start\r\n");
        }
    }

    async command void Alarm.startAt(uint32_t t0, uint32_t dt)
    {
    }

    default async event void Alarm.fired() {}

    MCS51_INTERRUPT(SIG_ST)
    {
        ST_INT_RESET;

        //ll McuGlobalTimer.addCounter(m_dt);
       ADBG(15, "alarm is fired!\r\n");
        
        signal Alarm.fired();
    }   
        
}
