#include "SHTxxData.h"


module SHTxxDataP
{
    provides interface Init;
    provides interface SHTxxData;


    uses interface Timer<TMilli> as WaitTimer;
}
implementation
{

#define SHTxx_NOACK       0
#define SHTxx_ACK         1

#define SHTxx_MODE_TEMP   0
#define SHTxx_MODE_HUMI   1
                                       //adr  command  r/w
#define SHTxx_STATUS_REG_W        0x06   //000   0011    0
#define SHTxx_STATUS_REG_R        0x07   //000   0011    1
#define SHTxx_MEASURE_TEMP        0x03   //000   0001    1
#define SHTxx_MEASURE_HUMI        0x05   //000   0010    1
#define SHTxx_RESET               0x1e

#define DELAY_TICK(n)   {tick=(n); while (tick--);}

enum
{
    SHTxx_STATE_NONE,
    SHTxx_STATE_TEMP,
    SHTxx_STATE_HUMI,
};

    uint8_t m_state = SHTxx_STATE_NONE;

    uint8_t tick;

    uint8_t m_error = 0;

    uint16_t m_temperature;
    uint16_t m_humidity;
    uint8_t m_checksum;
    uint8_t *p_value;

    task void readDoneTask(); 
    
    command error_t Init.init()
    {
        call WaitTimer.stop();
        m_state = SHTxx_STATE_NONE;
        return SUCCESS;
    }
      
    uint8_t sendByte(uint8_t value)
    {
        uint8_t i, error;

			 atomic {     
			 SHTxx_DATA_OUT;
			 SHTxx_SCK_OUT;
			 }
			 
       for (i=0x80; i>0; i/=2)
        { 
            if (i & value)
            {
                SHTxx_DATA = 1;
            }
            else
            {
                SHTxx_DATA = 0;
            }

            SHTxx_SCK = 1;

            DELAY_TICK(3);
            
            SHTxx_SCK = 0;
        }
				
        SHTxx_DATA = 1;
        SHTxx_SCK = 1;

        atomic {SHTxx_DATA_IN;}
        
        error = SHTxx_DATA;

        SHTxx_SCK = 0;

        return error;
    }

    uint8_t recvByte(uint8_t ack)
    {
        uint8_t i,val = 0;
        
        atomic {
				SHTxx_SCK_OUT; 
				
				SHTxx_DATA_OUT;
        SHTxx_DATA = 1;

        SHTxx_DATA_IN;
				}
      
        for (i=0x80; i>0; i/=2)
        {
          
            SHTxx_SCK = 1;
           
            DELAY_TICK(1);
            
            if (SHTxx_DATA)
            {
                val = (val | i);
            }

            
            SHTxx_SCK = 0;
        }

        
        SHTxx_DATA_OUT;

        SHTxx_DATA = !ack;                        //in case of "ack==1" pull down DATA-Line
        SHTxx_SCK = 1;                            //clk #9 for ack

        DELAY_TICK(10);
        
        SHTxx_SCK = 0;
        SHTxx_DATA = 1;                          //release DATA-line
        return val;
    }

    uint8_t start()
    {
        atomic {
				SHTxx_DATA_OUT;
        SHTxx_SCK_OUT;
				}
        
        SHTxx_DATA = 1;
        SHTxx_SCK = 0;
        //_nop_();
        DELAY_TICK(1);
        
        SHTxx_SCK = 1;
        //_nop_();
        DELAY_TICK(1);
        
        SHTxx_DATA = 0;
        //_nop_();
        DELAY_TICK(1);
        SHTxx_SCK = 0;

        DELAY_TICK(3);
        
        SHTxx_SCK = 1;
        //_nop_();
        DELAY_TICK(1);
        
        SHTxx_DATA = 1;
        //_nop_();
        DELAY_TICK(1);
        
        SHTxx_SCK = 0;
    }

    void reset()
    //----------------------------------------------------------------------------------
    // communication reset: DATA-line=1 and at least 9 SCK cycles followed by transstart
    //       _____________________________________________________         ________
    // DATA:                                                      |_______|
    //          _    _    _    _    _    _    _    _    _        ___     ___
    // SCK : __| |__| |__| |__| |__| |__| |__| |__| |__| |______|   |___|   |______
    {  
        uint8_t i;

				atomic {
        SHTxx_DATA_OUT;
        SHTxx_SCK_OUT;
				}
				
        SHTxx_DATA = 1; 
        SHTxx_SCK = 0;                    //Initial state

        for (i=0; i<9; i++)                  //9 SCK cycles
        { 
            SHTxx_SCK = 1;
            DELAY_TICK(1);
            SHTxx_SCK = 0;
            DELAY_TICK(1);
        }

        start();                   //transmission start
    }

    void enableDataInt()
    {
        
    }

    void disableDataInt()
    {
    }

    uint8_t cmdReset()
    //----------------------------------------------------------------------------------
    // resets the sensor by a softreset 
    {
        reset();              //reset communication
        m_error += sendByte(SHTxx_RESET);       //send RESET-command to sensor
        return m_error;                     //error=1 in case of no response form the sensor
    }

    //----------------------------------------------------------------------------------
    uint8_t cmdMeasure()
    //----------------------------------------------------------------------------------
    // makes a measurement (humidity/temperature) with checksum
    {
        reset();
        start();                   //transmission start

        if (m_state == SHTxx_STATE_TEMP)
        {
            //ADBG(1, "\r\nSHT temp");
            p_value = (uint8_t *)(&m_temperature);
            m_error += sendByte(SHTxx_MEASURE_TEMP);
        }
        else
        {
            //ADBG(1, "\r\nSHT humi");
            p_value = (uint8_t *)(&m_humidity);
            m_error += sendByte(SHTxx_MEASURE_HUMI);
        }


        if (m_error > 0)
        {
            post readDoneTask();
            return m_error;
        }

        call WaitTimer.startOneShot(SHTxx_TIMEOUT);

        return m_error;
    }

    event void WaitTimer.fired()
    {
        //ADBG(1, "\r\nWaitTimer.fired state=%d", ADBG_N(m_state));
        
        if (m_state == SHTxx_STATE_TEMP  ||  m_state == SHTxx_STATE_HUMI)
        {
            SHTxx_DATA_IN;
            if (SHTxx_DATA) m_error += 1;                // or timeout (~2 sec.) is reached


            if (m_error > 0)
            {
                post readDoneTask();
                return;
            }

            //ADBG(1, "\r\nNO error");

            *(p_value)  = recvByte(SHTxx_ACK);    //read the first byte (MSB)
            *(p_value+1) = recvByte(SHTxx_ACK);    //read the second byte (LSB)
            m_checksum = recvByte(SHTxx_NOACK);  //read checksum

            if (m_state < SHTxx_STATE_HUMI)
            {
                //ADBG(1, "\r\nSHT NEXT");
                m_state++;
                cmdMeasure();
            }
            else
            {
                post readDoneTask();
            }
        }
    }

    task void readDoneTask()
    {
        error_t result = (m_error > 0) ? FAIL : SUCCESS;

        //ADBG(1, "\r\nreadDoneTask");

        atomic m_state = SHTxx_STATE_NONE;
        
        //ADBG(1, "\r\ntemp=%x,humi=%x",m_temperature,m_humidity);

        signal SHTxxData.readDone(result, m_temperature, m_humidity);
    }

    command error_t SHTxxData.read()
    {
        //ADBG(1, "\r\nSHT state=%d", m_state);
        atomic
        {
            if (m_state != SHTxx_STATE_NONE)
            {
                if (m_state >= SHTxx_STATE_NONE  &&  m_state <= SHTxx_STATE_HUMI)
                {
                    return FAIL;
                }

                m_state = SHTxx_STATE_NONE;
            }

            m_state = SHTxx_STATE_TEMP;
        }
        
        m_error = 0;
        
        cmdMeasure();

        return SUCCESS;
    }

    default event void SHTxxData.readDone(error_t result, uint16_t temperature, uint16_t humidity) {}

}
