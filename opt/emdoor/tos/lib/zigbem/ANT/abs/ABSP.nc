
#include "abs.h"

module ABSP
{
    provides interface ABS;
    provides interface Init;
    
    uses interface SerialByteComm as Comm;
    uses interface StdControl as UartStdControl;
}
implementation
{
    uint8_t m_send_meta[ABS_PACKET_META_LEN];
    uint8_t m_send_buffer[ABS_BUFFER_SIZE];
    uint8_t *m_send_head;
    uint8_t *m_send_tail;
    uint8_t *m_send_end;
    uint16_t m_send_node_type;
    uint16_t m_send_ack_type;		//tivacc
    uint16_t m_send_node_id;
    
    bool m_encoding;
    bool m_sending;

    bool m_tail_before = FALSE;

    #define ABS_BUFFER_LEFT_LEN     (((m_send_tail > m_send_head) || (m_send_tail==m_send_head  &&  m_tail_before==FALSE)) ? (ABS_BUFFER_SIZE - (m_send_tail - m_send_head)) : (m_send_head - m_send_tail))

    #define ABS_BUFFER_ADD(d) {\
        *(m_send_tail++) = (d); \
        if (m_send_tail >= m_send_end) \
        { \
            m_tail_before = TRUE; \
            m_send_tail = m_send_buffer; \
        } \
    }
    
    void sendNext()
    {
        atomic
        {
            if (m_send_tail != m_send_head  ||  (m_send_tail==m_send_head && m_tail_before == TRUE))
            {
                if (!m_sending)
                {
                    m_sending = TRUE;
                    call Comm.put(*m_send_head);
                }
            }
        }
    }
    


    error_t encodePacket(uint8_t *src, uint16_t len)
    {
        atomic
        {
            uint8_t i;
            uint8_t fcs;
            
            if (m_encoding) return EBUSY;
            
            if (len==0 ||  (len+ABS_PACKET_META_LEN) > ABS_BUFFER_LEFT_LEN)
            {//zero size or size too big
                return ESIZE;
            }

            //set meta data first
            su8(m_send_meta, ABS_PACKET_SOP_START, ABS_PACKET_SOP);
            
            //CMD
            su16(m_send_meta, ABS_PACKET_CMD_START, ABS_CMD_RF_DATA);
            
            //LEN
            su16(m_send_meta, ABS_PACKET_LEN_START, (len+ABS_PACKET_NODE_TYPE_LEN));
            
            //Node Type
            su16(m_send_meta, ABS_PACKET_NODE_TYPE_START, m_send_node_type);

            //Node ID
            //su16(m_send_meta, ABS_PACKET_NODE_ID_START, m_send_node_id);


            ABS_START_FCS(fcs, u8(m_send_meta, 1)); //FCS from the first by of CMD
            
            //add the whole meta except the FCS
            for (i=0; i < ABS_PACKET_META_LEN-1; i++)
            {
                ABS_BUFFER_ADD(u8(m_send_meta, i));
                if (i > 1)
                {//do not FCS SOP
                    ABS_CALC_FCS(fcs, u8(m_send_meta, i));
                }
            }
            
            while (len--)
            {
                ABS_BUFFER_ADD(*src);
                ABS_CALC_FCS(fcs, *src);
                src++;
            }

            ABS_END_FCS(fcs);

            ABS_BUFFER_ADD(fcs);

            m_encoding = FALSE;
        }

        return SUCCESS;
    }
 
    command error_t Init.init()
    {
        atomic
        {
            m_send_head = m_send_buffer;
            m_send_tail = m_send_buffer;
            m_send_end = m_send_buffer + ABS_BUFFER_SIZE;
            m_encoding = FALSE;
            m_sending = FALSE;

            call UartStdControl.start();
        }
        return SUCCESS;
    }
    
    command error_t ABS.reportPacket(uint16_t node_type, uint8_t *src, uint16_t len)
    {
        error_t result;
        m_send_node_type = node_type;
        //m_send_node_id = node_id;
        
        result = encodePacket(src, len);
        if (result != SUCCESS)
        {
            return result;
        }

        //post sendNext();
        sendNext();
    }

    async event void Comm.putDone()
    {
        atomic
        {
            if (!m_sending)
            {
                return;
            }


            m_send_head++;
            
            
            if (m_send_head >= m_send_end)
            {
                m_tail_before = FALSE;
                m_send_head = m_send_buffer;
            }
            
            //post sendNext();
            m_sending = FALSE;
            
            sendNext();
        }
    }

    async event void Comm.get(uint8_t data)
    {
    }
    
    default event void ABS.reportPacketDone(uint8_t *src, uint16_t len, error_t result) { }
}
