#include "QuickRoute.h"

configuration QuickRouteForwardC
{
	provides {
		interface QuickRouteForward;
		interface CoreControl;
	}
}
implementation
{
	components QuickRouteForwardP;

	QuickRouteForward = QuickRouteForwardP;


	components ActiveMessageC;
	QuickRouteForwardP.AMPacket -> ActiveMessageC;
	QuickRouteForwardP.Packet -> ActiveMessageC;

	components QuickRouteRadioC;/* Safe Radio 2010 */
	QuickRouteForwardP.DataPacket -> ActiveMessageC;

	components new QuickRouteSenderC(AM_QUICK_ROUTE_DATA_FORWARD_MSG);
	QuickRouteSenderC.AMSend -> QuickRouteRadioC.AMSendForward;

	QuickRouteForwardP.SubSend -> QuickRouteSenderC;

	components new QuickRouteSmartQueueC(QUICK_ROUTE_FORWARD_SIZE) as SendQueueC;
	QuickRouteForwardP.SendQueue-> SendQueueC;

	components new TimerMilliC();
	QuickRouteForwardP.ForwardTimer -> TimerMilliC;

	components QuickRouteEngineC;
	QuickRouteForwardP.QuickRouteEngine -> QuickRouteEngineC;

	/* CoreControl */
	components new CoreControlC();
	CoreControl = CoreControlC;
	QuickRouteForwardP.CoreControlOwner -> CoreControlC;

	/* add support for sleep control */
	components new CoreControlLockC();
	components new SleepNodeStateLockC();
	CoreControlLockC.StateLock -> SleepNodeStateLockC;
	CoreControlLockC.CoreControl -> CoreControlC;
}

	
