/* Default USE P0.4 */
#define SS411a_PORT          P0
#define SS411a_PIN            4
#define SS411a_PORT_DIR  P0_DIR
#define SS411a_PORT_ALT  P0_ALT

    
module SS411aDataP
{
    provides interface SS411aData;
}
implementation
{
    error_t m_result;
    uint16_t m_value;

    task void taskSendDone()
    {
        signal SS411aData.readDone(m_result, m_value);
    }

    /* Application level */
    command error_t SS411aData.read()
    {
        uint8_t old_dir, old_alt;
        m_result = SUCCESS;

        old_dir = SS411a_PORT_DIR;
        old_alt = SS411a_PORT_ALT;
        
        SS411a_PORT_DIR &= ~(1 << 4);
        SS411a_PORT_ALT &= ~(1 << 4);

        m_value = (SS411a_PORT & (1 << SS411a_PIN)) == 0;

        SS411a_PORT_DIR = old_dir;
        SS411a_PORT_ALT= old_alt;

        post taskSendDone();

        return SUCCESS;
    }
    
    default event void SS411aData.readDone(error_t result, uint16_t val) {}
}
