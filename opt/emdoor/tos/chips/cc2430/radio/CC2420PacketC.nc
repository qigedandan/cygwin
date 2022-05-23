

#include "IEEE802154.h"

module CC2420PacketC {

  provides interface CC2420Packet;
  provides interface PacketAcknowledgements as Acks;

}

implementation {

  cc2420_header_t* getHeader( message_t* msg ) {
    return (cc2420_header_t*)( msg->data - sizeof( cc2420_header_t ) );
  }

  cc2420_metadata_t* getMetadata( message_t* msg ) {
    return (cc2420_metadata_t*)msg->metadata;
  }

  async command error_t Acks.requestAck( message_t* p_msg ) {
    getHeader( p_msg )->fcf |= 1 << IEEE154_FCF_ACK_REQ;
    return SUCCESS;
  }

  async command error_t Acks.noAck( message_t* p_msg ) {
    getHeader( p_msg )->fcf &= ~(1 << IEEE154_FCF_ACK_REQ);
    return SUCCESS;
  }

  async command bool Acks.wasAcked( message_t* p_msg ) {
    return getMetadata( p_msg )->ack;
  }

  async command void CC2420Packet.setPower( message_t* p_msg, uint8_t power ) {
    if ( power > 31 )
      power = 31;
    getMetadata( p_msg )->tx_power = power;
  }

  async command uint8_t CC2420Packet.getPower( message_t* p_msg ) {
    return getMetadata( p_msg )->tx_power;
  }
   
  async command int8_t CC2420Packet.getRssi( message_t* p_msg ) {
    return getMetadata( p_msg )->rssi;
  }

  /*** Added by XLQ for XMesh 2008-3 */
  async command void CC2420Packet.setRssi( message_t* p_msg, uint8_t rssi ) {
     getMetadata( p_msg )->rssi = rssi;
  }

  async command error_t CC2420Packet.getLqi( message_t* p_msg ) {
    return getMetadata( p_msg )->lqi;
  }

}
