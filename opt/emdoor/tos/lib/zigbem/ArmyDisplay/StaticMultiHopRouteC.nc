#include "StaticMultiHopRoute.h"

configuration StaticMultiHopRouteC
{
	provides {
		interface StdControl;
		interface RouteSelect;
		interface RootControl;
		interface Send;
		interface Receive;
		interface Intercept;
		interface Packet;
		interface StaticMHopRouteInfo;
	}
}
implementation
{
	
