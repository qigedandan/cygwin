
includes AM;
includes message;

module QueuedTransmitP
{
    provides interface Init;
    provides interface Send[uint8_t id];
    provides interface Receive[uint8_t id];
    
    uses interface AMSend[uint8_t id];
    uses interface AMPacket;
    uses interface Packet;

    uses interface Receive as SubReceive[uint8_t id];
    
    uses interface Timer<TMilli> as RetryTimer;

    
    uses interface SmartQueue as SendMsgQueue;
    uses interface SmartQueue as ReceiveMsgQueue;
    
    uses interface McuSleepLock as SendLock;
    uses interface McuSleepLock as ReceiveLock;
}

implementation
{
    #define RETRY_TIMEOUT  128
    #define RETRY_MAX     3
    
    error_t m_error;
    bool m_use_retry = FALSE;
    uint8_t m_retry_count = 0;

    
    bool m_sending_data_msg = FALSE;
    bool m_send_task_pending = FALSE;    // TRUE when the task that forwards messages is pending, this avoids posting this task multiple times
    message_t m_current_msg;                 // The msg being sent, if any

    bool m_receiving_data_msg = FALSE;
    bool m_receive_task_pending = FALSE;
    message_t m_received_msg;

    /****************************************************************************/

    command error_t Init.init()
    {
        m_sending_data_msg = FALSE;
        m_send_task_pending = FALSE;
        m_error = SUCCESS;

        m_receiving_data_msg = FALSE;
        m_receive_task_pending = FALSE;
        
	 call RetryTimer.stop();
    }

    /****************************************************************************/

    void copy_msg_in(uint8_t *dst, message_t *src)
    {//copy into queue
        uint8_t payload_length = call Packet.payloadLength(src);
        uint8_t offset = 0;
        //header
        memcpy(dst+offset, src->header, sizeof(message_header_t));
        offset += sizeof(message_header_t);

        //payload
        if (payload_length > 0)
        {
            memcpy(dst+offset, src->data, payload_length);
            offset += payload_length;
        }

        //footer
        memcpy(dst+offset, src->footer, sizeof(message_footer_t));
        offset += sizeof(message_footer_t);

        //metadata
        memcpy(dst+offset, src->metadata, sizeof(message_metadata_t));
        offset += sizeof(message_metadata_t);
    }

    void copy_msg_out(message_t *dst, uint8_t *src)
    {
        uint8_t payload_length = 0;
        uint8_t offset = 0;
        //header
        memcpy(dst->header, src+offset, sizeof(message_header_t));
        offset += sizeof(message_header_t);

        //payload
        payload_length = call Packet.payloadLength(dst);
        if (payload_length > 0)
        {
            memcpy(dst->data, src+offset, payload_length);
            offset += payload_length;
        }

        //footer
        memcpy(dst->footer, src+offset, sizeof(message_footer_t));
        offset += sizeof(message_footer_t);
        
        //metadata
        memcpy(dst->metadata, src+offset, sizeof(message_metadata_t));
        offset += sizeof(message_metadata_t);
    }

    /****************************************************************************/

    error_t sendDataMsg()
    {
        if (call SendMsgQueue.isEmpty() == FALSE)
        {
            uint8_t *queued_msg = (uint8_t *)call SendMsgQueue.head();
            
            copy_msg_out(&m_current_msg, queued_msg);
            
            return call AMSend.send[call AMPacket.type(&m_current_msg)]
                            (
                                call AMPacket.destination(&m_current_msg),
                                &m_current_msg,
                                call Packet.payloadLength(&m_current_msg)
                            );
        }
        else
        {
            return SUCCESS;
        }
    }

    task void taskSendWaitingMsg()
    {
        ADBG(1, "taskSendWaitingMsg\n");
        if (m_send_task_pending == FALSE)
        {            
            error_t err = SUCCESS;

            ADBG(1, " IN taskSendWaitingMsg\n");


            if (m_sending_data_msg == FALSE  &&  call SendMsgQueue.isEmpty() == FALSE)
            {
                m_sending_data_msg = TRUE;
                ADBG(1, "SendMsgQueue not empty\n");
                err = sendDataMsg();
                if (err == SUCCESS)
                {
                    
                }
                else
                {
                    m_sending_data_msg = FALSE;

                    ADBG(1, "QueuedSend.sendData fail!\n");
                }
            }


            if(err == FAIL)
            {
                ADBG(1, "FAIL, RETRYing\n");
                
                m_sending_data_msg = TRUE;
                call RetryTimer.startOneShot(RETRY_TIMEOUT);
            }
            else
            {
                ADBG(1, " all ok\n");
                m_send_task_pending = FALSE;
            }
        }
    }

    event void RetryTimer.fired()
    {
        m_send_task_pending = FALSE;
        
	 ADBG(1, "RetryTimer.fired");
        post taskSendWaitingMsg();
    }

    error_t enqueueSendDataMsg(message_t *msg)
    {
        uint8_t total_len = call Packet.payloadLength(msg) + sizeof(message_header_t) + sizeof(message_footer_t) + sizeof(message_metadata_t);
        
        ADBG(1, "\r\nenqueueSendDataMsg total_len=%d", ADBG_N(total_len));

        if (call SendMsgQueue.canStore(total_len) == TRUE)
        {
            uint8_t *queued_msg = (uint8_t*) call SendMsgQueue.enqueue(total_len);
            
            copy_msg_in(queued_msg, msg);

            post taskSendWaitingMsg();

            return SUCCESS;
        }

        return FAIL;
    }

    command error_t Send.send[uint8_t id](message_t *msg, uint8_t len)
    {
        call AMPacket.setType(msg, id);        
        call Packet.setPayloadLength(msg, len);
        
        return enqueueSendDataMsg(msg);
    }


    command error_t Send.cancel[uint8_t id](message_t *msg)
    {
        return SUCCESS;
    }

    command uint8_t Send.maxPayloadLength[uint8_t id]()
    {
        return call AMSend.maxPayloadLength[id]();
    }

    
    command void *Send.getPayload[uint8_t id](message_t *msg)
    {
        return call Packet.getPayload(msg, NULL);
    }

    event void AMSend.sendDone[uint8_t id](message_t* msg, error_t result)
    {
        bool end = TRUE;
        ADBG(1, "\r\nAMSend.sendDataMsgDone");	

        m_error = result;

        if ((m_error != SUCCESS) && (m_use_retry==TRUE))
        {
            end = FALSE;
            m_retry_count++;
            if (m_retry_count > RETRY_MAX)
            {
                m_retry_count = 0;
                end = TRUE;
            }
        }

        if (end)
        {
            call SendMsgQueue.dequeue();
            //post taskSendDone();
            signal Send.sendDone[call AMPacket.type(&m_current_msg)](&m_current_msg, m_error);
        }

	 m_sending_data_msg = FALSE;

        post taskSendWaitingMsg();
    }



    default event void Send.sendDone[uint8_t id](message_t *msg, error_t result)
    {
    }


    /****************************************************************************/
    task void taskReceiveMsg()
    {
        ADBG(1, "taskReceivingMsg\n");

        if (call ReceiveMsgQueue.isEmpty() == FALSE)
        {
            uint8_t *queued_msg = (uint8_t *)call ReceiveMsgQueue.head();
            
            copy_msg_out(&m_received_msg, queued_msg);
            
            signal Receive.receive[call AMPacket.type(&m_received_msg)]
                        (
                            &m_received_msg,
                            call Packet.getPayload(&m_received_msg, NULL),
                            call Packet.payloadLength(&m_received_msg)
                        );
                        
            call ReceiveMsgQueue.dequeue();

            if (call ReceiveMsgQueue.isEmpty() == FALSE)
            {
                post taskReceiveMsg();
                return;
            }
        }
    }

    
    error_t enqueueReceiveDataMsg(message_t *msg)
    {
        uint8_t total_len = call Packet.payloadLength(msg) + sizeof(message_header_t) + sizeof(message_footer_t) + sizeof(message_metadata_t);
        
        ADBG(1, "\r\nenqueueReceiveDataMsg total_len=%d", ADBG_N(total_len));

        if (call ReceiveMsgQueue.canStore(total_len) == TRUE)
        {
            uint8_t *queued_msg = (uint8_t*) call ReceiveMsgQueue.enqueue(total_len);

            ADBG(1, "can store");
            
            copy_msg_in(queued_msg, msg);

            post taskReceiveMsg();

            return SUCCESS;
        }
        else
        {
             ADBG(1, "can NOT store");
        }

        return FAIL;
    }

    
    event message_t *SubReceive.receive[uint8_t id](message_t* msg, void* payload, uint8_t len)
    {
        enqueueReceiveDataMsg(msg);
        return msg;
    }

    default event message_t *Receive.receive[uint8_t id](message_t* msg, void* payload, uint8_t len)
    { }

    command void *Receive.getPayload[uint8_t id](message_t *msg, uint8_t *len)
    {
        return call SubReceive.getPayload[id](msg, len);
    }

    command uint8_t Receive.payloadLength[uint8_t id](message_t *msg)
    {
        return call SubReceive.payloadLength[id](msg);
    }
}
