

module ALServerCmdP
{
	provides interface StdControl;
	provides interface ALServerCmd;

	uses interface StdControl as ALServerCmdCommControl;
	uses interface ALServerCmdComm;
}
implementation
{
	uint8_t m_send_cmd = 0;
	alserver_cmd_packet_t m_send_packet;
	
	command error_t StdControl.start()
	{
		return call ALServerCmdCommControl.start();
	}

	command error_t StdControl.stop()
	{
		return call ALServerCmdCommControl.stop();
	}

	/*=====================================================================*/
	/* PC -> Server */
	
	void receivePingServer(alserver_cmd_packet_t *packet)
	{
		signal ALServerCmd.pingServerFired();
	}
	
	void receiveSetRefNodesLoc(alserver_cmd_packet_t *packet)
	{
		alserver_setRefNodesLoc  m_pack ;
		memcpy(&m_pack,packet,sizeof(alserver_cmd_packet_t));
		signal ALServerCmd.setRefNodesLocFired(m_pack.own_packet.addr , m_pack.own_packet.loc_x , m_pack.own_packet.loc_y);
	}

	void receiveSetBliNodeLocAuto(alserver_cmd_packet_t *packet)
	{
		alserver_setBliNodeLocAuto  m_pack ;
		memcpy(&m_pack,packet,sizeof(alserver_cmd_packet_t));
		signal ALServerCmd.setBliNodeLocAutoFired(m_pack.own_packet.addr , m_pack.own_packet.flag );
	}

	void receiveReqBliNodeLoc(alserver_cmd_packet_t *packet)
	{
		alserver_reqBliNodeLoc  m_pack ;
		memcpy(&m_pack,packet,sizeof(alserver_cmd_packet_t));
		signal ALServerCmd.reqBliNodeLocFired( m_pack.own_packet.addr );
	}

	void receiveSetAdjAuto(alserver_cmd_packet_t *packet)
	{
		alserver_setAdjAuto  m_pack ;
		memcpy(&m_pack,packet,sizeof(alserver_cmd_packet_t));
		signal ALServerCmd.setAdjAutoFired( m_pack.own_packet.addr , m_pack.own_packet.loc_x , m_pack.own_packet.loc_y);
	}
	
       void receiveSetAdjImm(alserver_cmd_packet_t *packet)
	{
		alserver_setAdjImm  m_pack ;
		memcpy(&m_pack,packet,sizeof(alserver_cmd_packet_t));
		signal ALServerCmd.setAdjImmFired( m_pack.own_packet.addr , m_pack.own_packet.para_a , m_pack.own_packet.para_n);
	}  
	
	void receiveQueryRef(alserver_cmd_packet_t *packet)
	{
		signal ALServerCmd.queryRefFired();
	}

	void receiveQueryBlind(alserver_cmd_packet_t *packet)
	{
		signal ALServerCmd.queryBlindFired();
	}
	
	event void ALServerCmdComm.receivedCmdPacket(alserver_cmd_packet_t *packet, error_t error)
	{
		switch (packet->cmd)
		{
			case ALSERVER_CMD_PING:
				receivePingServer(packet); 
				break;

			case ALSERVER_CMD_REF_NODE:
				
				receiveSetRefNodesLoc(packet);
				break;

			case ALSERVER_CMD_BLI_NODE_AUTO:
				receiveSetBliNodeLocAuto(packet);
				break;

			case ALSERVER_CMD_REQ_BLI_NODE:
				receiveReqBliNodeLoc(packet);
				break;

			case ALSERVER_CMD_ADJ_AUTO:
				receiveSetAdjAuto(packet);
				break;
                
			case ALSERVER_CMD_ADJ_IMM:
				receiveSetAdjImm(packet);
				break;

			case ALSERVER_CMD_QUERY_REF:
				receiveQueryRef(packet);
				break;
				
			case ALSERVER_CMD_QUERY_BLIND:
				receiveQueryBlind(packet);
				break;
                
		}
	}

	
	default event void ALServerCmd.pingServerFired() {}
	default event void ALServerCmd.setRefNodesLocFired(uint16_t addr,uint16_t px,uint16_t py) {}
	default event void ALServerCmd.setBliNodeLocAutoFired(uint16_t addr,uint8_t flag) {}
	default event void ALServerCmd.reqBliNodeLocFired(uint16_t addr) {}
	default event void ALServerCmd.setAdjAutoFired(uint16_t addr,uint16_t px,uint16_t py) {}
       default event void ALServerCmd.setAdjImmFired(uint16_t addr,uint8_t param_a,uint8_t param_n) {}
       default event void ALServerCmd.queryRefFired() {}
	default event void ALServerCmd.queryBlindFired() {}

	/*=====================================================================*/
	/* Server -> PC */

	error_t doSendPacket(uint16_t cmd)
	{
		error_t result;
		result = call ALServerCmdComm.sendCmdPacket(&m_send_packet);

		if (result != SUCCESS)
		{
			m_send_cmd = 0;
		}

		/* FIXME: because no sendDone event now... */
		m_send_cmd = 0;

		return result;
	}

	command error_t ALServerCmd.pingServerAck(alserver_cmd_server_info_t *server_info)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ALSERVER_CMD_PING_ACK;
		}

		m_send_packet.cmd = ALSERVER_CMD_PING_ACK;
		m_send_packet.len = sizeof(alserver_cmd_server_info_t);
		memcpy(m_send_packet.data, server_info, sizeof(alserver_cmd_server_info_t));

		return doSendPacket(m_send_cmd);
	}
	
	command error_t ALServerCmd.sendBlindNodeInfo(blind_node_info_t *node_info)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ALSERVER_CMD_BLI_NODE_ACK;
		}

		m_send_packet.cmd = ALSERVER_CMD_BLI_NODE_ACK;
		m_send_packet.len = sizeof(blind_node_info_t);
		memcpy(m_send_packet.data, node_info, sizeof(blind_node_info_t));

		return doSendPacket(m_send_cmd);
	}
	
    command error_t ALServerCmd.sendRefNodeInfo(ref_node_info_t  *node_info)
	{
		atomic {
			if (m_send_cmd != 0)
			{
				return EBUSY;
			}
			m_send_cmd = ALSERVER_CMD_REF_NODE_ACK;
		}

		m_send_packet.cmd = ALSERVER_CMD_REF_NODE_ACK;
		m_send_packet.len = sizeof(ref_node_info_t);
		memcpy(m_send_packet.data, node_info, sizeof(ref_node_info_t));

		return doSendPacket(m_send_cmd);
	}
    
	event void ALServerCmdComm.sendCmdPacketDone(alserver_cmd_packet_t *packet, error_t error)
	{
		switch (m_send_cmd)
		{
			case ALSERVER_CMD_PING_ACK:
				signal ALServerCmd.pingServerAckDone(error);
				break;

			case ALSERVER_CMD_REF_NODE_ACK:
				signal ALServerCmd.sendRefNodeInfoDone(error);
				break;

			case ALSERVER_CMD_BLI_NODE_ACK:
				signal ALServerCmd.sendBlindNodeInfoDone(error);
				break;
		}

		m_send_cmd = 0;
	}
	
	default event void ALServerCmd.pingServerAckDone(error_t error) {}
    default event void ALServerCmd.sendBlindNodeInfoDone(error_t error) {}
    default event void ALServerCmd.sendRefNodeInfoDone(error_t error) {}
}


