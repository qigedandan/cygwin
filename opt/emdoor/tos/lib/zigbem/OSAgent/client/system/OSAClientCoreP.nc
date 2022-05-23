#include "OSAClientCore.h"



module OSAClientCoreP
{
	provides interface Init;

	/* System */
	uses interface Boot;
	uses interface OSAMain;
	uses interface OSAMainControl;

	/* OSAgent Communication */
	uses interface StdControl as OSACommClientControl;
	uses interface OSACommClient;

	/* User App Control */
	uses interface OSAUsrApp;

	/* Logger Control */
	uses interface OSALogger;

	/* ActiveMessageAddress */
	uses interface ActiveMessageAddress;

	/* RealTimer Control */
	uses interface RealTimer<TMilli, uint32_t> as RealTimerOSA;
	uses interface RealTimer<TMilli, uint32_t> as RealTimerUser;

	/* OSARun Control Timer */
	uses interface Timer<TMilli> as OSARunControlTimer;

	/* Special: WatchDog Control, to reboot the system */
	uses interface WatchDog;
}
implementation
{
	/* state control */
	osaclient_state_t m_state;

	/*========================================================*/
	
	task void sendNodeInfo();
	
	task void runUsrApp();
	
	task void uploadNextData();
	task void uploadEnd();
	

	/*========================================================*/
	/* Core */
	command error_t Init.init()
	{
		ADBG(9, "OSAClientCoreP.Init.init\n");
		atomic {
			/* Init state values */
			memset(&m_state, 0, sizeof(m_state));

			m_state.server_addr = 0x0000;
			m_state.run_state = OSACLIENT_RUN_AGENT_FREE;
			
			/* Init  */
			call OSAUsrApp.setAsOSA();
		}

		
		return SUCCESS;
	}

	
	event void Boot.booted()
	{
		call OSARunControlTimer.stop();
		/* Start comm engine */
		call OSACommClientControl.start();
		
		ADBG(9, "OSAClientCoreP.Boot.booted\n");

		/* Send my node info */
		post sendNodeInfo();
	}

	void getMyNodeInfo(osanode_info_t *info)
	{
		atomic {
			info->id = call ActiveMessageAddress.amAddress();
			info->state = m_state.run_state;
			info->error = 0;
			info->program_time = m_state.program_time;
			info->log_size = call OSALogger.count();
		}
	}


	/*========================================================*/

	task void runUsrApp()
	{
		ADBG(6, "OSAClientCoreP.runUsrApp\n");
		call OSAUsrApp.setAsUsrApp();

		/* Set the run period */
		if (m_state.run_time_set > 0)
		{
			call OSARunControlTimer.startOneShot(m_state.run_time_set);
		}

		/* Before run the User application, copy the time from OSARealTimer to continue real time..*/

		ADBG(6, "RealTimerOSA : 0x%lx\n", call RealTimerOSA.getTime());
		call RealTimerUser.setTime( call RealTimerOSA.getTime() );
		ADBG(6, "RealTimerUser : 0x%lx\n", call RealTimerUser.getTime());
		

		call OSAMain.runUsrApp();
	}

	/* run time expired.. */
	event void OSARunControlTimer.fired()
	{/* end user app */
		call OSAMain.endUsrApp();
	}

	event void OSAMainControl.beforeUsrAppRun(error_t error)
	{
	}
	event void OSAMainControl.afterUsrAppRun(error_t error)
	{
	}
	
	event void OSAMainControl.beforeUsrAppEnd(error_t error)
	{
	}

	event void OSAMainControl.afterUsrAppEnd(error_t error)
	{
		m_state.program_time = call RealTimerUser.getTime();
	
		ADBG(6, "OSAMainControl.afterUsrAppEnd\n");
		atomic m_state.run_state = OSACLIENT_RUN_AGENT_END_USR_APP;
		call OSAUsrApp.setAsOSA();

		call RealTimerOSA.setTime( call RealTimerUser.getTime() );

		/* come back to OSAClientCore again :) */
		/* send my information to Server again */
		ADBG(10, "OSAMainControl.afterUsrAppEnd\n");
		post sendNodeInfo();
	}

	/*========================================================*/
	/* Error control */
	bool isClientMaxError()
	{
		return (m_state.error_count > OSACLIENT_MAX_ERROR);
	}

	void addClientError()
	{
		m_state.error_count++;

		if (isClientMaxError())
		{
			ADBG(10, "MAX ERROR=%d\n", (int)m_state.error_count);
		}
		
	}

	void resetClientError()
	{
		m_state.error_count = 0;
	}
	
	/*========================================================*/
	/* Comm cmd control */

	task void sendNodeInfo()
	{
		osanode_info_t info;

		ADBG(6, "OSAClientCoreP.sendNodeInfo()\n");
		if (m_state.server_addr == 0x0000)
		{/* No server avaible now, just broadcast my information */
			m_state.server_addr = AM_BROADCAST_ADDR;
		}

		getMyNodeInfo(&info);

		if (call OSACommClient.sendNodeInfo(m_state.server_addr, &info) != SUCCESS
		&&  !isClientMaxError())
		{
			ADBG(6, "OSAClientCoreP.sendNodeInfo() error \n");
			addClientError();
			post sendNodeInfo();
		}
	}
	
	event void OSACommClient.queryNodeInfoFired(uint16_t server_addr)
	{
		ADBG(6, "OSAClientCoreP.OSACommClient.queryNodeInfoFired\n");
		atomic {
			if (m_state.server_addr != server_addr)
			{
				m_state.server_addr  = server_addr;
			}
		}
		
		resetClientError();
		post sendNodeInfo();
	}

	event void OSACommClient.runUsrAppFired(uint16_t server_addr, osacomm_cmd_run_app_t *arg)
	{	
		ADBG(6, "OSAClientCoreP.OSACommClient.runUsrAppFired\n");
		atomic {
			if (m_state.server_addr != server_addr)
			{
				m_state.server_addr  = server_addr;
			}
		}


		/* After received the command from the server, I must start the OSARealTimer immediatly */
		call RealTimerOSA.setTime(0x00000000);
		
		atomic m_state.run_state = OSACLIENT_RUN_USR_APP;
		m_state.m_launch_usr_app = TRUE;  /* about to start User App */

		/* set run period */
		m_state.run_time_set = arg->run_time;
		
		resetClientError();

		post sendNodeInfo();
	}


	/**/
	event void OSACommClient.sendNodeInfoDone(error_t error)
	{
		atomic {
		ADBG(6, "OSAClientCoreP.sendNodeInfoDone() error =%d, m_state.m_launch_usr_app=%d, m_state.m_launch_upload=%d\n", 
			(int)error,
			(int)m_state.m_launch_usr_app,
			(int)m_state.m_launch_upload
			);
		if (error == SUCCESS)
		{
			resetClientError();

			ADBG(6, "OSAClientCoreP.sendNodeInfoDone error=SUCCESS\n");

			if (m_state.m_launch_usr_app)
			{
				ADBG(6, "OSAClientCoreP.sendNodeInfoDone m_launch_usr_app\n");
				m_state.m_launch_usr_app = FALSE;
				post runUsrApp();
			}
			else if (m_state.m_launch_upload)
			{
				ADBG(6, "OSAClientCoreP.sendNodeInfoDone m_launch_usr_app\n");
				m_state.m_launch_upload = FALSE;
				post uploadNextData();
			}
		}
		else if (!isClientMaxError())
		{
			ADBG(6, "OSAClientCoreP.sendNodeInfoDone error!=SUCCESS !isClientMaxError()\n");
			addClientError();
			post sendNodeInfo();
		} else {
			/*  should stop running user app after max error reach */
			if (m_state.m_launch_usr_app)
			{
				m_state.m_launch_usr_app = FALSE;
			}
			
			if (m_state.m_launch_upload)
			{
				m_state.m_launch_upload = FALSE;
			}
			resetClientError();
		}
		}
	}

	/*========================================================*/
	/* Data Upload control */

	task void uploadNextData()
	{
		uint8_t *data = NULL;
		atomic {
			m_state.upload_len = OSACLIENT_UPLOAD_DATA_SIZE; /* Try to get the max size */

			call OSALogger.seek(m_state.upload_offset, OSALOGGER_SEEK_SET); 
			
			data = call OSALogger.get(&m_state.upload_len); 

			ADBG(6, "uploadNextData upload_offset=%ld, upload_len=%ld, count=%ld, position=%ld\n", 
				m_state.upload_offset,
				m_state.upload_len,
				call OSALogger.count(),
				call OSALogger.readPosition()
				);

			if (data != NULL  &&  m_state.upload_len > 0)
			{/* has data */
				call OSACommClient.downNodeDataAck(m_state.server_addr, data, (uint8_t)m_state.upload_len);
			}
			else
			{/* NO data, end... */
				post uploadEnd();
			}
		}
	}

	task void uploadEnd()
	{
				ADBG(6, "uploadNextData End upload_offset=%ld, upload_len=%ld, count=%ld, position=%ld\n", 
				m_state.upload_offset,
				m_state.upload_len,
				call OSALogger.count(),
				call OSALogger.readPosition()
				);
		ADBG(6, "uploadNextData End\n");
		m_state.run_state = OSACLIENT_RUN_AGENT_END_USR_APP; /* FIXME: it's true everytime to back to this state... */
		m_state.upload_offset = 0;
		m_state.upload_len = 0;

		resetClientError();
		post sendNodeInfo();  /* Report my info to the server */
	}
	
	event void OSACommClient.downNodeDataFired(uint16_t server_addr)
	{
		ADBG(6, "downNodeDataFired\n");

		if (m_state.run_state ==  OSACLIENT_RUN_AGENT_UPLOAD)
		{/* Already uploading..just continue */
			m_state.upload_offset += m_state.upload_len;
			post uploadNextData();
		}
		else
		{
			/* according to the server request, I should upload data now! */
			m_state.server_addr = server_addr;
			m_state.run_state = OSACLIENT_RUN_AGENT_UPLOAD;
			
			m_state.upload_offset = 0; /* goto the beginning of the Log */
			m_state.m_launch_upload = TRUE;
			
			post sendNodeInfo();  /* Send node information to the server first. The upload will be launched in the sendNodeInfoDone. */
		}
	}
	
	event void OSACommClient.downNodeDataAckDone(error_t error)
	{
		atomic {
			if (error == SUCCESS)
			{/* OK, upload next data */
				resetClientError();
			}
			else
			{/* fail! */
				addClientError();
			}
		}
	}

	event void OSACommClient.rebootNodesFired(uint16_t server_addr)
	{
		/* according to the server command, I reboot my system now! */
		call WatchDog.resetCpu();
	}

	
	/*========================================================*/
	/*  */
	async event void ActiveMessageAddress.changed()
	{
	}

}

