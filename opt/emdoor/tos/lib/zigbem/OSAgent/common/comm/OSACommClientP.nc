
module OSACommClientP
{
	provides interface StdControl;
	provides interface OSACommClient;

	uses interface StdControl as SubControl;
	uses interface OSAComm;

	uses interface Alarm<T32khz, uint32_t> as BackoffTimer;
	uses interface ActiveMessageAddress;
	uses interface Random;
}
implementation
{
	uint8_t m_cmd = 0;
	uint16_t m_addr = 0x0000;
	osacomm_cmd_t *m_cmd_data = NULL;
	uint8_t m_cmddata_size = 0;


	void signalCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error);

	/*===========================================================*/
	command error_t StdControl.start()
	{
		return call SubControl.start();
	}
	
	command error_t StdControl.stop()
	{
		call BackoffTimer.stop();
		return call SubControl.stop();
	}
	
	

	
	/*===========================================================*/
	/* Send my info */

	task void taskSend()
	{
		error_t result;

		
		if (m_cmd != 0)
		{
			ADBG(6, "BackoffTimer.fired() m_cmd=%d, m_addr=0x%04x, m_cmd_dat=%p, m_cmddata_size=%d\n", (int)m_cmd,
				m_addr, m_cmd_data, (int)m_cmddata_size
			);
			result = call OSAComm.sendCmd(m_addr, m_cmd_data, m_cmddata_size);
			if (result != SUCCESS)
			{
				signalCmdDone(m_addr, m_cmd_data, result);
				m_cmd = 0;
			}
		}
	}
	
	async event void BackoffTimer.fired()
	{
		post taskSend();
		call BackoffTimer.stop();
	}

	error_t doSendCmd(uint16_t addr, osacomm_cmd_t *cmd, uint8_t cmddata_size, bool wait)
	{
		error_t result;
		m_addr = addr;
		m_cmd_data = cmd;
		m_cmddata_size = cmddata_size;
		
		ADBG(6, "m_cmd=%d, m_addr=0x%04x, m_cmd_dat=%p, m_cmddata_size=%d\n", (int)m_cmd,
			m_addr, m_cmd_data, (int)m_cmddata_size
		);

		if (wait)
		{
			uint16_t wait_ms = (call ActiveMessageAddress.amAddress()  * 10 % 500);
			wait_ms = wait_ms + (call Random.rand16() % 500);
			ADBG(6, "doSendCmd and wait=%d\n", wait_ms);
			
			call BackoffTimer.start(wait_ms);  /* 32khz -> ms */
		}
		else
		{/* send immediatly */
			result = call OSAComm.sendCmd(m_addr, m_cmd_data, m_cmddata_size);
			if (result != SUCCESS)
			{
				m_cmd = 0;
			}
		}
		
		return result;
	}
	
	command error_t OSACommClient.sendNodeInfo(uint16_t server_addr, osanode_info_t *node)
	{
		osacomm_cmd_t cmd;
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}
			cmd.cmd = OSACOMM_CMD_SEND_NODE_INFO;
			memcpy(&cmd.cmddata, node, sizeof(osanode_info_t));
			
			m_cmd = OSACOMM_CMD_SEND_NODE_INFO;
		}

		return doSendCmd(server_addr, &cmd, sizeof(osanode_info_t), FALSE);
	}
	
	
	command error_t OSACommClient.downNodeDataAck(uint16_t server_addr, uint8_t *data, uint8_t len)
	{
		osacomm_cmd_t cmd;

		ADBG(6, "OSACommClient.downNodeDataAck, server_addr=0x%04x, len=%d\n", server_addr, (int)len);
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}
			cmd.cmd = OSACOMM_CMD_DOWN_NODE_DATA_ACK;
			
			cmd.cmddata.client.down_node_data_ack.length = len;
			memcpy(cmd.cmddata.client.down_node_data_ack.data, data, len);
			
			m_cmd = OSACOMM_CMD_DOWN_NODE_DATA_ACK;
		}

		return doSendCmd(server_addr, &cmd, sizeof(uint8_t)+len, FALSE);   /* field len + data len */
	}

	void signalCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error)
	{		
		switch (m_cmd)
		{
			case OSACOMM_CMD_SEND_NODE_INFO:
				signal OSACommClient.sendNodeInfoDone(error);
				break;
				
			case OSACOMM_CMD_DOWN_NODE_DATA_ACK:
				signal OSACommClient.downNodeDataAckDone(error);
				break;
		}

		m_cmd = 0;
	}
	
	event void OSAComm.sendCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error)
	{
		signalCmdDone(addr, cmd, error);
	}

	/*===========================================================*/
	void receiveQueryNodes(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		signal OSACommClient.queryNodeInfoFired(addr);
	}
	
	void receiveRunUsrApp(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		signal OSACommClient.runUsrAppFired(addr, &cmd->cmddata.server.run_usr_app);
	}
	
	void receiveDownNodeData(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		signal OSACommClient.downNodeDataFired(addr);
	}
	
	void receiveReboot(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		signal OSACommClient.rebootNodesFired(addr);
	}

	
	event void OSAComm.receivedCmd(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		ADBG(6, "OSAComm.receivedCmd addr=0x%04x, dest_addr=0x%04x cmd=0x%02x\n", addr, dest_addr, (int)cmd->cmd);
		switch (cmd->cmd)
		{
			case OSACOMM_CMD_QUERY_NODES:
				receiveQueryNodes(addr, dest_addr, cmd);
				break;

			case OSACOMM_CMD_RUN_USR_APP:
				receiveRunUsrApp(addr, dest_addr, cmd);
				break;
				
			case OSACOMM_CMD_DOWN_NODE_DATA:
				receiveDownNodeData(addr, dest_addr, cmd);
				break;

			case OSACOMM_CMD_REBOOT:
				receiveReboot(addr, dest_addr, cmd);
				break;
		}
	}

	async event void ActiveMessageAddress.changed()
	{
	}
	/**/
	default event void OSACommClient.sendNodeInfoDone(error_t error) {}
	default event void OSACommClient.downNodeDataAckDone(error_t error) {}
	
	/**/
	default event void OSACommClient.queryNodeInfoFired(uint16_t server_addr) {}
	default event void OSACommClient.runUsrAppFired(uint16_t server_addr, osacomm_cmd_run_app_t * run_usr_app_arg) {}
	default event void OSACommClient.downNodeDataFired(uint16_t server_addr) {}
}

