

includes AM;
includes MultiHop;


#define MULTI_HOP_DEBUG 1

module MultiHopEWMA {

  provides {
    interface Init;
    interface StdControl;
    interface RouteSelect;
    interface RouteControl;
   // command void set_power_mode(uint8_t mode);
  }

  uses {
    interface Timer<TMilli>;
    //interface ReceiveMsg;
    interface Receive;
    interface Intercept as Snoop[uint8_t id];
    //interface SendMsg;
    interface Send as SendMsg;
    interface Send as DebugSendMsg;
    interface Leds;
/*
#ifdef USE_WATCHDOG
	interface StdControl as PoochHandler;
	interface WDT;
#endif
*/
    interface AMPacket;
    interface Packet;
    interface CC2420Packet;
  }
}

implementation {
  enum {
    NBRFLAG_VALID    = 0x01,
    NBRFLAG_NEW      = 0x02,
    NBRFLAG_EST_INIT = 0x04
  };

  enum {
    BASE_STATION_ADDRESS        = 1,
    ROUTE_TABLE_SIZE            = 16,
    ESTIMATE_TO_ROUTE_RATIO     = 5,
    ACCEPTABLE_MISSED           = -20,
#ifndef ROUTE_UPDATE_INTERVAL
#ifdef TEN_X
    ROUTE_UPDATE_INTERVAL      = 36000,
#else
    ROUTE_UPDATE_INTERVAL      = 360000,
#endif
#endif
    SWITCH_THRESHOLD     	    = 192,
    MAX_ALLOWABLE_LINK_COST     = 256*6,
    LIVELINESS              	= 2,
    MAX_DESCENDANT		        = 5

  };

  enum {
    ROUTE_INVALID    = 0xff
  };

  enum {
    SEND_TRUST = 2
  };

  struct SortEntry {
    uint16_t id;
    uint8_t  receiveEst;
  };

  struct SortDbgEntry {
    uint16_t id;
    uint8_t  sendEst;
    uint8_t  hopcount; 
  };

  typedef struct RPEstEntry {
    uint16_t id;
    uint8_t receiveEst;
  } __attribute__ ((packed)) RPEstEntry;

  typedef struct RoutePacket {
    uint16_t parent;
    uint16_t cost;
    uint8_t estEntries;
    RPEstEntry estList[1];
  } __attribute__ ((packed)) RoutePacket;


  typedef struct TableEntry {
    uint16_t id;  
    uint16_t parent;
    uint16_t cost;
    uint8_t childLiveliness;
    uint16_t missed;
    uint16_t received;
    int16_t lastSeqno;
    uint8_t flags;
    uint8_t liveliness;
    uint8_t hop;
    uint8_t receiveEst;
    uint8_t sendEst;
  } TableEntry;

  message_t debugMsg; 
  message_t routeMsg; 
  bool gfSendRouteBusy;

  TableEntry BaseStation;
  TableEntry NeighborTbl[ROUTE_TABLE_SIZE];
  TableEntry *gpCurrentParent;
  uint8_t gbCurrentHopCount;
  uint16_t gbCurrentCost;
  int16_t gCurrentSeqNo;
  uint16_t gwEstTicks;
  uint32_t gUpdateInterval;
  uint8_t power_mode;
  bool gSelfTimer;
  bool gFirstStart;

  uint8_t descendant_route[128];   
/*
  command void set_power_mode(uint8_t mode){
	power_mode = mode;
  }
*/

   void showNeighborTbl()
   {
       int i = 0;

       //XDBG(0, "dump NeighborTbl\r\n");
       
       for (i=0; i < ROUTE_TABLE_SIZE; i++)
       {
           if (NeighborTbl[i].flags & NBRFLAG_VALID)
           {
                ADBG(1, "%d, id=%x, parent=%x, cost=%x, childLiveliness=%x", 
                         ADBG_N(i), ADBG_N(NeighborTbl[i].id), 
                         ADBG_N(NeighborTbl[i].parent), ADBG_N(NeighborTbl[i].cost), ADBG_N(NeighborTbl[i].childLiveliness));

                ADBG(1, ", missed=%x, lastSeqno=%x, flags=%x, liveliness=%x, hop=%x, receiveEst=%x, sendEst=%x", 
                        ADBG_N(NeighborTbl[i].missed), ADBG_N(NeighborTbl[i].lastSeqno), ADBG_N(NeighborTbl[i].flags), ADBG_N(NeighborTbl[i].liveliness),
                        ADBG_N(NeighborTbl[i].hop), ADBG_N(NeighborTbl[i].receiveEst), ADBG_N(NeighborTbl[i].sendEst)
                        );

	     }
       }
   }
   
    uint16_t next_sequence_number(){
    //XDBG(0, "next_sequence_number, power_mode=");
    
      
    //if(power_mode == 0){
    	gCurrentSeqNo++;
    	if(gCurrentSeqNo == 0) gCurrentSeqNo = 1;
    	return gCurrentSeqNo;
    //}else{
//	return 0;
   // }
  }

   
  uint8_t findEntry(uint8_t id) {
    uint8_t i = 0;
    for (i = 0; i < ROUTE_TABLE_SIZE; i++) {
      if ((NeighborTbl[i].flags & NBRFLAG_VALID) && NeighborTbl[i].id == id) {
        return i;
      }
    }
    return ROUTE_INVALID;
  }
  
  
  uint8_t findEntryToBeReplaced() {
    uint8_t i = 0;
    uint8_t minSendEst = -1;
    uint8_t minSendEstIndex = ROUTE_INVALID;
    for (i = 0; i < ROUTE_TABLE_SIZE; i++) {
      if ((NeighborTbl[i].flags & NBRFLAG_VALID) == 0) {
      //empty slot
        return i;
      }

      //find the minimal send est
      if (minSendEst >= NeighborTbl[i].sendEst) {
        minSendEst = NeighborTbl[i].sendEst;
        minSendEstIndex = i;
      }
    }
    return minSendEstIndex;
  }

  
  void newEntry(uint8_t indes, uint16_t id) {
    NeighborTbl[indes].id = id;
    NeighborTbl[indes].flags = (NBRFLAG_VALID | NBRFLAG_NEW);
    NeighborTbl[indes].liveliness = 0;
    NeighborTbl[indes].parent = ROUTE_INVALID;
    NeighborTbl[indes].cost = ROUTE_INVALID;
    NeighborTbl[indes].childLiveliness = 0;
    NeighborTbl[indes].hop = ROUTE_INVALID;
    NeighborTbl[indes].missed = 0;
    NeighborTbl[indes].received = 0;
    NeighborTbl[indes].receiveEst = 0;
    NeighborTbl[indes].sendEst = 0;
    
  }

  //find exists, otherwise add new and return
  uint8_t findPreparedIndex(uint16_t id) {
    uint8_t indes = findEntry(id);
    if (indes == (uint8_t) ROUTE_INVALID) {
      indes = findEntryToBeReplaced();
      newEntry(indes, id);
    }
    return indes;
  }


  int sortByReceiveEstFcn(const void *x, const void *y) {
    struct SortEntry *nx = (struct SortEntry *) x;
    struct SortEntry *ny = (struct SortEntry *) y;
    uint8_t xReceiveEst = nx->receiveEst, yReceiveEst = ny->receiveEst;
    if (xReceiveEst > yReceiveEst) return -1;
    if (xReceiveEst == yReceiveEst) return 0;
    if (xReceiveEst < yReceiveEst) return 1;
    return 0; 
  }

  int sortDebugEstFcn(const void *x, const void *y) {
    struct SortDbgEntry *nx = (struct SortDbgEntry *) x;
    struct SortDbgEntry *ny = (struct SortDbgEntry *) y;
    uint8_t xReceiveEst = nx->sendEst, yReceiveEst = ny->sendEst;
    if (xReceiveEst > yReceiveEst) return -1;
    if (xReceiveEst == yReceiveEst) return 0;
    if (xReceiveEst < yReceiveEst) return 1;
    return 0; 
  }


//?????????????????????????
  uint32_t evaluateCost(uint16_t cost, uint8_t sendEst, uint8_t receiveEst) {
    uint32_t transEst = (uint32_t) sendEst * (uint32_t) receiveEst;
    uint32_t immed = ((uint32_t) 1 << 24);

    if (transEst == 0) return ((uint32_t) 1 << (uint32_t) 16);
    
    immed = immed / transEst;
    immed += ((uint32_t) cost << 6);
    return immed;
  }


  void updateEst(TableEntry *Nbr) {
    uint16_t usExpTotal, usActTotal, newAve;

    if (Nbr->flags & NBRFLAG_NEW)  return;
    //?????
    usExpTotal = ESTIMATE_TO_ROUTE_RATIO >> 1;
    usExpTotal = 1;
    //?????

    //XDBG(DBG_ROUTE,"MultiHopEWMA: Updating Nbr %d. ExpTotl = %d, rcvd= %d, missed = %d\n", Nbr->id, usExpTotal, Nbr->received, Nbr->missed);

    atomic {
      usActTotal = Nbr->received + Nbr->missed;
      if (usActTotal < usExpTotal) usActTotal = usExpTotal;
      newAve = ((uint16_t) 255 * (uint16_t)Nbr->received) / (uint16_t)usActTotal;
      Nbr->missed = 0;
      Nbr->received = 0;
      if (Nbr->liveliness  == 0) Nbr->sendEst >>= 1;
      else                       Nbr->liveliness --;
     }
 
    if (Nbr->flags & NBRFLAG_EST_INIT) {
      uint16_t tmp;
      tmp = ((2 * ((uint16_t)Nbr->receiveEst) + (uint16_t)newAve * 6) / 8);
      Nbr->receiveEst = (uint8_t)tmp;
    }
    else {
      Nbr->receiveEst = (uint8_t) newAve;
      Nbr->flags ^= NBRFLAG_EST_INIT;
    }

     if(Nbr->childLiveliness > 0) Nbr->childLiveliness --;
  }

  void updateTable() {
    TableEntry *pNbr;
    uint8_t i = 0;

    gwEstTicks++;
    gwEstTicks %= ESTIMATE_TO_ROUTE_RATIO;

    for(i = 0; i < ROUTE_TABLE_SIZE; i++) {
      pNbr = &NeighborTbl[i];
      if (pNbr->flags & NBRFLAG_VALID) {
        if (gwEstTicks == 0) ///TODO: move out of for loop
          updateEst(pNbr);
      }
    }
  }

  
   bool updateNbrCounters(uint16_t saddr, int16_t seqno, uint8_t *NbrIndex) {
    TableEntry *pNbr;
    int16_t sDelta;
    uint8_t iNbr;
    bool Result = FALSE;  

    //XDBG(0, "updateNbrCounters\r\n");

    if(seqno == 0) return FALSE;

    if (saddr == call AMPacket.address()) return FALSE;

    //XDBG(0, "seqno != 0\r\n");

    iNbr = findPreparedIndex(saddr);
    pNbr = &NeighborTbl[iNbr];

    sDelta = (seqno - NeighborTbl[iNbr].lastSeqno - 1);

    
    
    if(seqno == 1) sDelta --;

    if (pNbr->flags & NBRFLAG_NEW) {
      pNbr->received++;
      pNbr->lastSeqno = seqno;
      pNbr->flags ^= NBRFLAG_NEW;
    }
    else if (sDelta >= 0) {
      pNbr->missed += sDelta;
      pNbr->received++;
      pNbr->lastSeqno = seqno;
    }
    else if (sDelta < ACCEPTABLE_MISSED) {
      newEntry(iNbr,saddr);
      pNbr->received++;
      pNbr->lastSeqno = seqno;
      pNbr->flags ^= NBRFLAG_NEW;
    }
    else {
      Result = TRUE;
    }

    *NbrIndex = iNbr;
    if(saddr == 0) return FALSE;
    return Result;

  }

  
  void chooseParent() {
    TableEntry *pNbr;
    uint32_t ulNbrLinkCost = (uint32_t) -1;
    uint32_t ulNbrTotalCost = (uint32_t) -1;
    uint32_t oldParentCost = (uint32_t) -1;
    uint32_t oldParentLinkCost = (uint32_t) -1;
    uint32_t ulMinTotalCost = (uint32_t) -1;
    TableEntry* pNewParent = NULL;
    TableEntry* pOldParent = NULL;
    uint8_t i;

    ADBG(1, "\r\nChoose Parent");

    if (call AMPacket.address() == BASE_STATION_ADDRESS) return;

    ADBG(1, "\r\nafter call AMPacket.address");

    showNeighborTbl();

    ADBG(1, "r\n Stage 1 #######");
    for (i = 0;i < ROUTE_TABLE_SIZE; i++) {
      pNbr = &NeighborTbl[i];

      //call StdOut.print("\r\n choosing "); call StdOut.printHex(i);

      
      if (!(pNbr->flags & NBRFLAG_VALID)) continue;
       //call StdOut.print("p1 ");
      if (pNbr->parent == call AMPacket.address()) continue;
       //call StdOut.print("p2 ");
      if (pNbr->parent == ROUTE_INVALID) continue;
       //call StdOut.print("p3 ");
      if (pNbr->hop == ROUTE_INVALID) continue;
       //call StdOut.print("p4 ");
      if (pNbr->cost == (uint16_t) ROUTE_INVALID) continue;
       //call StdOut.print("p5 ");
      if (pNbr->sendEst < 25 || pNbr->receiveEst < 25) continue;
       //call StdOut.print("p6 ");
      if (pNbr->childLiveliness > 0) continue;
      ADBG(1, " pass 1 ");

      ulNbrLinkCost = evaluateCost(0, pNbr->sendEst,pNbr->receiveEst);
      ulNbrTotalCost = evaluateCost(pNbr->cost, pNbr->sendEst,pNbr->receiveEst);


      if (ulNbrLinkCost > MAX_ALLOWABLE_LINK_COST) continue;
      //XDBG(DBG_ROUTE,"MultiHopEWMA node: %d, Cost %d, link Cost, %d\n", pNbr->id, ulNbrTotalCost, ulNbrLinkCost);

      ADBG(1, " pass 2 ");
      
      if (pNbr == gpCurrentParent) {
	    pOldParent = pNbr;
  	    oldParentCost = ulNbrTotalCost;
  	    oldParentLinkCost = ulNbrLinkCost;
  	    continue;
      }
      
      if (ulMinTotalCost > ulNbrTotalCost) {
        ulMinTotalCost = ulNbrTotalCost;
        pNewParent = pNbr;
      }

    }

    if(pNewParent == NULL){
    ADBG(1, "r\n Stage 2 #######");
     for (i = 0;i < ROUTE_TABLE_SIZE;i++) {
      pNbr = &NeighborTbl[i];

      ADBG(1, "\r\n choosing %d", ADBG_N(i));
      
      if (!(pNbr->flags & NBRFLAG_VALID)) continue;
      //call StdOut.print("2p1 ");
      if (pNbr->parent == call AMPacket.address()) continue;
           // call StdOut.print("2p2 ");
      if (pNbr->parent == ROUTE_INVALID) continue;
          //  call StdOut.print("2p3 ");
      if (pNbr->hop == ROUTE_INVALID) continue;
          //  call StdOut.print("2p4 ");
      if (pNbr->childLiveliness > 0) continue;
          //  call StdOut.print("2p5 ");

      ulNbrLinkCost = evaluateCost(0, pNbr->sendEst,pNbr->receiveEst);
      ulNbrTotalCost = evaluateCost(pNbr->cost, pNbr->sendEst,pNbr->receiveEst);

      ADBG(1, "\r\nulNbrLinkCost= 0x%x", ulNbrLinkCost);
      ADBG(1, ",  ulNbrTotalCost=0x%x", ulNbrTotalCost);
      
      if (ulMinTotalCost > ulNbrTotalCost) {
        ulMinTotalCost = ulNbrTotalCost;
        pNewParent = pNbr;
      }
        ADBG(1, ",  ulMinTotalCost=0x%x", ulMinTotalCost);
     }
    }
    
    if(pNewParent == NULL) {
	 ADBG(1, "r\n Stage 3 #######");
	
	pNewParent = gpCurrentParent;
        ulMinTotalCost = ROUTE_INVALID;
    } else if((pOldParent != NULL) &&
              (oldParentCost < (SWITCH_THRESHOLD + ulMinTotalCost))){
	ADBG(1, "r\n Stage 4 #######");
	//pNewParent = pOldParent;
        //ulMinTotalCost = oldParentCost;
    }

    if (pNewParent) {
      ADBG(1, "r\n Stage 5 #######");
      
      atomic {
        gpCurrentParent = pNewParent;
        gbCurrentHopCount = pNewParent->hop + 1;
        gbCurrentCost = ulMinTotalCost >> 6;
      }
    } else {
       ADBG(1, "r\n Stage 6 #######");
      atomic {
        gpCurrentParent = NULL;
        gbCurrentHopCount = ROUTE_INVALID;
        gbCurrentCost = ROUTE_INVALID;
      }

    }
    ADBG(1, "r\n END !!!!!    Stage  #######");
  }
   

   command error_t RouteSelect.forwardFailed(){
        ADBG(1, "\r\nforward Failed ");
	if (gpCurrentParent != NULL) gpCurrentParent->sendEst >>= SEND_TRUST;
	chooseParent();

	return SUCCESS;
  }
  uint8_t last_entry_sent;

  uint8_t error_count; 

  void RESET_NODE(){
  /*
	atomic{
		wdt_enable(WDTO_500MS);
		while(1){;}
	}
*/
  }

  

  task void SendRouteTask() {
//  void SendRouteTask() {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *) &routeMsg.data[0];
    RoutePacket *pRP = (RoutePacket *)&pMHMsg->data[0];
    uint8_t length = offsetof(TOS_MHopMsg,data) + offsetof(RoutePacket,estList);
    uint8_t maxEstEntries;
    uint8_t i,j;
    uint8_t last_index_added = 0;


    if(error_count > 5){
	RESET_NODE();
    }

    if (gfSendRouteBusy) {
      ADBG(1, "\ngfSendRouteBusy.\n");
      //while (1);
      error_count ++;
      return;
    }

    ADBG(1, "MultiHopEWMA Sending route update msg.\r\n");
    ADBG(1,"Current cost: %d.\n", gbCurrentCost);

    maxEstEntries = TOSH_DATA_LENGTH - length;
    maxEstEntries = maxEstEntries / sizeof(RPEstEntry);

    ADBG(1, "maxEstEntries=%d", ADBG_N(maxEstEntries));


    pRP->parent = (gpCurrentParent) ? gpCurrentParent->id : ROUTE_INVALID;
    pRP->cost = gbCurrentCost;

    //routeMsg.strength = 0xffff;
    call CC2420Packet.setRssi(&routeMsg, 0xFFFF);

    for (i = 0,j = 0;i < ROUTE_TABLE_SIZE && j < maxEstEntries; i++) {
      uint8_t table_index = i + last_entry_sent + 1;
      if (table_index >= ROUTE_TABLE_SIZE)
      {
        table_index = table_index % ROUTE_TABLE_SIZE;
      }
      
      if (NeighborTbl[table_index].flags & NBRFLAG_VALID && NeighborTbl[table_index].receiveEst > 100) {
        pRP->estList[j].id = NeighborTbl[table_index].id;
        pRP->estList[j].receiveEst = NeighborTbl[table_index].receiveEst;
	    j ++;
        length += sizeof(RPEstEntry);
	    last_index_added = table_index;
        ADBG(1,"Adding %d to route msg.\n", ADBG_N(pRP->estList[j].id));

        //call StdOut.print("\r\nAdding to route msg="); call StdOut.printHex(pRP->estList[j].id);
      }
    }
    last_entry_sent = last_index_added;
    //XDBG(DBG_ROUTE,"Added total of %d entries to route msg.\n", j);
    ADBG(1, "\r\nAdded total %d of entries to route msg", ADBG_N(j));
    pRP->estEntries = j;
    pMHMsg->sourceaddr = pMHMsg->originaddr = call AMPacket.address();
    pMHMsg->hopcount = gbCurrentHopCount;
    pMHMsg->seqno = next_sequence_number();

    

    call AMPacket.setDestination(&routeMsg, TOS_BCAST_ADDR);

//    if (call SendMsg.send(TOS_BCAST_ADDR, length, &routeMsg) == SUCCESS) {

    ADBG(1, "\nSending Route msg length=%d\n", ADBG_N(length));

    if (call SendMsg.send(&routeMsg, length) == SUCCESS) {
      gfSendRouteBusy = TRUE;
    }else{
      error_count ++;
    }

  }


  task void SendDebugTask() {
//  void SendDebugTask() {
    struct SortDbgEntry sortTbl[ROUTE_TABLE_SIZE];
    //uint16_t max_length;
    uint8_t max_length;
    uint8_t length = offsetof(DebugPacket,estList);
    //DebugPacket *pRP = (DebugPacket *)call DebugSendMsg.getBuffer(&debugMsg,&max_length);
    DebugPacket *pRP = (DebugPacket *)call Packet.getPayload(&debugMsg,&max_length);
    uint8_t maxEstEntries;
    uint16_t parent;
    uint8_t i,j;

    ADBG(1,"MultiHopEWMA Sending route debug msg.\n");

    //debugMsg.strength = 0xffff;
    call CC2420Packet.setRssi(&debugMsg, 0xFFFF);

    maxEstEntries = max_length / sizeof(DBGEstEntry);
    maxEstEntries --;
    parent = (gpCurrentParent) ? gpCurrentParent->id : ROUTE_INVALID;

    for (i = 0,j = 0;i < ROUTE_TABLE_SIZE; i++) {
      if (NeighborTbl[i].flags & NBRFLAG_VALID && NeighborTbl[i].id != parent) {
        sortTbl[j].id = NeighborTbl[i].id;
        sortTbl[j].sendEst = NeighborTbl[i].sendEst;
        sortTbl[j].hopcount = NeighborTbl[i].hop;
        j++;
      }
    }
    //qsort (sortTbl,j,sizeof(struct SortDbgEntry),sortDebugEstFcn);

    pRP->estEntries = (j > maxEstEntries) ? maxEstEntries : j;
    pRP->estList[0].id = parent;
    if(gpCurrentParent){
	pRP->estList[0].sendEst = gpCurrentParent->sendEst;
	pRP->estList[0].hopcount = gpCurrentParent->hop;
    }
    length += sizeof(DBGEstEntry);

    for (i = 0; i < pRP->estEntries; i++) {
      pRP->estList[i+1].id = sortTbl[i].id;
      pRP->estList[i+1].sendEst = sortTbl[i].sendEst;
      pRP->estList[i+1].hopcount = sortTbl[i].hopcount;
      length += sizeof(DBGEstEntry);
    }
    pRP->estEntries ++;
    call DebugSendMsg.send(&debugMsg, length);

  }

  int debugCounter;

 task void TimerTask() {
 //  void TimerTask() {
    
    ADBG(1, "MultiHopEWMA timer task.\n");
    updateTable();
    chooseParent();

    if (gpCurrentParent == NULL)
    {
        // LED_TOGGLE(2);
        call Leds.RedLedToggle();
    }
    else
    {
        // LED_ON(2);
		call Leds.RedLedOn();
    }
/*    
#ifdef MULTI_HOP_DEBUG
    if(call AMPacket.address() != BASE_STATION_ADDRESS) debugCounter ++;
    if(debugCounter > 1){
	post SendDebugTask();
	debugCounter = 0;
    }else{
#endif 
    	post SendRouteTask();
    	//SendRouteTask();
#ifdef MULTI_HOP_DEBUG
    }
#endif 
*/
      post SendRouteTask();
  }


  command error_t Init.init()
  {
  
    ADBG(1, "MultiHopEWMA Init.init\r\n");
    
    memset((void *)NeighborTbl,0,(sizeof(TableEntry) * ROUTE_TABLE_SIZE));
    BaseStation.id = TOS_UART_ADDR;
    BaseStation.parent = TOS_UART_ADDR;
    BaseStation.flags = NBRFLAG_VALID;
    BaseStation.hop = 0;
    gpCurrentParent = NULL;
    gbCurrentHopCount = ROUTE_INVALID;
    gCurrentSeqNo = 1;
    gwEstTicks = 0;
    gUpdateInterval = call AMPacket.address();


#ifdef EM_ROUTE_UPDATE_TIME

    gUpdateInterval = EM_ROUTE_UPDATE_TIME;
    
#else

    if (gUpdateInterval != BASE_STATION_ADDRESS)
    {
        gUpdateInterval = 8000;
    }
    else
    {
        gUpdateInterval = 3000;
    }
    
#endif

    
    gfSendRouteBusy = FALSE;
    gFirstStart = TRUE;
    gSelfTimer = TRUE;
    error_count  = 0;
    last_entry_sent  = 0;

    if (call AMPacket.address() == BASE_STATION_ADDRESS)
    {
      gpCurrentParent = &BaseStation;
      gbCurrentHopCount = 0;
      gbCurrentCost = 0;
    }


    return SUCCESS;
  }

  command error_t StdControl.start() {
    gfSendRouteBusy = FALSE;
    
    if (gFirstStart)
    {
        gFirstStart = FALSE;
        post TimerTask();
    }
    
    ADBG(1, "EWMA start update interval=%d", gUpdateInterval);
		
    call Timer.startPeriodic(gUpdateInterval);

    return SUCCESS;
  }

  command error_t StdControl.stop()
  {
    call Timer.stop();
    return SUCCESS;
  }

  command bool RouteSelect.isActive() {
#if 0
    bool Result = FALSE;

    if (gpCurrentParent != NULL) {
      Result = TRUE;
    }

    return Result;
#endif

    return TRUE;
  }

  
   void updateDescendant(uint16_t id){
	uint8_t indes = findEntry(id);
	if (indes == (uint8_t) ROUTE_INVALID) { return;}
	else NeighborTbl[indes].childLiveliness = MAX_DESCENDANT;
  }


   

   
   void updateDescendantRoute(uint16_t id, uint16_t route){
       descendant_route[id & 0x7f] = route;
   }

   
   command error_t RouteSelect.selectDescendantRoute(message_t *Msg, uint8_t id, uint8_t resend, uint8_t force_monitor) {
     TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)&Msg->data[0];
     uint8_t iNbr;
     bool fIsDuplicate;
     error_t Result = SUCCESS;
     if (gbCurrentHopCount < pMHMsg->hopcount && resend == 0) {
       
       return FAIL;
     }
     if ((pMHMsg->sourceaddr == call AMPacket.address()) &&
         (pMHMsg->originaddr == call AMPacket.address())) {
       fIsDuplicate = FALSE;
     } else if(resend == 1){
       fIsDuplicate = FALSE;
     }else {


       fIsDuplicate = updateNbrCounters(pMHMsg->sourceaddr,pMHMsg->seqno,&iNbr);

     }

     if (!fIsDuplicate) {
       pMHMsg->sourceaddr = call AMPacket.address();
       pMHMsg->hopcount = gbCurrentHopCount;
       
       //Msg->addr =  descendant_route[pMHMsg->originaddr & 0x7f];
       call AMPacket.setDestination(Msg, descendant_route[pMHMsg->originaddr & 0x7f]);
       if ( call AMPacket.destination(Msg) == 0) Result = FAIL;
	else               pMHMsg->seqno = next_sequence_number();  
       //Msg->strength = 0;
       call CC2420Packet.setRssi(Msg, 0);
     }
     else {
       Result = FAIL;
     }


     return Result;
   }


  command error_t RouteSelect.selectRoute(message_t *Msg, uint8_t id, uint8_t resend, uint8_t force_monitor) {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)&Msg->data[0];

    uint8_t iNbr;
    bool fIsDuplicate;
    error_t Result = SUCCESS;

    ADBG(1, "\r\nMultiHopEWMA RouteSelect.selectRoute");

    //Msg->strength = 0;
    call CC2420Packet.setRssi(Msg, 0);

    //No parent now
    if (gpCurrentParent == NULL)
    {   
        // LED_TOGGLE(2);
        call Leds.RedLedToggle();
        
      ADBG(1, "MultiHopEWMA RouteSelect.selectRoute gpCurrentParent == NULL\r\n");
      
      if ((pMHMsg->sourceaddr == call AMPacket.address()) &&
          (pMHMsg->originaddr == call AMPacket.address())) {

          ADBG(1, "MultiHopEWMA RouteSelect.selectRoute pMHMsg->sourceaddr == call AMPacket.address()\r\n");
          pMHMsg->sourceaddr = call AMPacket.address();
          pMHMsg->hopcount = gbCurrentHopCount;
          pMHMsg->seqno = next_sequence_number();
          //Msg->addr = TOS_BCAST_ADDR;
          call AMPacket.setDestination(Msg, TOS_BCAST_ADDR);
    	  //Msg->strength = 0;
    	  call CC2420Packet.setRssi(Msg, 0);
          return SUCCESS;
      }
      else {
         ADBG(1, "MultiHopEWMA RouteSelect.selectRoute gpCurrentParent == NULL but not my address\r\n");
         return FAIL;
      }
    }


    //    
    if (gbCurrentHopCount >= pMHMsg->hopcount && resend == 0) {
      
      return FAIL;
    }

    
    if ((pMHMsg->sourceaddr == call AMPacket.address()) &&
        (pMHMsg->originaddr == call AMPacket.address())) {
      fIsDuplicate = FALSE;
    } else if(resend == 1){
      fIsDuplicate = FALSE;
    }else {
      fIsDuplicate = updateNbrCounters(pMHMsg->sourceaddr,pMHMsg->seqno,&iNbr);
    }

    
    if(gpCurrentParent->id != 0 && resend == 1) force_monitor = 1;

    if (!fIsDuplicate) {
      uint16_t source = pMHMsg->sourceaddr;
      if(source != call AMPacket.address()){
        updateDescendantRoute(pMHMsg->originaddr, source);
      }
      pMHMsg->sourceaddr = call AMPacket.address();
      pMHMsg->hopcount = gbCurrentHopCount;

     ADBG(1, "\r\nenter the real! gpCurrentParent->id=%d", ADBG_N(gpCurrentParent->id));
      
      if (gpCurrentParent->id != TOS_UART_ADDR && force_monitor == 1) {
	    
        pMHMsg->seqno = next_sequence_number();
	    //Msg->strength = (uint16_t)0xffff;
	    call CC2420Packet.setRssi(Msg, 0xFFFF);
	    //if(resend) Msg->strength = 0;
	    if(resend) call CC2420Packet.setRssi(Msg, 0);
      }else if(gpCurrentParent->id == 0){
	   
	   pMHMsg->seqno = 0;
	   //Msg->strength = 0x7fff;
	   call CC2420Packet.setRssi(Msg, 0x7FFF);
      }else {
	
	   pMHMsg->seqno = 0;                
	   //Msg->strength = 0xffff;
	   call CC2420Packet.setRssi(Msg, 0xFFFF);
      }

      //Msg->addr = gpCurrentParent->id;
      call AMPacket.setDestination(Msg, gpCurrentParent->id);
      
      if(pMHMsg->originaddr != call AMPacket.address()) updateDescendant(pMHMsg->originaddr);
    }
    else Result = FAIL;
    

    return Result;

  }

  command error_t RouteSelect.initializeFields(message_t *Msg, uint8_t id) {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)&Msg->data[0];

    pMHMsg->sourceaddr = pMHMsg->originaddr = call AMPacket.address();
    pMHMsg->hopcount = ROUTE_INVALID;

    return SUCCESS;
  }

  command uint8_t* RouteSelect.getBuffer(message_t *Msg, uint16_t* Len) {

  }

  command uint16_t RouteControl.getParent() {

    uint16_t addr;

    addr = (gpCurrentParent != NULL) ? gpCurrentParent->id : 0xffff;

    return addr;
  }

  command uint8_t RouteControl.getQuality() {
    uint8_t val;

    val = (gpCurrentParent != NULL) ? gpCurrentParent->sendEst : 0x00;

    return val;
  }

  command uint8_t RouteControl.getDepth() {
    return gbCurrentHopCount;
  }

  command uint8_t RouteControl.getOccupancy() {
    return 0;
  }
/*
  command uint16_t RouteControl.getSender(message_t *msg) {
    TOS_MHopMsg		*pMHMsg = (TOS_MHopMsg *)msg->data;
    return pMHMsg->sourceaddr;
  }
*/
  command error_t RouteControl.setUpdateInterval(uint16_t Interval) {
    error_t Result;

    call Timer.stop();
    gUpdateInterval = (Interval * 1024);  
	gSelfTimer = TRUE;
    call Timer.startPeriodic(gUpdateInterval);
#ifdef USE_WATCHDOG
	call PoochHandler.stop();
	call PoochHandler.start();
	call WDT.start(gUpdateInterval * 5);
#endif

    return SUCCESS;
  }

  command error_t RouteControl.manualUpdate() {
    error_t Result;

	gSelfTimer = FALSE;
	call Timer.stop();
    Result = post TimerTask();
    //TimerTask();
    return Result;
  }



  event void Timer.fired() {
    post TimerTask();
    //TimerTask();
    //return SUCCESS;
  }

  event message_t * Receive.receive(message_t *Msg, void *payload, uint8_t len) {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)&Msg->data[0];
    RoutePacket *pRP = (RoutePacket *)&pMHMsg->data[0];
    uint16_t saddr;
    uint8_t i, iNbr;

    ADBG(1, "************************************EWMA Receive.receive\r\n");
#ifdef USE_WATCHDOG
	call WDT.reset();
#endif
	
	//if(Msg->type == 0xef) return Msg;
    if (call AMPacket.type(Msg) == 0xef) return Msg;
    ADBG(1, "************************************Start update my table\r\n");
    saddr = pMHMsg->sourceaddr;

    updateNbrCounters(saddr,pMHMsg->seqno,&iNbr);    

    NeighborTbl[iNbr].parent = pRP->parent;
    NeighborTbl[iNbr].hop    = pMHMsg->hopcount;
    NeighborTbl[iNbr].cost   = pRP->cost;

    for (i = 0; i < pRP->estEntries; i++) {
      if (pRP->estList[i].id == call AMPacket.address()) {
        NeighborTbl[iNbr].sendEst = pRP->estList[i].receiveEst;
        NeighborTbl[iNbr].liveliness = LIVELINESS;
      }
    }

    showNeighborTbl();
    
    return Msg;
  }

  event bool Snoop.forward[uint8_t id](message_t *Msg, void *Payload, uint16_t Len) {
    TOS_MHopMsg *pMHMsg = (TOS_MHopMsg *)&Msg->data[0];
    uint8_t iNbr;

    ADBG(1, "**********************EWMA Snoop.forward\r\n");

    updateNbrCounters(pMHMsg->sourceaddr,pMHMsg->seqno,&iNbr);

    //showNeighborTbl();

    return SUCCESS;
  }


  event void SendMsg.sendDone(message_t *pMsg, error_t success) {
    
    if (gpCurrentParent == NULL)
    {
        // LED_TOGGLE(2);
        call Leds.RedLedToggle();
    }
    else
    {
        // LED_ON(2);
		call Leds.RedLedOn();
    }
    gfSendRouteBusy = FALSE;
    if (success) error_count = 0;

    ADBG(1, "EWMA SendMsg.sendDone\n");

    //return SUCCESS;

  }
  event void DebugSendMsg.sendDone(message_t *pMsg, error_t success) {
    //return SUCCESS;
  }


}

