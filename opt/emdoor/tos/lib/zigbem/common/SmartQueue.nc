
interface SmartQueue
{
    command bool     isEmpty();
    command bool     canStore(uint8_t len);
    command void     dequeue();
    command void*    enqueue(uint8_t len);
    command void*    head();
    command uint8_t  headLength();
    command uint16_t nbElements();
}
