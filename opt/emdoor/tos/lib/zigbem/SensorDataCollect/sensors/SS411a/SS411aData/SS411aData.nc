interface SS411aData
{
    /* Application level */
    command error_t read();
    event void readDone(error_t result, uint16_t val);
}
