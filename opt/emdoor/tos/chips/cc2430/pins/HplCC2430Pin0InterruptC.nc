module HplCC2430Pin0InterruptC
{
    provides interface GpioInterrupt as P0_INT[uint8_t pin];
}
implementation
{

    void P0_INT_ENABLE(uint8_t pin)  {
	 if(pin > 3)
	 {
	 	PICTL |= 0x10 ;
	 }
	 else
	 {
	 	PICTL |= 0x08 ;
	 }
        P0_DIR &= ~(1<<pin);
        P0_ALT &= ~(1<<pin);
//        IEN1 |= 0x20;
	P0IE	 = 1;
    }

    async command error_t P0_INT.enableRisingEdge[uint8_t pin]()
    {
        PICTL &= ~0x01;
        
//        P0_DIR |= (1<<pin);
//        P0_0 = 0;
	P0 = 0;

        P0IFG = 0x00;
        P0IF = 0;

        P0_INT_ENABLE(pin);
        
        return SUCCESS;
    }

    async command error_t P0_INT.enableFallingEdge[uint8_t pin]()
    {
        PICTL |= 0x01;

//	 P0_DIR |= (1<<pin);
//        P0_0 = 1;
	P0 = 0;

        P0IFG = 0x00;
        P0IF = 0;
        
        P0_INT_ENABLE(pin);
        
        return SUCCESS;        
    }

    async command error_t P0_INT.disable[uint8_t pin]()
    {
//        P1IEN &= ~(1<<pin);
//        IEN1 &= ~0x20;
	P0IE	 = 0;
        return SUCCESS;
    }

    default async event void P0_INT.fired[uint8_t pin]()
    {
    }

    MCS51_INTERRUPT(SIG_P0INT)
    {
        atomic
        {
            int i;
            for (i = 0; i < 8; i++)
            {
                if (P0IFG & (1<<i))
                {
                    signal P0_INT.fired[i]();
                }
            }
            
            P0IFG = 0x00;
            P0IF = 0;
        }
    }
}

