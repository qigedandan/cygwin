#include "QuickRoute.h"

configuration QuickRouteC
{
	provides {
		interface StdControl;
		interface Send;
		interface Intercept;
		interface Packet;
		
		interface RootControl;
	}
}

implementation
{
	components QuickRouteP;

	StdControl = QuickRouteP;
	Intercept = QuickRouteP;


	/* just for send data?? */
	components QuickRouteDataSenderC;
	Send = QuickRouteDataSenderC;


	/* forward control */
	components QuickRouteForwardC;
	QuickRouteP.QuickRouteForward -> QuickRouteForwardC;

	components QuickRouteEngineC;
	RootControl = QuickRouteEngineC;
	QuickRouteP.RootControl -> QuickRouteEngineC;

	components QuickRouteRadioC;
	QuickRouteP.ReceiveData -> QuickRouteRadioC.ReceiveData;
	QuickRouteP.ReceiveDataForward -> QuickRouteRadioC.ReceiveForward;

	Packet = QuickRouteRadioC;
}

