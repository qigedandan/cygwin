#include "QuickRoute.h"

generic module QuickRouteSenderP(uint8_t am_id)
{
	provides {
		interface Send;
	}

	uses {
		interface AMSend;

		interface Packet;
		interface AMPacket;
		interface CC2420Packet;

		interface QuickRouteEngine;
		interface QuickRouteEngineEvent;

		interface CoreControlOwner;
	}
}
implementation
{
	
	enum 
	{
		QUICKROUTE_SENDER_NONE,
		QUICKROUTE_SENDER_ROUTE,
		QUICKROUTE_SENDER_DATA,
	};
	
	uint8_t m_quickroute_state = QUICKROUTE_SENDER_NONE;
	uint8_t m_quickroute_try_times = 0;

	
	message_t *m_msg= NULL;
	bool m_msg_sending = FALSE;
	error_t m_msg_send_result;


	error_t updateRoute();
	void doSendDone(bool result);
	task void trySend();

	
	/*===  ===*/
	task void updateRouteTask()
	{
		if (call QuickRouteEngine.updateEmptyRoute(1000) != SUCCESS)
		{
			/* ???? */
			m_quickroute_state = QUICKROUTE_SENDER_NONE;
			doSendDone(FAIL);
		}
	}

	error_t updateRoute()
	{
		ADBG(100, "QuickRouteSenderP.updateRoute m_quickroute_try_times = %d\n", (int)m_quickroute_try_times);
		
		if (++m_quickroute_try_times > QUICK_ROUTE_TRY_TIMES)
		{/* max try, drop */
			doSendDone(FAIL);
		}
		else
		{
			atomic m_quickroute_state = QUICKROUTE_SENDER_ROUTE;
			post updateRouteTask();
		}
	}

	event void QuickRouteEngineEvent.routeUpdateDone(error_t result)
	{
		ADBG(100, "QuickRouteEngineEvent.routeUpdateDone result=%d\n", (int)result);
		atomic
		{
			if (!m_msg_sending || m_quickroute_state!=QUICKROUTE_SENDER_ROUTE)
			{
				return;
			}
		}

		if (result == SUCCESS)
		{			
			post trySend();
		}
		else
		{/* fail, try again */
			updateRoute();
		}
	}
	
	/*===  ===*/
	error_t m_send_result = FAIL;
	task void sendDoneTask()
	{
		atomic
		{
			if (!m_msg_sending) return;
		}

		signal Send.sendDone(m_msg, m_msg_send_result);
		
		atomic 
		{
			m_msg_sending = FALSE;
			m_quickroute_state = QUICKROUTE_SENDER_NONE;
		}
	}
	
	void doSendDone(error_t result)
	{
		atomic {
			m_msg_send_result = result;
		}
		
		post sendDoneTask();

		call CoreControlOwner.setFree(0);
	}


	/*===  ===*/
	task void trySend()
	{
		atomic
		{
			if (!m_msg_sending) return;			
		}

		ADBG(100, "QuickRouteSenderP.trySend\n");

		/* select route first */
		if (call QuickRouteEngine.selectRoute(m_msg) != SUCCESS)
		{/* sorry, no route now */
			updateRoute();
			return;
		}

		atomic m_quickroute_state = QUICKROUTE_SENDER_DATA;
		if (call AMSend.send(call AMPacket.destination(m_msg), m_msg, call Packet.payloadLength(m_msg))
		!= SUCCESS)
		{
			doSendDone(FAIL);
		}
	}


	event void AMSend.sendDone(message_t* msg, error_t error)
	{
		atomic
		{
			if (!m_msg_sending) return;
		}

		if (error == SUCCESS)
		{
			doSendDone(error);
		}
		else
		{/* send fail, try to update route and send again? */
			call QuickRouteEngine.invalidCurrentRoute();
			post trySend();
		}
	}


	/*=== Send ===*/
	command error_t Send.send(message_t* msg, uint8_t len)
	{
		ADBG(100, "Send.send m_msg_sending=%d\n", (int)m_msg_sending);
		atomic
		{
			if (m_msg_sending) return FAIL;
		}

		call CoreControlOwner.setBusy(0);

		m_msg = msg;
		m_msg_sending = TRUE;
		atomic m_quickroute_try_times = 0;
		post trySend();

		return SUCCESS;
	}
	
	command error_t Send.cancel(message_t* msg)
	{
		return SUCCESS;
	}

	command uint8_t Send.maxPayloadLength()
	{
		return call AMSend.maxPayloadLength();
	}

	command void *Send.getPayload(message_t* msg)
	{
		return ((uint8_t *)call Packet.getPayload(msg, NULL));
	}

	default event void Send.sendDone(message_t* msg, error_t error) {}

	event void QuickRouteEngineEvent.routeFail()
	{
	}
}	


