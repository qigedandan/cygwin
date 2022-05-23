/*
 * File: pm0.c
 * @autor: xlq, 2007-11
 * */
/* CC2430 PM0 XDATA
* XDATA From 0xE000-0xEFFF will lose data when in the Power Mode 2/3
* So use the PM0 DATA to save memory for the PM3...
*
* Usage: to specify the variable in the XDATA_PM0, use the xdata_pm0 attribute.
*
* Example: uint8_t_xdata_pm0 foo = 3;
*
*/

/* use this to enable the LX51 user class */
#pragma userclass (xdata = pm0)

#define nx_struct struct


typedef signed char int8_t;
typedef short int16_t;
typedef long int32_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned long uint32_t;




typedef struct { char _data[1]; } /*__attribute__((packed))*/ nx_int8_t;typedef int8_t __nesc_nxbase_nx_int8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nx_int16_t;typedef int16_t __nesc_nxbase_nx_int16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nx_int32_t;typedef int32_t __nesc_nxbase_nx_int32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nx_int64_t;typedef int32_t __nesc_nxbase_nx_int64_t  ;
typedef struct { char _data[1]; } /*__attribute__((packed))*/ nx_uint8_t;typedef uint8_t __nesc_nxbase_nx_uint8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nx_uint16_t;typedef uint16_t __nesc_nxbase_nx_uint16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nx_uint32_t;typedef uint32_t __nesc_nxbase_nx_uint32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nx_uint64_t;typedef uint32_t __nesc_nxbase_nx_uint64_t  ;


typedef struct { char _data[1]; } /*__attribute__((packed))*/ nxle_int8_t;typedef int8_t __nesc_nxbase_nxle_int8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nxle_int16_t;typedef int16_t __nesc_nxbase_nxle_int16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nxle_int32_t;typedef int32_t __nesc_nxbase_nxle_int32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nxle_int64_t;typedef int32_t __nesc_nxbase_nxle_int64_t  ;
typedef struct { char _data[1]; } /*__attribute__((packed))*/ nxle_uint8_t;typedef uint8_t __nesc_nxbase_nxle_uint8_t  ;
typedef struct { char _data[2]; } /*__attribute__((packed))*/ nxle_uint16_t;typedef uint16_t __nesc_nxbase_nxle_uint16_t  ;
typedef struct { char _data[4]; } /*__attribute__((packed))*/ nxle_uint32_t;typedef uint32_t __nesc_nxbase_nxle_uint32_t  ;
typedef struct { char _data[8]; } /*__attribute__((packed))*/ nxle_uint64_t;typedef uint32_t __nesc_nxbase_nxle_uint64_t  ;

typedef nx_int8_t nx_bool;

typedef nx_struct cc2420_header_t {
  nxle_uint8_t length;
  nxle_uint16_t fcf;
  nxle_uint8_t dsn;
  nxle_uint16_t destpan;
  nxle_uint16_t dest;
  nxle_uint16_t src;






  nxle_uint8_t type;
} /*__attribute__((packed))*/ 




cc2420_header_t;







//#line 72
typedef nx_struct cc2420_footer_t {

  nxle_uint8_t i;
} /*__attribute__((packed))*/ cc2420_footer_t;
//#line 96
//#line 81
typedef nx_struct cc2420_meta_data_t {
  nx_uint8_t tx_power;
  nx_uint8_t rssi;
  nx_uint8_t lqi;
  nx_bool crc;
  nx_bool ack;
  nx_uint16_t time;
  nx_uint16_t rxInterval;



  nx_uint16_t maxRetries;
  nx_uint16_t retryDelay;
} /*__attribute__((packed))*/ 

cc2420_meta_data_t;


typedef union message_header {
  cc2420_header_t cc2420;
} 
message_header_t;



//#line 12
typedef union TOSRadioFooter {
  cc2420_footer_t cc2420;
} message_footer_t;



//#line 16
typedef union TOSRadioMeta_data {
  cc2420_meta_data_t cc2420;
} message_meta_data_t;


typedef nx_struct message_t {
  nx_uint8_t header[sizeof(message_header_t )];
  nx_uint8_t _data[114];
  nx_uint8_t footer[sizeof(message_footer_t )];
  nx_uint8_t meta_data[sizeof(message_meta_data_t )];
} /*__attribute__((packed))*/ message_t;



