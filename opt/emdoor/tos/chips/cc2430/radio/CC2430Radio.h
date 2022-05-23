

#ifndef __CC2430_RADIO_H__
#define __CC2430_RADIO_H__

//#include "message.h"

#include "AM.h"
#include "IEEE802154.h"

#ifndef TOSH_DATA_LENGTH
#define TOSH_DATA_LENGTH 100
#endif

#ifndef CC2430_DEF_CHANNEL
#define CC2430_DEF_CHANNEL 11
#endif

#ifndef CC2430_DEF_RFPOWER
#define CC2430_DEF_RFPOWER 31
#endif

typedef uint8_t cc2430radio_status_t;
typedef nxle_uint16_t mac_addr_t;
typedef uint8_t ieee_mac_address_t;
typedef struct {
  int8_t rssi;
  uint8_t correlation;
} fsc_t;


typedef nx_struct cc2430radio_header_t {
  nxle_uint8_t length;
  nxle_uint16_t fcf;
  nxle_uint8_t dsn;
  mac_address_t dest;
  mac_address_t src;
  nxle_uint8_t type;
  nx_am_group_t group;
} cc2430radio_header_t;

typedef nx_struct cc2430radio_footer_t {
  // Something or Keil barfs!!
  nxle_uint8_t  i;
} cc2430radio_footer_t;

typedef nx_struct cc2430radio_metadata_t {
  nx_uint8_t tx_power;
  nx_uint8_t rssi;
  nx_uint8_t lqi;
  nx_bool crc;
  nx_bool ack;
  nx_uint16_t time;
} cc2430radio_metadata_t;

typedef nx_struct cc2430radio_packet_t {
  cc2430radio_header_t packet;
  //nx_uint8_t data[]; // nogo in Keil!
  nx_uint8_t data[TOSH_DATA_LENGTH];
} cc2430radio_packet_t;


enum {
  // size of the header not including the length byte
  MAC_HEADER_SIZE = sizeof( cc2430radio_header_t ) - 1,
  // size of the footer (FCS field)
  MAC_FOOTER_SIZE = sizeof( uint16_t ),
  //
  MAC_HEADER_FOOTER_SIZE = MAC_HEADER_SIZE + MAC_FOOTER_SIZE,
  // MDU
  MAC_PACKET_SIZE = MAC_HEADER_SIZE + TOSH_DATA_LENGTH + MAC_FOOTER_SIZE,
};


#endif
