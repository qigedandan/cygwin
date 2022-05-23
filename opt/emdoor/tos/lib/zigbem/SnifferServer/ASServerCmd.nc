#include "ASServerCmd.h"

interface ASServerCmd
{
	/* PC -> Server */
	event void pingServerFired();
	event void StartFired();
	event void StopFired();
	event void setChannelFired(uint8_t channel);
	

	/* Server -> PC */
	command error_t ReportSniffData(asserver_ReportPacket *m_asserver_packet);
	event void ReportSniffDataDone(error_t error);
	
	command error_t pingServerAck();
	event void pingServerAckDone(error_t error);
	
	command error_t StartAck(error_t error);
	event void StartAckDone(error_t error);
    
	command error_t StopAck(error_t error);
	event void StopAckDone(error_t error);

	command error_t setChannelAck(uint8_t channel);
	event void setChannelAckDone(error_t error);
    
}

