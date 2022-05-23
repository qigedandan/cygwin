

module OSAServerCmdP
{
	provides interface StdControl;
	provides interface OSAServerCmd;

	uses interface StdControl as OSAServerCmdCommControl;
	uses interface OSAServerCmdComm;
}
implementation
{
	uint8_t m_send_cmd = 0;
	osaserver_cmd_packet_t m_send_packet;
	
	command error_t StdControl.start()
	{
		return call OSAServerCmdCommControl.start();
	}

	command error_t StdControl.stop()
	{
		return call OSAServerCmdCommControl.stop();
	}

	/*=====================================================================*/
	/* PC -> Server */
	
	void receivePingServer(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmd.pingServerFired();
	}
	
	void receiveQueryNodes(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmd.queryNodesFired();
	}

	void receiveRunUsrApp(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmd.runUsrAppFired((osacomm_cmd_run_app_t *)packet->data);
	}

	void receiveDownData(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmd.downDataFired();
	}

	void receiveRebootNodes(osaserver_cmd_packet_t *packet)
	{
		signal OSAServerCmd.rebootNodesFired( *((uint16_t*)packet->data) );
	}
	
	
	event void OSAServerCmdComm.receivedCmdPacket(osaserver_cmd_packet_t *packet, error_t error)
	{
		switch (packet->cmd)
		{
			case OSASERVER_CMD_PING:
				receivePingServer(packet); 
				break;
				
			case OSASERVER_CMD_QUERY_NODES:
				receiveQueryNodes(packet);
				break;

			case OSASERVER_CMD_RUN_USR_APP:
				receiveRunUsrApp(packet);
				break;

			case OSASERVER_CMD_DOWN_DATA:
				receiveDownData(packet);
				break;

			case OSASERVER_CMD_REBOOT_NODES:
				receiveRebootNodes(packet);
				break;
			
		}
	}

	
	default event void OSAServerCmd.pingServerFired() {}
	default event void OSAServerCmd.queryNodesFired() {}
	default event void OSAServerCmd.runUsrAppFired(osacomm_cmd_run_app_t *run_arg) {}
	default event void OSAServerCmd.downDataFired() {}
	default event void OSAServerCmd.rebootNodesFired(uint16_t addr) {}

	/*=====================================================================*/
	/* Server -> PC */

	error_t doSendPacket(uint16_t cmd)
	{
		error_t result;
		result = call OSAServerCmdComm.sendCmdPacket(&m_send_packet);

		if (result != SUCCESS)
		{
			m_send_cmd = 0;
		}

		/* FIXME: because no sendDone event now... */
		m_send_cmd = 0;

		return result;
	}

	command error_t OSAServerCmd.pingServerAck(osaserver_cmd_server_info_t *server_info)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = OSASERVER_CMD_PING_ACK;
		}

		m_send_packet.cmd = OSASERVER_CMD_PING_ACK;
		m_send_packet.len = sizeof(osaserver_cmd_server_info_t);
		memcpy(m_send_packet.data, server_info, sizeof(osaserver_cmd_server_info_t));

		return doSendPacket(m_send_cmd);
	}
	
	command error_t OSAServerCmd.sendNodeInfo(osanode_info_t *node_info)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = OSASERVER_CMD_NODE_INFO_ACK;
		}

		m_send_packet.cmd = OSASERVER_CMD_NODE_INFO_ACK;
		m_send_packet.len = sizeof(osanode_info_t);
		memcpy(m_send_packet.data, node_info, sizeof(osanode_info_t));

		return doSendPacket(m_send_cmd);
	}

	

	command error_t OSAServerCmd.downDataAck(uint8_t *data, int8_t len)
	{		
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = OSASERVER_CMD_DOWN_DATA_ACK;
		}

		m_send_packet.cmd = OSASERVER_CMD_DOWN_DATA_ACK;
		m_send_packet.len = len;
		memcpy(m_send_packet.data, data, len);

		return doSendPacket(m_send_cmd);
	}

	command error_t OSAServerCmd.downDataResult(uint8_t result)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = OSASERVER_CMD_DOWN_DATA_RESULT;
		}

		m_send_packet.cmd = OSASERVER_CMD_DOWN_DATA_RESULT;
		m_send_packet.len = sizeof(result);
		memcpy(m_send_packet.data, &result, sizeof(result));

		return doSendPacket(m_send_cmd);
	}
	
	
	


	
	
	event void OSAServerCmdComm.sendCmdPacketDone(osaserver_cmd_packet_t *packet, error_t error)
	{
		switch (m_send_cmd)
		{
			case OSASERVER_CMD_PING_ACK:
				signal OSAServerCmd.pingServerAckDone(error);
				break;

			case OSASERVER_CMD_NODE_INFO_ACK:
				signal OSAServerCmd.sendNodeInfoDone(error);
				break;

			case OSASERVER_CMD_DOWN_DATA_ACK:
				signal OSAServerCmd.downDataAckDone(error);
				break;
		}

		m_send_cmd = 0;
	}
	
	default event void OSAServerCmd.pingServerAckDone(error_t error) {}
	default event void OSAServerCmd.sendNodeInfoDone(error_t error) {}
	default event void OSAServerCmd.downDataAckDone(error_t error) {}
	default event void OSAServerCmd.downDataResultDone(error_t error) {}
}


