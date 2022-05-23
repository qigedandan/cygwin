#include "LocPacket.h"

interface LocPacket
{

	command void Send(loc_packet_t* lp_t);
	event void SendDone(error_t success);
	
	event void Receive(loc_packet_t* lp_t);

}
