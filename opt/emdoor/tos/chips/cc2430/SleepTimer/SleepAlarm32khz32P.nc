

module SleepAlarm32khz32P
{
	provides interface Alarm<T32khz, uint32_t> as Alarm;
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
    uint32_t m_t0 = 0x000000;

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
        uint32_t r;
        ST_READ_VALUE(r);
        return r;
    }

    async command void Alarm.start(uint32_t dt)
    {  
    	    uint32_t t0 = call Alarm.getNow();
           call Alarm.startAt(t0, dt);
    }

    async command void Alarm.startAt(uint32_t t0, uint32_t dt)
    {
    	     uint32_t  now, elapsed, set;
    	     int32_t remaining;	     
    	     atomic 
    	     {
    	     		
    	     		dt = ST_VALUE(dt);
    	     		t0 = ST_VALUE(t0);
    	     		
           		 m_dt = dt;
           		 m_t0 = t0;          		
            		
            		ST_READ_VALUE(now);            		
			
            		elapsed = now - t0;           		
            		
			if(elapsed >= dt) {
				
				set  = now + 5;
			}else {
				remaining = dt - elapsed;
			 	if (remaining <= 5) {
					set = now + 5;
				}else {
					set = remaining + now;
				}
			}	
            		 
            		//remaining = dt-elapsed;
			//set = remaining+now;
            		/* Bug of this hardward */
            		if (ST_VALUE(set) > 0xFFFF7F)
            		{
                		set = 0xFFFF7F;
            		}

           		ST_INT_ENABLE;
            		ST_WRITE_COMPARE(set);

            		m_alarm = set;          
        	}
    }

    default async event void Alarm.fired() {}

  MCS51_INTERRUPT(SIG_ST)
    {
        ST_INT_RESET;

        //ll McuGlobalTimer.addCounter(m_dt);     
        
        signal Alarm.fired();
    } 
        
}

