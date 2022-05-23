
#ifndef ATPDATA_H
#define ATPDATA_H

typedef struct _atpdata_node_packet_t
{
	uint16_t nid;
	uint8_t type;
	uint8_t len;
	
	uint8_t data[1]; /**/
} atpdata_node_packet_t;

typedef struct _atpdata_packet_t
{
	uint16_t len;
	atpdata_node_packet_t node_packets;  /**/
} atpdata_packet_t;



#endif /* ATPDATA_H */


