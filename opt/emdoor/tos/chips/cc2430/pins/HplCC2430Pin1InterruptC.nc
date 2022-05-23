module HplCC2430Pin1InterruptC
{
    provides interface GpioInterrupt as P1_INT[uint8_t pin];
}
implementation
{

    #define P1_INT_ENABLE(pin)  {\
        P1IEN |= 1<<pin; \
        P1_DIR &= ~(1<<pin); \
        P1_ALT &= ~(1<<pin);\
        IEN2 |= 0x10; \
    }

    async command error_t P1_INT.enableRisingEdge[uint8_t pin]()
    {
        PICTL &= ~0x02;
        
        P1_DIR |= (1<<pin);
        P1_0 = 0;

        P1IFG = 0x00;
        P1IF = 0;
        P1_INT_ENABLE(pin);
        
        return SUCCESS;
    }

    async command error_t P1_INT.enableFallingEdge[uint8_t pin]()
    {
        PICTL |= 0x02;

	 P1_DIR |= (1<<pin);
        P1_0 = 1;
        P1IFG = 0x00;
        P1IF = 0;

        
        P1_INT_ENABLE(pin);
        
        return SUCCESS;        
    }

    async command error_t P1_INT.disable[uint8_t pin]()
    {
        P1IEN &= ~(1<<pin);
        return SUCCESS;
    }

    default async event void P1_INT.fired[uint8_t pin]()
    {
    }

    MCS51_INTERRUPT(SIG_P1INT)
    {
        atomic
        {
            int i;
            for (i = 0; i < 8; i++)
            {
                if (P1IFG & (1<<i))
                {
                    signal P1_INT.fired[i]();
                }
            }
            
            P1IFG = 0x00;
            P1IF = 0;
        }
    }
}

