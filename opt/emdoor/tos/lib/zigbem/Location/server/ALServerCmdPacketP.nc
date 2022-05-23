
module ALServerCmdPacketP
{
	provides interface ALServerCmdPacket;
}
implementation
{
	uint8_t m_field_offset = 0;
	uint8_t m_recieve_state = ALSERVER_CMD_STATE_SOF;

	uint8_t m_receiving_index = 0;
	alserver_cmd_packet_t m_receive_packet[2];  /* double buffer receive process */

	uint8_t calcFCS(alserver_cmd_packet_t *packet)
	{
		uint16_t i;
		uint16_t len = packet->len + ALSERVER_CMD_HEADER_SIZE;
		uint8_t *buf = (uint8_t *)packet;
		uint8_t fcs = buf[0];
		for (i=1; i < len; ++i)
		{
			fcs ^= buf[i];
		}


		ADBG(50, "ALServerCmdPacket.calcFCS = 0x%02x\n", (int)fcs);
		

		return fcs;
	}

	task void signalReceivePacket()
	{
		/* Check the packet first... */
		alserver_cmd_packet_t *received_packet = &m_receive_packet[ (1 - m_receiving_index) % 2];
		if (calcFCS(received_packet) == received_packet->fcs)
		{/* valid packet only */
			signal ALServerCmdPacket.receivedPacket(received_packet);
		}
	}


	command error_t ALServerCmdPacket.receiveNext(uint8_t *data, uint16_t len)
	{
		bool ok = FALSE;
		uint16_t offset = 0;
		uint8_t copy_len=0;
		
		while (!ok  &&  (offset < len))
		{
			ok = TRUE;  /* attempt to end the process */

			ADBG(50, "ALServerCmdPacket.receiveNext state=%d, offset=%d, len=%d\n", (int)m_recieve_state, (int)offset, (int)len);
			
			switch (m_recieve_state)
			{
				case ALSERVER_CMD_STATE_SOF:
					{/* find SOF */
						while (offset < len)
						{
							ADBG(50, "ALServerCmdPacket.find SOF, offset=%d, len=%d, data=0x%x\n", (int)offset, (int)len, (int)data[offset]);
							if (data[offset] == ALSERVER_CMD_SOF_ID)
							{/* ok, receive CMD next */
								offset ++;
								m_recieve_state =  ALSERVER_CMD_STATE_HEADER;
								ok =  (offset >= len);
								m_field_offset = 0;
								break;
							}

							offset ++;
						}
					}
					break;
					
				case ALSERVER_CMD_STATE_HEADER:
					{/* receive CMD */

						copy_len = (ALSERVER_CMD_HEADER_SIZE - m_field_offset);

						copy_len = ((len-offset) >= copy_len) ? copy_len : (len-offset);

						if (copy_len > 0)
						{
							memcpy((uint8_t *)(&m_receive_packet[m_receiving_index].cmd)+m_field_offset, data+offset, copy_len);

							m_field_offset += copy_len;
							offset += copy_len;
						}

						if (m_field_offset >= ALSERVER_CMD_HEADER_SIZE)
						{/* receive header over */
							m_recieve_state =  ALSERVER_CMD_STATE_DATA;
							m_field_offset = 0;
							ok = (offset >= len);
						}
					}
					break;

				case ALSERVER_CMD_STATE_DATA:
					{/* receive DATA */

						ADBG(50, "ALServerCmdPacket. receive DATA, offset=%d, len=%d, m_receive_packet[m_receiving_index].len=0x%04x\n", (int)offset, (int)len, (int)m_receive_packet[m_receiving_index].len);
						
						copy_len = (m_receive_packet[m_receiving_index].len - m_field_offset);

						copy_len = ((len-offset) >= copy_len) ? copy_len : (len-offset);

						if (copy_len > 0)
						{
							memcpy(m_receive_packet[m_receiving_index].data+m_field_offset, data+offset, copy_len);

							m_field_offset += copy_len;
							offset += copy_len;
						}

						if (m_field_offset >= m_receive_packet[m_receiving_index].len)
						{/* receive header over */
							m_recieve_state =  ALSERVER_CMD_STATE_FCS;
							m_field_offset = 0;
							ok = (offset >= len);
						}
						
					}
					break;

				case ALSERVER_CMD_STATE_FCS:
					{/* receive FCS */
						if (offset < len)
						{
							m_receive_packet[m_receiving_index].fcs = data[offset];
							offset++;

							/* switch the receiving buffer */
							m_receiving_index = (1 - m_receiving_index) % 2;

							/* signal the event */
							post signalReceivePacket();

							m_recieve_state = ALSERVER_CMD_STATE_SOF; /* Ready to receive the next packet */
						}
					}
					break;
			}
		}
	}
	
	command error_t ALServerCmdPacket.generatePacket(alserver_cmd_packet_t *packet, uint8_t *buf, uint16_t *len)
	{/* convert the packet into a byte stream stored in the buf */
		uint16_t offset = 0;
		
		/*  SOF */
		buf[offset] = ALSERVER_CMD_SOF_ID;
		offset ++;

		/* HEADER */
		memcpy(buf+offset, &(packet->cmd), ALSERVER_CMD_HEADER_SIZE);
		offset += ALSERVER_CMD_HEADER_SIZE;

		/* DATA */
		memcpy(buf+offset, packet->data, packet->len);
		offset += packet->len;

		/* FCS */
		buf[offset] = calcFCS(packet);
		offset++;

		if (len != NULL)
		{
			*len = offset;
		}
		
		return SUCCESS;
	}

	default event void ALServerCmdPacket.receivedPacket(alserver_cmd_packet_t *packet) {}
}

