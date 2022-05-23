#ifndef EMSLEEP_H
#define EMSLEEP_H

#define ST_INT_ENABLE    { STIF=0; IEN0 |=  _BV(CC2430_IEN0_STIE); EA = 1;}
#define ST_INT_DISABLE   {IEN0 &=  ~ _BV(CC2430_IEN0_STIE);}
#define ST_INT_RESET    {STIF = 0;}
#define ST_INT_IS_ENABLE      (IEN0 & _BV(CC2430_IEN0_STIE))


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

void sleepSetTimer(uint32_t dt)
{
    uint32_t value;
    
    ST_READ_VALUE(value);

    value += dt;

    value -= ST_ADJ_TICK;

    /* Bug of this hardware */
    if (ST_VALUE(value) > 0xFFFF7F)
    {
        value = 0xFFFF7F;
    }

    ST_INT_ENABLE;
    ST_WRITE_COMPARE(value);
}

#endif
