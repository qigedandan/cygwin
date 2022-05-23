#include "ioCC2430.h"
#include "DS18B20Data.h"

module DS18B20DataP
{
  provides interface Init;
  provides interface DS18B20Data;
}
implementation
{
    #define DS18B20_DQ    P1_7
    #define DS18B20_DQ_OUTPUT   MAKE_IO_PIN_OUTPUT(P1_DIR, 7)
    #define DS18B20_DQ_INPUT      MAKE_IO_PIN_INPUT(P1_DIR, 7)

    
    uint16_t m_raw_value;
    uint8_t m_busy = FALSE;
    error_t m_result = SUCCESS;


    void delayDS18B20(uint8_t n)
    {
        while (n--)
        {
            NESC_NOP;
        }
    }

    void resetDS18B20()
    {//reset the ds18b20

				atomic {DS18B20_DQ_OUTPUT;}
        DS18B20_DQ = 1;    
        delayDS18B20(1);  //delay less than 2us

        DS18B20_DQ = 0;    
        delayDS18B20(250); 
        delayDS18B20(250);
        delayDS18B20(250);
        delayDS18B20(250);//delay 500us
        DS18B20_DQ = 1;


        atomic {DS18B20_DQ_INPUT;}    
        delayDS18B20(120);//delay 60us
        //while(DS18B20_DQ);

        atomic {DS18B20_DQ_INPUT;}
        DS18B20_DQ = 1;
    }

    command error_t Init.init()
    {
        resetDS18B20();
        return SUCCESS;
    }

    command void DS18B20Data.sendByte(uint8_t data)
    {
        uint8_t i;

        atomic {DS18B20_DQ_OUTPUT;  }
        for (i = 8; i > 0; i--)
        {
            DS18B20_DQ = 0;
            delayDS18B20(1);
            DS18B20_DQ = data & 0x01;
            delayDS18B20(120);//delay 60us
            DS18B20_DQ = 1;
            data >>= 1;	
            DS18B20_DQ = 1;
        }
    }

    command uint8_t DS18B20Data.recvByte()
    {
        uint8_t i, data = 0;

        for (i=8; i>0; i--)
        {
            data >>= 1;
            
            atomic {DS18B20_DQ_OUTPUT;}
            
            DS18B20_DQ = 0; // ¸øÂö³åÐÅºÅ
            delayDS18B20(1); 
            DS18B20_DQ = 1;
            delayDS18B20(10);
            
            atomic {DS18B20_DQ_INPUT;}
            if (DS18B20_DQ)
            {
                data |= 0x80;
            }
            delayDS18B20(130);
        }

        return data;
    }

    task void readDoneTask()
    {
        signal DS18B20Data.readDone(m_result, m_raw_value);

        m_busy = FALSE;
    }

    command error_t DS18B20Data.read()
    {
        if (m_busy)
        {
            return FAIL;
        }

        m_busy = TRUE;
        
        resetDS18B20();
        delayDS18B20(250);

        call DS18B20Data.sendByte(DS18B20_SKIP_ROM);
        delayDS18B20(250);
        call DS18B20Data.sendByte(DS18B20_CONVERT_T);
        delayDS18B20(250);

        resetDS18B20();
        delayDS18B20(250);
        call DS18B20Data.sendByte(DS18B20_SKIP_ROM);
        delayDS18B20(250);
        call DS18B20Data.sendByte(DS18B20_READ_SCRATCHPAD);
        delayDS18B20(250);

        u8((&(m_raw_value)), 1) = call DS18B20Data.recvByte();
        u8((&(m_raw_value)), 0) = call DS18B20Data.recvByte();

        m_result = SUCCESS;

        post readDoneTask();

        return SUCCESS;
    }

    command void DS18B20Data.convertTemperature(uint16_t raw_value, ds18b20_temperature_t *p_temp)
    {
        p_temp->value = raw_value;

        p_temp->minus = DS18B20_GET_MINUS(p_temp->value);

        p_temp->value = DS18B20_GET_T_BASE(p_temp->minus, p_temp->value);

        p_temp->value = DS18B20_GET_T(p_temp->value);
    }

    default event void DS18B20Data.readDone(error_t result, uint16_t raw_temperature)
    {}
}
