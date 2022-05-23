module CC2430TimerSleepP
{
    provides interface Alarm<T32khz, uint32_t> as Alarm;

    provides interface Init;
}
implementation
{

    #define ST_INT_ENABLE    { STIF=0; IEN0 |=  _BV(CC2430_IEN0_STIE); EA = 1;}
    #define ST_INT_DISABLE   {IEN0 &=  ~ _BV(CC2430_IEN0_STIE);}
    #define ST_INT_IS_ENABLE      (IEN0 & _BV(CC2430_IEN0_STIE))
    #define ST_INT_RESET    {STIF = 0;}

    #define ST_VALUE(v)  ((v)&0xFFFFFF)

    #define ST_ADJ_TICK  (9+25)
    
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

    uint32_t m_alarm = 0xFFFFFF;

    uint8_t port = 1;

    command error_t Init.init()
    {
        ST_INT_DISABLE;
    }

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
    }

    async command void Alarm.start(uint32_t dt)
    {
        uint32_t value;
        
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
    }

    async command void Alarm.startAt(uint32_t t0, uint32_t dt)
    {
        
    }

    default async event void Alarm.fired() {}

    MCS51_INTERRUPT(SIG_ST)
    {
        ST_INT_RESET;
        
     //P1_DIR |= 1<<3;


        //poweroff = FALSE;
        
        signal Alarm.fired();
        //call Alarm.start(50000);

        //poweroff = !poweroff;
        //P1_0 = poweroff;
    }
}