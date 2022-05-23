

generic module DebugLibP(uint16_t buffer_size)
{
	provides interface DiagnoseQuery;
	provides interface DiagnoseSendQuery;
	provides interface StdControl;
	provides interface Init;

	uses interface ReceiveDiagnose;
	uses interface SendDiagnose;
	uses interface StdControl as ReceiveDiagCntl;
	uses interface StdControl as SendDiagCntl;
	uses interface AMPacket;
}
implementation
{

	uint16_t m_send_buf_head = 0;
	uint16_t m_send_buf_tail = 0;

	uint8_t m_send_buf[buffer_size];
	uint8_t m_sending = FALSE;
	
	uint16_t DebugerNodeId;

	ackQuery_cmd_packet_t* ack_packetPtr;
	ackQuery_cmd_packet_t ack_packet;

	query_cmd_packet_t* query_packetPtr;
	query_cmd_packet_t query_packet;

	task void sendNextBuffer();

	/*================== Init =============================*/
	command error_t Init.init()
	{
		ack_packetPtr = &ack_packet;
		query_packetPtr = &query_packet;

		return SUCCESS;
	}

	/*================== StdControl =========================*/
	command error_t StdControl.start()
	{
		call ReceiveDiagCntl.start();
		call SendDiagCntl.start();
		
		return SUCCESS;
	}

	command error_t StdControl.stop()
	{
		call ReceiveDiagCntl.stop();
		call SendDiagCntl.stop();

		return SUCCESS;
	}

	/*=====================================================*/
	command error_t DiagnoseSendQuery.sendCmd(uint16_t id)
	{
		query_packetPtr -> cmd = DIAGNOSE_QUERY_CMD_TYPE;
		query_packetPtr -> Debuger_id = call AMPacket.address();
		query_packetPtr -> queryNodeId = id;

		ADBG(1, "DiagnoseSendQuery.sendCmd, cmdType: %d,  Debugger_id: %d, queryNodeId: %d\n",
			query_packetPtr->cmd, query_packetPtr -> Debuger_id, query_packetPtr -> queryNodeId);
		return call SendDiagnose.query(query_packetPtr,QUERY_CMD_PACKET_SIZE) ;
	}

	event void SendDiagnose.receivedAck(ackQuery_cmd_packet_t* packet, uint8_t len)
	{	
		char* temp_string = (char*)(packet->data);
		signal DiagnoseSendQuery.receivedAck(temp_string);
		//signal DiagnoseSendQuery.receivedAck(packet->data,( packet->header).len);
	}

	void fill_buffer(uint8_t* buf, uint16_t len);	
	/*=====================================================*/
	command error_t DiagnoseQuery.sendData(const char* string)
	{
		uint8_t temp_buf[100];
		uint16_t temp_len;
		temp_len = sprintf(temp_buf, "%s", string);

		fill_buffer(temp_buf, temp_len+1);

		return SUCCESS;
	}

	void fill_buffer(uint8_t* buf, uint16_t len)
	{	
		ADBG(1, "DiagnoseQuery.sendData, len=%d\n", (int)len); 
		
		atomic{
			uint16_t one_len = len;

			if(buffer_size -m_send_buf_tail <len)
			{
				one_len = buffer_size - m_send_buf_tail;
			}

			memcpy(m_send_buf + m_send_buf_tail, buf, one_len);
			m_send_buf_tail = (m_send_buf_tail + one_len) % buffer_size;
			buf += one_len;
			len -= one_len;

			if(len > 0)
			{
				one_len = len;
				memcpy(m_send_buf + m_send_buf_tail, buf, one_len);
				m_send_buf_tail = (m_send_buf_tail + one_len) % buffer_size;
				buf += one_len;
				len -= one_len;
			}
		}

		
		post sendNextBuffer();
		
	}

	void prepareSendBuffer(uint16_t* from, uint8_t *len)
	{
		atomic{
			if( m_send_buf_tail != m_send_buf_head) //buf is not empty
			{
				uint16_t one_len;

				if(m_send_buf_tail < m_send_buf_head)
				{
					one_len = buffer_size - m_send_buf_head;
				}else
				{
					one_len = m_send_buf_tail - m_send_buf_head;
				}

				if(one_len > DIAGNOSE_ACK_PACKET_MAX_SIZE) {
					one_len = DIAGNOSE_ACK_PACKET_MAX_SIZE;
				}

				*from = m_send_buf_head;
				*len = one_len;

				m_send_buf_head = (m_send_buf_head + one_len) % buffer_size;

				
			}
			else
			{
				*from = 0;
				*len = 0;
			}
		}
	}

	task void sendNextBuffer()
	{	
		
		uint16_t  from;
		uint8_t len;

		ADBG(1, "sendNextBuffer Task is called\n");
		atomic {
			if(!m_sending)
			{
				prepareSendBuffer(&from, &len);

				if(len >0)
				{	
					/** 
					 * Init ackQuery  packet header
					 */
					ack_packetPtr ->header.cmd = DIAGNOSE_ACK_QUERY_CMD_TYPE;
					ack_packetPtr ->header.Debuger_id = DebugerNodeId;
					ack_packetPtr ->header. queryNodeId = call AMPacket.address();
					ack_packetPtr ->header.len = len;					

					ADBG(1, "send ack,  cmd= %d,  Debuger_id = %d, queryNodeId = %d, ackPacketlen = %d\n",
						ack_packetPtr ->header.cmd, ack_packetPtr ->header.Debuger_id, ack_packetPtr ->header. queryNodeId,
						(int)ack_packetPtr ->header.len);
						
					memcpy(ack_packetPtr->data, m_send_buf+from, len);
					
					len += ACKQUERY_CMD_PACKET_HEADER_SIZE;
					m_sending = TRUE;
					
					call ReceiveDiagnose.ackQuery(ack_packetPtr, len);
				}
			}
		}
	}

	event void ReceiveDiagnose.ackQueryDone(ackQuery_cmd_packet_t* packet, error_t error)
	{
		ADBG(1, "ReceiveDiagnose.ackQueryDone, error=%d\n",(int) error);
		atomic {
			m_sending = FALSE;
			post sendNextBuffer();
		}
	}

	event void ReceiveDiagnose.receivedQuery(query_cmd_packet_t* packet, uint8_t len)
	{		
		if(len != QUERY_CMD_PACKET_SIZE ||
		    packet -> cmd != DIAGNOSE_QUERY_CMD_TYPE ||
		    packet -> queryNodeId != call AMPacket.address()){
			return;
		}

		DebugerNodeId = packet->Debuger_id;

		signal DiagnoseQuery.requestData();
	}

	default event void DiagnoseQuery.requestData(){ }
	default event void DiagnoseSendQuery.receivedAck(char* string) { }
}		
