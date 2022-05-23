
#include "OSARF.h"
#include "OSAComm.h"


module OSACommServerP
{
	provides interface StdControl;
	provides interface OSACommServer;

	uses interface StdControl as SubControl;
	uses interface OSAComm;
}
implementation
{
	uint8_t m_cmd = 0;

	/*===========================================================*/
	command error_t StdControl.start()
	{
		return call SubControl.start();
	}
	
	command error_t StdControl.stop()
	{
		return call SubControl.stop();
	}
	
	/*===========================================================*/

	error_t doSendCmd(uint16_t addr, osacomm_cmd_t *cmd, uint8_t cmddata_size)
	{
		error_t result;
		result = call OSAComm.sendCmd(addr, cmd, cmddata_size);
		if (result != SUCCESS)
		{
			m_cmd = 0;
		}

		return result;
	}
	
	command error_t OSACommServer.queryNodes(uint16_t server_addr, uint16_t addr)
	{
		osacomm_cmd_t cmd;
		
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}

			m_cmd = OSACOMM_CMD_QUERY_NODES;
		}
		
		cmd.cmd = OSACOMM_CMD_QUERY_NODES;
		cmd.cmddata.server.query_nodes.server_addr = server_addr;

		return doSendCmd(addr, &cmd, sizeof(cmd.cmddata.server.query_nodes));
	}

	command error_t OSACommServer.runUsrApp(uint16_t server_addr, uint16_t addr, osacomm_cmd_run_app_t *arg)
	{
		osacomm_cmd_t cmd;
		
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}

			m_cmd = OSACOMM_CMD_RUN_USR_APP;
		}
		
		cmd.cmd = OSACOMM_CMD_RUN_USR_APP;
		memcpy(&cmd.cmddata.server.run_usr_app, arg, sizeof(cmd.cmddata.server.run_usr_app));

		return doSendCmd(addr, &cmd, sizeof(cmd.cmddata.server.run_usr_app));
	}
	
	command error_t OSACommServer.downNodeData(uint16_t server_addr, uint16_t addr)
	{
		osacomm_cmd_t cmd;
		
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}

			m_cmd = OSACOMM_CMD_DOWN_NODE_DATA;
		}
		
		cmd.cmd = OSACOMM_CMD_DOWN_NODE_DATA;
		cmd.cmddata.server.down_node_data.server_addr = server_addr;

		return doSendCmd(addr, &cmd, sizeof(cmd.cmddata.server.down_node_data));
	}

	command error_t OSACommServer.rebootNodes(uint16_t server_addr, uint16_t addr)
	{
		osacomm_cmd_t cmd;
		
		atomic {
			if (m_cmd != 0)
			{
				return EBUSY;
			}

			m_cmd = OSACOMM_CMD_REBOOT;
		}
		
		cmd.cmd = OSACOMM_CMD_REBOOT;
		cmd.cmddata.server.reboot_nodes.server_addr = server_addr;

		return doSendCmd(addr, &cmd, sizeof(cmd.cmddata.server.reboot_nodes));

	}


	event void OSAComm.sendCmdDone(uint16_t addr, osacomm_cmd_t *cmd, error_t error)
	{
		switch (m_cmd)
		{
			case OSACOMM_CMD_QUERY_NODES:
				signal OSACommServer.querNodesDone(error);
				break;
			case OSACOMM_CMD_RUN_USR_APP:
				signal OSACommServer.runUsrAppDone(error);
				break;
			case OSACOMM_CMD_DOWN_NODE_DATA:
				signal OSACommServer.downNodeDataDone(error);
				break;
			case OSACOMM_CMD_REBOOT:
				signal OSACommServer.rebootNodesDone(error);
				break;
		}

		m_cmd = 0;
	}

	/*===========================================================*/


	void receiveNodeInfo(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		signal OSACommServer.receiveNodeInfo(addr, dest_addr, & cmd->cmddata.client.node_info );
	}
	
	void receiveDownNodeDataAck(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		uint8_t len;
		
		signal OSACommServer.downNodeDataAck(
			addr, 
			cmd->cmddata.client.down_node_data_ack.data, 
			cmd->cmddata.client.down_node_data_ack.length
		);
	}
	
	event void OSAComm.receivedCmd(uint16_t addr, uint16_t dest_addr, osacomm_cmd_t *cmd)
	{
		ADBG(6, "OSAComm.receivedCmd addr=0x%04x, cmd=0x%02x\n", addr, (int)cmd->cmd);
		switch (cmd->cmd)
		{
			case OSACOMM_CMD_SEND_NODE_INFO:
				receiveNodeInfo(addr, dest_addr, cmd);
				break;
				
			case OSACOMM_CMD_DOWN_NODE_DATA_ACK:
				receiveDownNodeDataAck(addr, dest_addr, cmd);
				break;
		}
	}
	
	/*===========================================================*/
	default event void OSACommServer.querNodesDone(error_t error) {}
	default event void OSACommServer.runUsrAppDone(error_t error) {}
	default event void OSACommServer.downNodeDataDone(error_t error) {}
	default event void OSACommServer.rebootNodesDone(error_t error) {}

	
	/**/
	default event void OSACommServer.receiveNodeInfo(uint16_t addr, uint16_t dest_addr, osanode_info_t *node)  {}
	default event void OSACommServer.downNodeDataAck(uint16_t addr, uint8_t *data, uint8_t len)  {}
}

