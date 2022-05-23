#include "QuickRoute.h"

module QuickRouteEngineP
{
	provides {
		interface Init;
		interface RootControl;
		interface QuickRouteEngine;
		interface QuickRouteEngineEvent;
	}

	uses {
		interface AMSend as RouteBeaconSend;
		interface Receive as RouteBeaconReceive;
		
		interface AMSend as RouteRequestSend;
		interface Receive as RouteRequestReceive;
		
		interface Packet;
		interface AMPacket;
		interface CC2420Packet;
		interface Random;

		interface Timer<TMilli> as RouteUpdateTimeout;
		interface Timer<TMilli> as RouteAutoUpdateTimer;

		interface Packet as DataPacket;
	}
}
implementation
{
	enum {
		ROUTE_INVALID = 0xff,
		BASE_STATION = 1,
		MAX_COST = 165,   /* XLQ, when exceed, we try not to select this one... */
	};

	quickroute_table_entry_t  m_route_table[QUICK_ROUTE_TABLE_SIZE];

	uint16_t m_parent;
	uint16_t m_parent_cost;
	uint8_t   m_hopcount = ROUTE_INVALID;
	bool m_root = FALSE;
	bool m_route_sent = FALSE;

	bool m_beacon_sending = FALSE;
	message_t m_beacon_msg;

	bool m_request_sending = FALSE;
	message_t m_request_msg;

	uint8_t m_seqno = 0;

	/*=======route fail======*/
	task void routeFail()
	{
		signal QuickRouteEngineEvent.routeFail();
	}
	
	/*=== route table ====*/
	void printRouteTable()
	{
		uint8_t i;

		ADBG(100, "route table\n");

		for(i=0; i < QUICK_ROUTE_TABLE_SIZE; i++)
		{
			if (m_route_table[i].used)
			{
				ADBG(100, "[%d], addr:%d, cost:%d, hopcount:%d\n",
					(int)i,
					m_route_table[i].addr,
					(int)m_route_table[i].link_cost,
					(int)m_route_table[i].hopcount
				);
			}
		}
	}
	
	bool isRouteTableEmpty()
	{
		uint8_t i;

		for(i=0; i < QUICK_ROUTE_TABLE_SIZE; i++)
		{
			if (m_route_table[i].used)
			{
				return FALSE;
			}
		}

		return TRUE;
	}
	
	void resetRouteTable()
	{
		uint8_t i;

		for(i=0; i < QUICK_ROUTE_TABLE_SIZE; i++)
		{
			m_route_table[i].addr = TOS_BCAST_ADDR;
			m_route_table[i].link_cost = 0xffff;
			m_route_table[i].hopcount = ROUTE_INVALID;
			m_route_table[i].used = FALSE;
		}
	}

	void resetParent()
	{
		if (m_root)
		{		
			m_parent = call AMPacket.address();
			m_parent_cost = 0;
			m_hopcount = 0;
		}
		else
		{
			m_parent = TOS_BCAST_ADDR;
			m_parent_cost = 0x7fff;
			m_hopcount = ROUTE_INVALID;
		}
	}

	
	uint16_t getCost(uint8_t lqi)
	{
		return (uint16_t)0xFF - (uint16_t)lqi;
	}

	int getRouteEntry(uint16_t addr)
	{
		uint8_t i;
		for (i=0; i < QUICK_ROUTE_TABLE_SIZE; ++i)
		{
			if (m_route_table[i].used && m_route_table[i].addr == addr)
			{
				return i;
			}
		}

		return -1;
	}

	void updateRouteTable(quickroute_table_entry_t *entry)
	{/* */
		uint8_t i, hopcount = 0;
		int index = -1;
		uint16_t cost = 0;

		index = getRouteEntry(entry->addr);

		ADBG(DBG_LEV, "getRouteEntry %d\n", (int)index);
		
		if (index >= 0)
		{/* exists, replace */
			memcpy(&(m_route_table[index]), entry, sizeof(m_route_table[0]));
			m_route_table[index].used = (entry->hopcount != ROUTE_INVALID && entry->parent != ROUTE_INVALID);
			return;
		}
		
		for(i=0; i < QUICK_ROUTE_TABLE_SIZE; ++i)
		{
			if(m_route_table[i].used == FALSE)
			{
				memcpy(&(m_route_table[i]), entry, sizeof(quickroute_table_entry_t));
				m_route_table[i].used = TRUE;
				return;  /* found */
			}
			else {
				if( m_route_table[i].hopcount > hopcount ||( m_route_table[i].hopcount == hopcount && m_route_table[i].link_cost > cost))
				{
					hopcount = m_route_table[i].hopcount;
					cost = m_route_table[i].link_cost;
					
					index = i; /* record the min */
				}
			}
		}

		if (index >= 0 && index < QUICK_ROUTE_TABLE_SIZE)
		{/* no empty, replace the worst entry */
			if( entry->hopcount < hopcount ||( entry->hopcount == hopcount && entry->link_cost < cost))
			{
				memcpy(&(m_route_table[index]), entry, sizeof(quickroute_table_entry_t));
				m_route_table[index].used = TRUE;
			}
		}
	}

	void killCurrentParent()
	{
		uint8_t i;
		for (i = 0; i <QUICK_ROUTE_TABLE_SIZE; ++i)
		{
			if ((m_route_table[i].used == TRUE)
			&&  (m_route_table[i].addr == m_parent)
			)
			{
				m_route_table[i].used = FALSE;
			}
		}

		resetParent();
	}

	
	/**/
	task void routeChanged()
	{
		signal QuickRouteEngineEvent.routeFail();
	}

	error_t chooseParent()
	{
		uint8_t i;
		int index = -1;
		uint8_t hopcount = 0xff;
		uint16_t  cost = 0xffff;

		printRouteTable();


		/* first choice, choose the smallest hopcount with valid cost */
		for (i = 0; i < QUICK_ROUTE_TABLE_SIZE; ++i)
		{
			if (m_route_table[i].used == TRUE
			&& 
				(m_route_table[i].link_cost < MAX_COST)
			&&
				(m_route_table[i].hopcount < hopcount 
				||
				 (m_route_table[i].hopcount == hopcount 
				 && m_route_table[i].link_cost < cost
				 )
				)
			)
			{
				hopcount = m_route_table[i].hopcount;
				cost = m_route_table[i].link_cost;
				index = i;
			}
		}

		ADBG(DBG_LEV, "after first choice, index=%d\n", (int)index);

		if (index < 0)
		{/* second choice, choose the smallest hopcount without cost condition... */
			
			hopcount = 0xff;
			cost = 0xffff;
			
			for (i = 0; i < QUICK_ROUTE_TABLE_SIZE; ++i)
			{
				if (m_route_table[i].used == TRUE
				&& 
					(m_route_table[i].hopcount < hopcount 
					||
					 (m_route_table[i].hopcount == hopcount 
					 && m_route_table[i].link_cost < cost
					 )
					)
				)
				{
					hopcount = m_route_table[i].hopcount;
					cost = m_route_table[i].link_cost;
					index = i;
				}
			}
		}
		ADBG(DBG_LEV, "after second choice, index=%d\n", (int)index);

		if(index >= 0)
		{
			m_parent = m_route_table[index].addr;
			m_parent_cost = m_route_table[index].link_cost;
			m_hopcount = m_route_table[index].hopcount + 1;
			ADBG(100, "new parent selected, new parent = %d, currentCost = %d, currentHopCount= %d\n", (int)m_parent, (int)m_parent_cost, (int)m_hopcount);
			return SUCCESS;
		}

		/* It's not to add this here :( */
		if (!call QuickRouteEngine.isEmptyRoute())
		{/* when change from valid route to empty */
			post routeFail();
		}
		
		resetParent();
		
		return FAIL;
	}

	void prepareRouteUpdate()
	{
		atomic
		{
			resetParent();
			resetRouteTable();
			m_route_sent = FALSE;
		}
	}

	/*====  routeUpdateDone ====*/
	
	task void routeUpdateDoneSuccess()
	{
		signal QuickRouteEngineEvent.routeUpdateDone(SUCCESS);

		// LED_YELLOW_ON;
	}
	
	task void routeUpdateDoneFail()
	{
		signal QuickRouteEngineEvent.routeUpdateDone(FAIL);
	}

	/*====  Request ====*/
	task void sendRouteRequestTask()
	{
		quickroute_request_msg_t *header = (quickroute_request_msg_t*)call Packet.getPayload(&m_request_msg, NULL);
		ADBG(100, "sendRouteRequestTask() m_request_sending=%d\n", (int)m_request_sending);
		atomic
		{
			if (m_request_sending)
			{
				return;
			}
		}

		header->seqno = 0;
		atomic m_request_sending = TRUE;
		if (call RouteRequestSend.send(TOS_BCAST_ADDR, &m_request_msg,  sizeof(quickroute_request_msg_t))
		!= SUCCESS
		)
		{
			atomic m_request_sending = FALSE;
		}
	}


	/*====  Beacon ====*/
	task void sendRouteBeaconTask() 
	{
		quickroute_beacon_msg_t* header = (quickroute_beacon_msg_t*)call Packet.getPayload(&m_beacon_msg, NULL);

		ADBG(100, "sendRouteBeaconTask() m_beacon_sending=%d\n", (int)m_beacon_sending);

		atomic
		{
			if (m_beacon_sending)
			{
				return;
			}
		}
		
		if (m_root)
		{
			header->seqno = 0;
			header->parent = call AMPacket.address();
			header->parent_cost = 0;
			header->hopcount = 0;
		}
		else
		{/* send my route information whenever my parent exists? */
			header->seqno = 0;
			header->parent = m_parent;
			header->parent_cost = m_parent_cost;
			header->hopcount = m_hopcount;
		}

		atomic m_beacon_sending = TRUE;
		
		if (call RouteBeaconSend.send(TOS_BCAST_ADDR, &m_beacon_msg,  sizeof(quickroute_beacon_msg_t))
			!= SUCCESS
		)
		{
			atomic m_beacon_sending = FALSE;
		}
	}

	error_t sendRouteBeacon(uint16_t dest_addr)
	{
		atomic
		{
			if (m_beacon_sending)
			{
				return FAIL;
			}
		}
		
		((quickroute_beacon_msg_t*)call Packet.getPayload(&m_beacon_msg, NULL))->dest_addr = dest_addr;
	
		post sendRouteBeaconTask();

		return SUCCESS;
	}

	error_t ackRouteRequest(uint16_t dest_addr)
	{
		if (  m_root
		||  (m_parent > 0  &&  m_parent != TOS_BCAST_ADDR)
		)
		{//only root and valid node can respond the request
			return sendRouteBeacon(dest_addr);
		}
		
		return FAIL;
	}

	
	/**/
	event void RouteRequestSend.sendDone(message_t* msg, error_t success)
	{
		atomic m_request_sending = FALSE;
	}
	
	event void RouteBeaconSend.sendDone(message_t* msg, error_t success)
	{
		atomic m_beacon_sending = FALSE;
	}
	


	event message_t* RouteRequestReceive.receive(message_t* msg, void* payload, uint8_t len)
	{
		ADBG(100, "RouteRequestReceive.receive addr=%d\n", call AMPacket.source(msg));

		ackRouteRequest(TOS_BCAST_ADDR);

		return msg;
	}
	
	event message_t* RouteBeaconReceive.receive(message_t* msg, void* payload, uint8_t len)
	{
		quickroute_beacon_msg_t* beacon = (quickroute_beacon_msg_t*)payload;
		uint16_t cost = getCost(call CC2420Packet.getLqi(msg));

		ADBG(100,"\n\n-----------------------\nreceived RouteInfo Msg from node %d, lqi=%d, hopcount=%d, m_hopcount=%d\n", (int)call AMPacket.source(msg),  (int)cost, (int)beacon->hopcount, (int)m_hopcount);
		
		if (m_root)
		{
			return msg;
		}
		else
		{
			quickroute_table_entry_t entry;
			entry.addr = call AMPacket.source(msg);
			entry.link_cost = cost;
			entry.parent = beacon->parent;
			entry.parent_cost = beacon->parent_cost;
			entry.hopcount = beacon->hopcount;
			
		
			if (beacon->parent != call AMPacket.address()
			&&
				((m_hopcount == ROUTE_INVALID)
				|| (beacon->hopcount < m_hopcount))
			)
			{ //try to prevent cycles
				updateRouteTable(&entry);
				if (chooseParent() == SUCCESS)
				{
					call RouteUpdateTimeout.stop();
					post routeUpdateDoneSuccess();
				}
			}

			return msg;
		}
	}

	/*========*/
	command error_t Init.init()
	{
		if (call AMPacket.address() == BASE_STATION)
		{
			m_root = TRUE;
		}

		resetRouteTable();
		resetParent();

		ADBG(100, "[I am root=%d]\n", (int)m_root);
		
		return SUCCESS;
	}

	command error_t RootControl.setRoot()
	{
		m_root = TRUE;
		return SUCCESS;
	}

	command error_t RootControl.unsetRoot()
	{
		m_root = FALSE;
		return SUCCESS;
	}

	command bool RootControl.isRoot()
	{
		return m_root;
	}
	/*========*/
	
	
	command void QuickRouteEngine.resetRoute()
	{
		resetRouteTable();
	}

	command uint16_t QuickRouteEngine.getParent()
	{
		return m_parent;
	}

	command bool QuickRouteEngine.isEmptyRoute()
	{
		return isRouteTableEmpty();
	}
	
	command error_t QuickRouteEngine.updateEmptyRoute(uint32_t timeout_ms)
	{
		if (!call RootControl.isRoot() && isRouteTableEmpty())
		{/**/
			post sendRouteRequestTask();
			
			call RouteUpdateTimeout.startOneShot(timeout_ms);

			// LED_YELLOW_TOGGLE;

			return SUCCESS;
		}

		return FAIL;  /* no a empty route */
	}

	command error_t QuickRouteEngine.selectRoute(message_t* msg)
	{
		if (chooseParent() == SUCCESS)
		{
			call AMPacket.setDestination(msg, m_parent);
			return SUCCESS;
		}

		return FAIL;
	}

	command void QuickRouteEngine.broadcastFailRoute()
	{//When fail, broadcastFailRoute
		sendRouteBeacon(TOS_BCAST_ADDR);
	}

	
	command void QuickRouteEngine.invalidCurrentRoute()
	{
		killCurrentParent();
	}

	
	command void QuickRouteEngine.initializeFields(message_t* msg)
	{		
		quickroute_data_header_t* header = (quickroute_data_header_t*)call DataPacket.getPayload(msg, NULL);

		header->orgi_addr = call AMPacket.address();
		header->second_addr = call AMPacket.address();
		header->seqno = m_seqno++;
		header->hop_real = 1;
		header->hop_est = m_hopcount;
	}


	command quickroute_data_header_t *QuickRouteEngine.getRouteDataHeader(message_t *msg)
	{
		return (quickroute_data_header_t *)call DataPacket.getPayload(msg, NULL);
	}

	event void RouteUpdateTimeout.fired()
	{
		post routeUpdateDoneFail();
	}


	/* When forwarding a message, do something on the route layer */
	command bool QuickRouteEngine.forwardProcess(message_t *msg)
	{
		uint8_t len = call Packet.payloadLength(msg);
		quickroute_data_header_t *data_header = (quickroute_data_header_t *)call DataPacket.getPayload(msg, NULL);

		/*STEP1:  route loop check ?????*/
		if (data_header->orgi_addr == call AMPacket.address()
			||data_header->orgi_addr == call QuickRouteEngine.getParent()
			||call AMPacket.source(msg) == call QuickRouteEngine.getParent()
		)
		{
			call QuickRouteEngine.invalidCurrentRoute();

			return FALSE;
		}

		/*STEP2:   I am the node parent for the orginal node */
		if (data_header->hop_real == 1)
		{
			data_header->second_addr = call AMPacket.address();
		}

		/*STEP3:   increase real hop count? */
		data_header->hop_real ++;

		return TRUE;
	}


	command void QuickRouteEngine.enableRouteAutoUpdate(uint32_t interval)
	{
		call RouteAutoUpdateTimer.startPeriodic(interval);
	}

	
	command void QuickRouteEngine.disableRouteAutoUpdate()
	{
		call RouteAutoUpdateTimer.stop();
	}

	event void RouteAutoUpdateTimer.fired()
	{
		call QuickRouteEngine.updateEmptyRoute(1000);  //timeout : 1s
	}


	default event void QuickRouteEngineEvent.routeUpdateDone(error_t result) {}
}	

