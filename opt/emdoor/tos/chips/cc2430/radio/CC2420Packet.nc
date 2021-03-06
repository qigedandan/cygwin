

#include "message.h"

interface CC2420Packet {
  
  /**
   * Get transmission power setting for current packet.
   *
   * @param the message
   */
  async command uint8_t getPower( message_t* p_msg );

  /**
   * Set transmission power for a given packet. Valid ranges are
   * between 0 and 31.
   *
   * @param p_msg the message.
   * @param power transmission power.
   */
  async command void setPower( message_t* p_msg, uint8_t power );
  
  /**
   * Get rssi value for a given packet. For received packets, it is
   * the received signal strength when receiving that packet. For sent
   * packets, it is the received signal strength of the ack if an ack
   * was received.
   */
  async command int8_t getRssi( message_t* p_msg );



  /**Added by XLQ   2008-3, for used in XMesh */
  async command void setRssi( message_t* p_msg, uint8_t rssi);


  /**
   * Get lqi value for a given packet. For received packets, it is the
   * link quality indicator value when receiving that packet. For sent
   * packets, it is the link quality indicator value of the ack if an
   * ack was received.
   */
  async command uint8_t getLqi( message_t* p_msg );
  
}
