#ifndef PCF8563_H
#define PCF8563_H

#define  Addr_second  0x02
#define  Addr_minute  0x03
#define  Addr_hour    0x04
#define  Addr_day     0x05
#define  Addr_month   0x07
#define  Addr_year    0x08

#define  Addr_Alarm_minute 	0x09
#define  Addr_Alarm_hour   	0x0A
#define  Addr_Alarm_day 	0x0B
#define  Addr_Alarm_week   	0x0C

#define  Addr_Control_Status_2   	0x01

#define  Flag_Alarm_minute 	0x01
#define  Flag_Alarm_hour   	0x02
#define  Flag_Alarm_day 		0x04
#define  Flag_Alarm_week   	0x08
#define  Flag_Alarm_all   	0x0f
#define  Flag_Alarm_null   	0x00

#define  AlarmFlag    0x01

#define Write_Pcf8563  0xa2
#define Read_Pcf8563   0xa3

#define Addr_Pcf8563  0x51

#define  Flag_second  		0x01
#define  Flag_minute    	0x02
#define  Flag_hour    		0x04
#define  Flag_day     		0x08
#define  Flag_month   		0x10
#define  Flag_year    		0x20
#define  Flag_week    		0x40
#define  Flag_century   	0x80
#define  Flag_all 	  		0xff
#define  Flag_null    		0x00

typedef struct _rtc_time
{
	uint8_t year;
	uint8_t month;
	uint8_t day;
	uint8_t hour;
	uint8_t minute;
	uint8_t second;
	uint8_t week;
	uint8_t century;	
}	rtc_time ;

#endif

