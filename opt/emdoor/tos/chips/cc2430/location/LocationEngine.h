#ifndef LOCATIONENGINE_H
#define LOCATIONENGINE_H

#define LOC_ENGINE_NODE_CAPACITY_REVB 	8
#define LOC_ENGINE_NODE_CAPACITY_REVC 	16 //we may use this rev

#define LOC_ENGINE_X_MIN	0x00
#define LOC_ENGINE_X_MAX	0xff
#define LOC_ENGINE_X_DELTA ((LOC_ENGINE_X_MAX)-(LOC_ENGINE_X_MIN))

#define LOC_ENGINE_Y_MIN	0x00
#define LOC_ENGINE_Y_MAX	0xff
#define LOC_ENGINE_Y_DELTA ((LOC_ENGINE_Y_MAX)-(LOC_ENGINE_Y_MIN))



typedef	struct
{
	uint8_t x;
	uint8_t y;
	int8_t rssi;
	uint16_t addr;
}RefNode_t;

typedef struct
{
	uint8_t 	param_a;
	uint8_t 	param_n;
} Para_t;

typedef struct
{
	uint8_t x;
	uint8_t y;
	uint8_t min;
} BlindNode_t;

typedef struct
{
	uint16_t diff_x;
	uint16_t diff_y;
	uint8_t	a;
	uint8_t	n;
	uint8_t	used;
} BlindNodeAutoResult_t;

#endif
