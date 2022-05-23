#ifndef __H_DS18B20_H
#define __H_DS18B20_H



typedef struct 
{
  bool minus;
  uint16_t value;
} ds18b20_temperature_t;

/* Is the value has minus? */
#define DS18B20_GET_MINUS(d16) (((d16) & 0xF800) == 0xF800)

/* Get temperature value from raw data(16-bit)  */

#define DS18B20_GET_T_BASE(minus, d16)  ((minus) ? ((~d16)+1) : (d16))

#define DS18B20_GET_T(d16)  ((d16)*= 25, (d16)/=10, (d16)*=25, (d16)/=100)



/*DS18B20 command and function code*/
enum
{
  /* ROM commands */
  DS18B20_SEARCH_ROM = 0xF0,
  DS18B20_READ_ROM = 0x33,
  DS18B20_MATCH_ROM = 0x55,
  DS18B20_SKIP_ROM = 0xCC,
  DS18B20_ALARM_SEARCH = 0xEC,

  /* Function commands */
  DS18B20_CONVERT_T = 0x44,
  DS18B20_WRITE_SCRATCHPAD = 0x4E,
  DS18B20_READ_SCRATCHPAD = 0xBE,
  DS18B20_COPY_SCRATCHPAD = 0x48,
  DS18B20_RECALL_E2 = 0xB8,
  DS18B20_READ_POWER_SUPPLY = 0xB4
};

#endif
