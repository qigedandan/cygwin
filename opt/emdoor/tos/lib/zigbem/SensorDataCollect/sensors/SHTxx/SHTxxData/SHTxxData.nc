interface SHTxxData
{
    command error_t read();
    event void readDone(error_t result, uint16_t temperature, uint16_t humidity);
}
