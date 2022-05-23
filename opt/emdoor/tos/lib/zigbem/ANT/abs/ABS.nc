

interface ABS
{
    command error_t reportPacket(uint16_t node_type, uint8_t *src, uint16_t len);

    event void reportPacketDone(uint8_t *src, uint16_t len, error_t result);
}
