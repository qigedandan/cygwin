
#include "ActiveMessageResource.h"

generic configuration ActiveMessageResourceC()
{
	provides interface AMSend[uint8_t id];
}
implementation
{
	components ActiveMessageC;
	components CC2420ActiveMessageC;
	components new ActiveMessageResourceP();
	
	AMSend = ActiveMessageResourceP;

	ActiveMessageResourceP.SubAMSend -> ActiveMessageC.AMSend;
	ActiveMessageResourceP.ActiveMessageResource -> CC2420ActiveMessageC.ActiveMessageResource[unique(AMRESOURCE_ID)];
}

