#ifndef STATIC_MULTIHOP_ROUTE_H
#define STATIC_MULTIHOP_ROUTE_H

typedef struct static_multihop_header
{
	nx_uint16_t originaddr;
	nx_uint8_t sensorType;
	nx_uint8_t id;
} static_multihop_route_header_t;

#endif

