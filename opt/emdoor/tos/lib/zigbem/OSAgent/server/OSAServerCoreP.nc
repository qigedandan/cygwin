#include "OSAClientCore.h"
#include "OSAServerCore.h"

module OSAServerCoreP
{
	provides interface Init;
	provides interface StdControl as CoreControl;
	
	/* OSAgent Communication */
	uses interface StdControl as OSACommServerControl;
	uses interface OSACommServer;

	/* PC&Server Command */
	uses interface StdControl as OSAServerCmdControl;
	uses interface OSAServerCmd;

	/* OSAUsrApp */
	uses interface OSAUsrApp;
	
	/* ActiveMessageAddress */
	uses interface ActiveMessageAddress;
}
implementation
{
	osaserver_state_t m_state;

	/*========================================================*/
	/* proto */
	task void doCmdPingServer();
	task void doCmdQueryNodes();
	task void doCmdRunUsrApp();
	task void doCmdDownData();
	task void doCmdRebootNodes();
	
	void cmdNodeInfo(osanode_info_t *info);

	task void commQueryNodes();
	task void commOneQueryNodes();
	task void commRunUsrApp();

	/* download process */
	task void commDownDataBegin();
	task void commDownDataNext();
	task void commDownDataEnd();
	task void commRebootNodes();



	/*========================================================*/
	/* Core */
	command error_t Init.init()
	{
		ADBG(9, "OSAServerCoreP.Init.init\n");
		atomic {
			/* Init state values */
			memset(&m_state, 0, sizeof(m_state));
			m_state.server_addr = call ActiveMessageAddress.amAddress();
			
			/* Init  */
			call OSAUsrApp.setAsOSA();//¿ªÆôÖÐ¶Ï
		}

		
		return SUCCESS;
	}

	
	/* just for testing */

	void TEST()
	{
		osanode_info_t info;

		info.id = 0x0002;
		info.state = OSACLIENT_RUN_AGENT_FREE;
		info.error = 0;
		
		/*post doCmdPingServer();*/
		cmdNodeInfo(&info);
	}

	command error_t CoreControl.start()
	{
		call OSACommServerControl.start();
		call OSAServerCmdControl.start();

		/* Send ack information at startup */
		post doCmdPingServer();

		/* Query nodes at once */
		post commQueryNodes();
		
		return SUCCESS;
	}
	
	command error_t CoreControl.stop()
	{
		call OSACommServerControl.stop();
		call OSAServerCmdControl.stop();
		return SUCCESS;
	}

	/*========================================================*/
	/* Node List Control, often used before download data */

	void nodeListPrint()
	{
		uint16_t i;
		ADBG(9, "nodeListPrint ==========\n", i, m_state.node_list[i]);
		for (i=0; i < m_state.node_count; ++i)
		{
			ADBG(9, "nodeListPrint %d=0x%04x\n", i, m_state.node_list[i]);
		}
		ADBG(9, "====================\n\n", i, m_state.node_list[i]);
	}
	
	void nodeListClear()
	{
		atomic m_state.node_count = 0;
	}

	void nodeListAdd(uint16_t addr)
	{
		atomic {
			uint16_t i;
			if (addr == 0x0000 || addr == 0xFFFF)
			{/* not a valid address */
				return;
			}

			
			for (i=0; i < m_state.node_count; ++i)
			{
				if (m_state.node_list[i] == addr)
				{/* found... */
					return;
				}
			}

			/* not exists, add... */
			m_state.node_count = m_state.node_count % OSASERVER_MAX_NODE_LIST;
			m_state.node_list[m_state.node_count] = addr;
			m_state.node_count = (m_state.node_count + 1) % OSASERVER_MAX_NODE_LIST;
		}

		nodeListPrint();
	}

	/*========================================================*/
	/* RF Error control */
	bool isServerMaxRfError()
	{
		return (m_state.rf_error_count > OSASERVER_MAX_RF_ERROR);
	}
	void addServerRfError()
	{
		m_state.rf_error_count++;
	}

	void resetServerRfError()
	{
		m_state.rf_error_count = 0;
	}

	/* CMD Error control */
	bool isServerMaxCmdError()
	{
		return (m_state.cmd_error_count > OSASERVER_MAX_CMD_ERROR);
	}

	void addServerCmdError()
	{
		m_state.cmd_error_count++;
	}

	void resetServerCmdError()
	{
		m_state.cmd_error_count = 0;
	}

	
	/*========================================================*/
	/* PC&Server Command */

	/* ping */
	task void doCmdPingServer()
	{
		osaserver_cmd_server_info_t server_info;
		ADBG(9, "OSAServerCoreP.pingServerAck()\n");

		server_info.server_addr = call ActiveMessageAddress.amAddress();
		
		if (call OSAServerCmd.pingServerAck(&server_info) != SUCCESS
			&&  !isServerMaxCmdError())
		{
			ADBG(6, "OSAServerCoreP.pingServerAck() error \n");
			addServerCmdError();
			post doCmdPingServer();
		}
		else
		{
			resetServerCmdError();
		}
	}
	
	event void OSAServerCmd.pingServerFired()
	{
		post doCmdPingServer();
	}

	/* query */
	task void doCmdQueryNodes()
	{
		//nodeListPrint();

		
		nodeListClear(); /* clear all node list */
		
		resetServerRfError();
		post commQueryNodes();
	}

	void cmdNodeInfo(osanode_info_t *info)
	{
		call OSAServerCmd.sendNodeInfo(info);
	}
	
	event void OSAServerCmd.queryNodesFired()
	{
		ADBG(6, "OSAServerCoreP.queryNodesFired()\n");
		post doCmdQueryNodes();
	}


	/* run */
	task void doCmdRunUsrApp()
	{
		resetServerRfError();
		post commRunUsrApp();
	}

	event void OSAServerCmd.runUsrAppFired(osacomm_cmd_run_app_t *run_arg)
	{
		memcpy(&m_state.run_arg, run_arg, sizeof(m_state.run_arg));
		post doCmdRunUsrApp();
	}


	/* down */
	task void doCmdDownData()
	{
		resetServerRfError();
		/* start to down from the first node.. */
		m_state.node_down_len = 0;
		post commDownDataBegin();
	}
	
	void cmdDownData(uint8_t *data, int len)
	{
		m_state.node_down_len += len;
		call OSAServerCmd.downDataAck(data, len);
	}
	
	event void OSAServerCmd.downDataFired()
	{
		post doCmdDownData();
	}

	task void doCmdDownDataResult()
	{
		call OSAServerCmd.downDataResult(0);  /* TODO: add a real result code. */
	}

	/* PC&Server Command Done */
	event void OSAServerCmd.pingServerAckDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerCmdError();
		} else {
			addServerCmdError();
			post doCmdPingServer();
		}
	}
	
	event void OSAServerCmd.sendNodeInfoDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerCmdError();
		} else {
			addServerCmdError();
		}
	}

	event void OSAServerCmd.downDataAckDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerCmdError();
		} else {
			addServerCmdError();
		}
	}

	event void OSAServerCmd.downDataResultDone(error_t error)
	{
	}

	task void doCmdRebootNodes()
	{
		post commRebootNodes();
	}

	
	event void OSAServerCmd.rebootNodesFired(uint16_t addr)
	{
		m_state.reboot_node = addr;
		post doCmdRebootNodes();
	}

	
	/*========================================================*/
	/* OSAgent Communication */
	task void commQueryNodes()
	{
		if (call OSACommServer.queryNodes(call ActiveMessageAddress.amAddress(), AM_BROADCAST_ADDR) != SUCCESS
		&&  !isServerMaxRfError())
		{
			post commQueryNodes();
		}
		else
		{
			resetServerRfError();
		}
	}
	
	task void commOneQueryNodes()
	{
		if (m_state.one_query_node != 0x0000)
		{
			if (call OSACommServer.queryNodes(call ActiveMessageAddress.amAddress(), m_state.one_query_node) != SUCCESS
			&&  !isServerMaxRfError())
			{
				addServerRfError();
				post commOneQueryNodes();
			}
		}
	}

	
	task void commRunUsrApp()
	{		
		if (call OSACommServer.runUsrApp(call ActiveMessageAddress.amAddress(), AM_BROADCAST_ADDR, &m_state.run_arg) != SUCCESS
		&&  !isServerMaxRfError())
		{
			addServerRfError();
			post commRunUsrApp();
		}
	}

	task void commDownDataBegin()
	{
		ADBG(6, "commDownDataBegin\n");


		m_state.downloading = TRUE;
		m_state.node_down_index = 0;
		m_state.node_download_request = FALSE;

		
		post commDownDataNext();
	}
	
	task void commDownDataNext()
	{
		ADBG(6, "commDownDataNext index=%d, count=%d\n", (int)m_state.node_down_index, (int)m_state.node_count);

		atomic {
			if (m_state.node_download_request)
			{
				return;
			}

			m_state.node_download_request = TRUE;
		}
		
		if (m_state.node_down_index < m_state.node_count)
		{/* has node to download */
			uint16_t addr = m_state.node_list[m_state.node_down_index];

			ADBG(6, "commDownDataNext current address=0x%04x\n", addr);
			
			if (addr == 0x0000 || addr == 0xFFFF)
			{/* not a valid address, move to the next address */
				m_state.node_down_index++;
				post commDownDataNext();
			}
			else
			{
				if (call OSACommServer.downNodeData(call ActiveMessageAddress.amAddress(), addr) != SUCCESS)
				{/* try some times to download it */
					if (!isServerMaxRfError())
					{/* fail, download it again */
						addServerRfError();
						post commDownDataNext();
					}
					else
					{/* max error reach, move to the next one */
						resetServerRfError();
						m_state.node_down_index++;
						post commDownDataNext();
					}
				}
			}
		}
		else
		{/* All nodes downloaded... */
			post commDownDataEnd();
		}
	}

	task void commDownDataEnd()
	{/*  */
		m_state.downloading = FALSE;
		m_state.node_down_index = 0;
		post doCmdDownDataResult();
	}

	task void commRebootNodes()
	{
		if (call OSACommServer.rebootNodes(call ActiveMessageAddress.amAddress(), m_state.reboot_node) != SUCCESS
		&&  !isServerMaxRfError())
		{
			addServerRfError();
			post commRebootNodes();
		}
	}

	
	event void OSACommServer.querNodesDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerRfError();
		} else {
			addServerRfError();

			if (!isServerMaxRfError()) {
				if (m_state.one_query == 1)
				{
					post commOneQueryNodes();
				}
				else
				{
					post commQueryNodes();
				}
			}
		}
	}
	event void OSACommServer.runUsrAppDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerRfError();
		} else {
			addServerRfError();

			if (!isServerMaxRfError()){
				post commRunUsrApp();
			}
		}
	}
	event void OSACommServer.downNodeDataDone(error_t error)
	{
		if (error == SUCCESS) {
			resetServerRfError();
		} else {
			addServerRfError();
			
			if (!isServerMaxRfError()) {
				post commDownDataNext();
			}
		}

	}

	event void OSACommServer.receiveNodeInfo(uint16_t addr,uint16_t dest_addr, osanode_info_t *node)
	{/* ack with node info */
		if (dest_addr == AM_BROADCAST_ADDR)
		{/* Node information from broacast address, it mean's this guy doesn't know the server by now, query to it again */
			m_state.one_query_node = addr;
			m_state.one_query = TRUE;
			post commOneQueryNodes();
		}
		else
		{
			m_state.one_query = FALSE;
			
			ADBG(6, "OSACommServer.receiveNodeInfo downloading=%d, addr=0x%04x, node_down_index=0x%04x, state=%d, node=0x%04x\n",
			(int)m_state.downloading, addr, m_state.node_down_index, (int)node->state, m_state.node_list[m_state.node_down_index]
			);
			atomic {
				if (m_state.downloading 
				&& (addr == m_state.node_list[m_state.node_down_index])
				&& (node->state != OSACLIENT_RUN_AGENT_UPLOAD)
				)
				{/* for download process, this node send node info without a upload state, indicate that this node has finished uploading, so move to the next one */
					m_state.node_down_index++;
					m_state.node_download_request = FALSE;
					post commDownDataNext();
				}
			}

		
			/* add to the server node list */
			nodeListAdd(addr);

			cmdNodeInfo(node);
		}
	}
	
	event void OSACommServer.downNodeDataAck(uint16_t addr, uint8_t *data, uint8_t len)
	{
		m_state.node_download_request = FALSE;
		cmdDownData(data, len);
		/* request the next data... */
		post commDownDataNext();
	}

	event void OSACommServer.rebootNodesDone(error_t error)
	{	
		if (error == SUCCESS) {
			resetServerRfError();
		} else {
			addServerRfError();

			if (!isServerMaxRfError()) {
				post commRebootNodes();
			}
		}
	}


	/*========================================================*/
	async event void ActiveMessageAddress.changed()
	{
	}
}

