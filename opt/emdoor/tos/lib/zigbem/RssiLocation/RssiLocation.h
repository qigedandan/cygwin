#ifndef _RSSI_LOCATION_H
#define  _RSSI_LOCATION_H

#ifndef AM_LOCATION_BROADCAST_MSG
#define AM_LOCATION_BROADCAST_MSG 212
#endif

#ifndef AM_LOCATION_INFO_UPLOAD_MSG
#define  AM_LOCATION_INFO_UPLOAD_MSG 113
#endif

#ifndef MOBILE_BROADCAST_INTERVAL 
#define  MOBILE_BROADCAST_INTERVAL 1000
#endif

#ifndef STATION_UPLOAD_INTERVAL
#define  STATION_UPLOAD_INTERVAL 10000
#endif

#ifndef LOCATION_INFO_RECEIVE_BUFFER_SIZE
#define  LOCATION_INFO_RECEIVE_BUFFER_SIZE  60 
#endif

#ifndef LOCATION_INFO_SEND_BUFFER_SIZE
#define  LOCATION_INFO_SEND_BUFFER_SIZE  6
#endif

#ifndef SERVER_ADDRESS
#define  SERVER_ADDRESS 1
#endif

typedef struct _location_info
{
	uint16_t id;
	uint32_t dsn;
	int rssi;
}location_info_t;

typedef struct _location_beacon_t
{
	uint32_t dsn;
} location_beacon_t;

typedef struct _upload_info
{
	uint16_t id;
	uint8_t data[60];
	uint8_t len;
}upload_info_t;

#endif

