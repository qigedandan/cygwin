
#ifndef OSALOGGERRF_H
#define OSALOGGERRF_H

typedef struct _osalog_rf_small
{
	uint32_t time;
	uint8_t type;
	uint8_t src;
	uint8_t dest;
	uint8_t packet_size;
} osalog_rf_small_t;

typedef struct _osalog_rf
{
	uint32_t time;
	uint8_t type;
	uint16_t src;
	uint16_t dest;
	uint16_t packet_size;
} osalog_rf_t;

enum
{
	OSALOG_RF_TYPE_SEND = 1,
	OSALOG_RF_TYPE_RECEIVE = 2,
};

#endif /* OSALOGGERRF_H */

