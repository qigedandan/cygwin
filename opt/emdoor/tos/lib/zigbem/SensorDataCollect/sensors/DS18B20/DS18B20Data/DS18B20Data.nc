#include "DS18B20Data.h"

interface DS18B20Data
{
    //command void init();

    /* Low level */
    command void sendByte(uint8_t data);

    command uint8_t recvByte();

    command void convertTemperature(uint16_t raw_value, ds18b20_temperature_t *p_temp);
    
    /* Application level */
    command error_t read();
    event void readDone(error_t result, uint16_t raw_temperature);
}
