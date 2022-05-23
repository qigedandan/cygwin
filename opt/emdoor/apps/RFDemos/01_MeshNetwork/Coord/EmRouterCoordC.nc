#include "message.h"
#include "QuickRoute.h"
#define DBG_LEV 20

module EmRouterCoordC
{
	uses
	{
		interface Boot;

		interface AMPacket;
		interface Packet;
		interface SplitControl as AMControl;
		
		interface Send;
		interface Intercept;
		interface RootControl;

		interface ABS;

//		interface UartDebugControl;

		interface StdControl as SystemHeartControl;
	}
}
implementation
{
	message_t m_msg;
	task void initTask()
	{
		call AMControl.start();
	}

	task void sendTask()
	{
		call Send.send(&m_msg, 10);
	}

	event void Boot.booted() {
		ADBG(100,"#########Boot.booted myaddr=%d#########\n", (int)call AMPacket.address());
		call SystemHeartControl.start();

		//call UartDebugControl.setLevelInput(TRUE);

		post initTask();
	}

	event void AMControl.startDone(error_t error) {
		post sendTask();
	}

	event void AMControl.stopDone(error_t error) {
	}


	event void Send.sendDone(message_t* msg, error_t error)
	{
		ADBG(200, "## Send.sendDone result=%d\n", (int)error);
	}

	uint16_t prepareReport(message_t * msg, uint8_t *report, quickroute_data_header_t *data_header, void *payload, uint16_t len)
	{
		struct
		{
			uint16_t source;
			uint16_t org;
			uint16_t seq;
			uint8_t hopcount;
		} payload_head;  /* ugly code!! :(  */

		
		/* copy payload first */
		memcpy(report+sizeof(payload_head), payload, len);

		/* copy header */
		payload_head.org = data_header->orgi_addr;
		payload_head.source = data_header->second_addr;
		payload_head.seq = 0;
		payload_head.hopcount = data_header->hop_real;
		//payload_head.data = 0;
		memcpy(report, &payload_head, sizeof(payload_head));

		return len + sizeof(payload_head)+1;
	}

	event bool Intercept.forward(message_t* msg, void* payload, uint16_t len)
	{
		uint8_t i;
		uint8_t report_payload[128];
		uint16_t report_len;
		quickroute_data_header_t *data_header = (quickroute_data_header_t *)call Packet.getPayload(msg, NULL);
		
		report_len = prepareReport(msg, report_payload, data_header, payload, len);
		
		ADBG(200, "## Intercept.forward payload len =%d, report len=%d\n", len, report_len);
		ADBG(200, "## Intercept.forward src=%d, len=%d, seqno=%d, orgi_addr=%d, hop_real=%d, hop_est=%d\n", 
			data_header->second_addr, 
			len,
			(int)data_header->seqno,
			(int)data_header->orgi_addr,
			(int)data_header->hop_real,
			(int)data_header->hop_est
		);
        
		ADBG(200, "## payload len=%d\n", (int)len);
		for (i=0; i < report_len; ++i)
		{
			ADBG(200, "%02x ", (int)((uint8_t *)report_payload)[i]);
		}
        
		call ABS.reportPacket(data_header->sensor_type, report_payload, report_len);

		// LED_BLUE_TOGGLE;

		return FALSE;
	}

	event void ABS.reportPacketDone(uint8_t *src, uint16_t len, error_t result)
	{
	}

	/*event void UartDebugControl.levelChanged(int new_level)
	{
	}*/
}
