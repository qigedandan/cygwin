#ifndef LOCATION_H
#define LOCATION_H


#define MAX_LIST_RSSI_NUM 8
#define AVERAGE_RSSI_NUM  3

/*********************************************************************
 * STRUCTURES
 */

typedef struct
{
  uint8_t x;
  uint8_t y;
  uint8_t rssi;
  uint16_t addr;
} LocRefNode_t;

typedef struct
{
  uint8_t  param_a;
  uint8_t  param_n;
} LocDevPara_t;

typedef struct
{
  uint8_t  x;
  uint8_t  y;
  uint8_t min;
} LocBlindNode_t ;

typedef struct
{
	uint16_t diff_x;
	uint16_t diff_y;
	uint8_t a;
	uint8_t n;
	uint8_t used;
} LocBlindNodeAutoResult_t;

typedef struct
{
	uint8_t useFlag;
	uint8_t rssiNum;
	uint8_t x;
	uint8_t y;
	uint16_t addr;
	uint32_t last_packet_tick;
	uint8_t rssi[MAX_LIST_RSSI_NUM];
} RefNodeList16_t;

#endif /* LOCATION_H */
