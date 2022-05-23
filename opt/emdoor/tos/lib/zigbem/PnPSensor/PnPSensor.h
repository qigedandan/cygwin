
#ifndef PNPSENSOR_H
#define PNPSENSOR_H


enum
{
	PNPSENSOR_CONFIG_EEPROM_ADDR = 0x00,
};

typedef struct _pnpsensor_config
{
	uint8_t type_no;
	uint8_t sensor_count;
	uint8_t sensor_list[8]; /* support max 8 sensors??  */
} pnpsensor_config_t;

#endif /* PNPSENSOR_H */

