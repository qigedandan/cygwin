interface HalFlash
{
    command error_t read(uint8_t * destination, uint8_t * source, uint16_t length);

    command error_t write(uint8_t * destination, uint8_t * source, uint16_t length);
    
    command error_t erase(uint8_t * address);
}
