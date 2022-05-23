
#ifndef SAFERADIO_H
#define SAFERADIO_H

typedef struct _safe_radio_t
{
	uint8_t dsn;
	uint8_t ack_req;
} safe_radio_t;

typedef struct _safe_radio_ack_t
{
	uint8_t dsn;
	uint16_t src;
} safe_radio_ack_t;

typedef struct _safe_radio_history_t
{
	uint16_t addr;
	uint8_t dsn;
} safe_radio_history_t;

#define SAFE_RADIO_RETRY	3
#define SAFE_RADIO_ACK_TIME	500
#define SAFE_RADIO_ACK_BUF_SIZE	3
#define SAFE_RADIO_HISTORY_SIZE	15


#endif /*SAFERADIO_H*/

