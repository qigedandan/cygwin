

module ASServerCmdP
{
	provides interface StdControl;
	provides interface ASServerCmd;

	uses interface StdControl as AtpCmdCommControl;
 	uses interface AtpCmdComm;
}
implementation
{
	uint8_t m_send_cmd = 0;
	atp_cmd_packet_t m_send_packet;
	
	command error_t StdControl.start()
	{
		return call AtpCmdCommControl.start();
	}

	command error_t StdControl.stop()
	{
		return call AtpCmdCommControl.stop();
	}

	/*=====================================================================*/
	/* PC -> Server */
	
	void receivePingServer(atp_cmd_packet_t *packet)
	{
		signal ASServerCmd.pingServerFired();
	}
	
	void receiveStart(atp_cmd_packet_t *packet)
	{
		signal ASServerCmd.StartFired();
	}

	void receiveStop(atp_cmd_packet_t *packet)
	{
		signal ASServerCmd.StopFired();
	}

	void receiveSetChannel(atp_cmd_packet_t *packet)
	{
		signal ASServerCmd.setChannelFired( packet->data[0]);
	}
	
	event void AtpCmdComm.receivedCmdPacket(atp_cmd_packet_t *packet, error_t error)
	{
		switch (packet->cmd)
		{
			case ASSERVER_CMD_PING:
				receivePingServer(packet); 
				break;

			case ASSERVER_CMD_START:
				receiveStart(packet);
				break;

			case ASSERVER_CMD_STOP:
				receiveStop(packet);
				break;

			case ASSERVER_CMD_SET_CHANNEL:
				receiveSetChannel(packet);
				break;
		}
	}

	
	default event void ASServerCmd.pingServerFired() {}
	default event void ASServerCmd.StartFired() {}
	default event void ASServerCmd.StopFired() {}
	default event void ASServerCmd.setChannelFired(uint8_t channel) {}

	/*=====================================================================*/
	/* Server -> PC */

	error_t doSendPacket(uint16_t cmd)
	{
		error_t result;
		result = call AtpCmdComm.sendCmdPacket(&m_send_packet);

		if (result != SUCCESS)
		{
			m_send_cmd = 0;
		}

		/* FIXME: because no sendDone event now... */
		m_send_cmd = 0;

		return result;
	}

	command error_t ASServerCmd.pingServerAck()
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ASSERVER_CMD_PING_ACK;
		}

		m_send_packet.cmd = ASSERVER_CMD_PING_ACK;
		m_send_packet.len = 0;
		
		return doSendPacket(m_send_cmd);
	}
	
	command error_t ASServerCmd.StartAck(error_t error)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ASSERVER_CMD_START_ACK;
		}

		m_send_packet.cmd = ASSERVER_CMD_START_ACK;
		m_send_packet.len = sizeof(error_t);
		memcpy(m_send_packet.data, &error, sizeof(error_t));

		return doSendPacket(m_send_cmd);
	}
	
    command error_t ASServerCmd.StopAck(error_t error)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ASSERVER_CMD_STOP_ACK;
		}

		m_send_packet.cmd = ASSERVER_CMD_STOP_ACK;
		m_send_packet.len = sizeof(error_t);
		memcpy(m_send_packet.data, &error, sizeof(error_t));

		return doSendPacket(m_send_cmd);
	}
	
	command error_t ASServerCmd.setChannelAck(uint8_t channel)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ASSERVER_CMD_SET_CHANNEL_ACK;
		}

		m_send_packet.cmd = ASSERVER_CMD_SET_CHANNEL_ACK;
		m_send_packet.len = sizeof(uint8_t);
		memcpy(m_send_packet.data,&channel, sizeof(uint8_t));

		return doSendPacket(m_send_cmd);
	}

	command error_t ASServerCmd.ReportSniffData(asserver_ReportPacket *m_asserver_packet)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ASSERVER_CMD_REPROT_SNIFF_DATA;
		}

		m_send_packet.cmd = ASSERVER_CMD_REPROT_SNIFF_DATA;
		m_asserver_packet->comm_packet.len = m_asserver_packet->own_packet.rf_length + ASSERVER_SNIFF_DATA_HEADER_SIZE ;
        m_send_packet.len = m_asserver_packet->comm_packet.len;
		memcpy(m_send_packet.data,m_asserver_packet->comm_packet.data,m_send_packet.len);

		return doSendPacket(m_send_cmd);
	}
    
	event void AtpCmdComm.sendCmdPacketDone(atp_cmd_packet_t *packet, error_t error)
	{
		switch (m_send_cmd)
		{
			case ASSERVER_CMD_PING_ACK:
				signal ASServerCmd.pingServerAckDone(error);
				break;

			case ASSERVER_CMD_START_ACK:
				signal ASServerCmd.StartAckDone(error);
				break;

			case ASSERVER_CMD_STOP_ACK:
				signal ASServerCmd.StopAckDone(error);
				break;
				
			case ASSERVER_CMD_SET_CHANNEL_ACK:
				signal ASServerCmd.setChannelAckDone(error);
				break;
				
			case ASSERVER_CMD_REPROT_SNIFF_DATA:
				signal ASServerCmd.ReportSniffDataDone(error);
				break;	
		}

		m_send_cmd = 0;
	}
	
        default event void ASServerCmd.pingServerAckDone(error_t error) {}
    	default event void ASServerCmd.StartAckDone(error_t error) {}
    	default event void ASServerCmd.StopAckDone(error_t error) {}
    	default event void ASServerCmd.setChannelAckDone(error_t error) {}
    	default event void ASServerCmd.ReportSniffDataDone(error_t error) {}
}


