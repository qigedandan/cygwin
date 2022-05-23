
#include "ClockSync.h"

generic configuration ClockSyncC(uint8_t is_source)
{
	provides interface ClockSync;
	provides interface CoreControl;
}
implementation
{
	components new ClockSyncP(is_source);

	ClockSync = ClockSyncP;
	
	components UnsleepClockC;
	ClockSyncP.UnsleepClock -> UnsleepClockC;

	components ActiveMessageC;
	ClockSyncP.Packet -> ActiveMessageC.Packet;



	//AMSend with resource control
	
	components new ActiveMessageResourceC() as ActiveMessageResourceTime;
	ClockSyncP.AMSendTime -> ActiveMessageResourceTime.AMSend[CLOCKSYNC_AM_TYPE_TIME];
	
	components new AMReceiverC(CLOCKSYNC_AM_TYPE_TIME) as AMReceiverTime;
	ClockSyncP.ReceiveTime -> AMReceiverTime.Receive;
	

	components new ActiveMessageResourceC() as ActiveMessageResourceRequest;
	ClockSyncP.AMSendRequest -> ActiveMessageResourceRequest.AMSend[CLOCKSYNC_AM_TYPE_REQ];
	
	components new AMReceiverC(CLOCKSYNC_AM_TYPE_REQ) as AMReceiverRequest;
	ClockSyncP.ReceiveRequest -> AMReceiverRequest.Receive;

	//AMSender
/*
	components new AMSenderC(CLOCKSYNC_AM_TYPE_TIME) as AMSenderTime;
	ClockSyncP.AMSendTime -> AMSenderTime.AMSend;
	components new AMReceiverC(CLOCKSYNC_AM_TYPE_TIME) as AMReceiverTime;
	ClockSyncP.ReceiveTime -> AMReceiverTime.Receive;


	components new AMSenderC(CLOCKSYNC_AM_TYPE_REQ) as AMSenderRequest;
	ClockSyncP.AMSendRequest -> AMSenderRequest.AMSend;
	components new AMReceiverC(CLOCKSYNC_AM_TYPE_REQ) as AMReceiverRequest;
	ClockSyncP.ReceiveRequest -> AMReceiverRequest.Receive;
*/

	/* Core control */
	components new CoreControlC();
	CoreControl = CoreControlC;
	ClockSyncP.CoreControlOwner -> CoreControlC;
}

