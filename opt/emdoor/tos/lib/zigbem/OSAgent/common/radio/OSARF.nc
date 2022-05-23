
#include "OSARF.h"
/* interface for OSAgent RF */

interface OSARF
{
/**
	 * sendPacket will perform a CCA, put the device into transmit mode,
	 * send the packet and return. If the SPI bus is not free or CCA
	 * fails, the sending of the packet is delayed. The contents
	 * of the packet must not be changed after the call to sendPacket.
	 *
	 * @param uint8_t * packet The packet that should be sent.
	 * @return error_t If the packet was queued for sending successfully.
	 */
	command error_t sendPacket(uint8_t * packet);

	/**
	 * sendPacketDone is signaled when a packet have been sent successfully.
	 *
	 * @param packet_t *packet The packet that have been sent.
	 * @param error_t result If the packet was sent successfully.
	 */
	async event void sendPacketDone(uint8_t * packet, error_t result);

	/**
	 * receivedPacket is signalled when the radio have received a full
	 * packet.  The function must return a free uint8_t * to the radio
	 * stack. This can be the same packet that have been signaled
	 *
	 * @param uint8_t *packet The received packet
	 * @return uint8_t* A free packet
	 */
	event uint8_t * receivedPacket(uint8_t * packet);

	command error_t setChannel(uint8_t channel);
	command error_t setTransmitPower(uint8_t power);

	command error_t setAddress(mac_addr_t *addr);
	command const mac_addr_t * getAddress();
	command const ieee_mac_addr_t * getExtAddress();

	command error_t rxEnable();
	command error_t rxDisable();

	command error_t addressFilterEnable();
	command error_t addressFilterDisable();

	command error_t setPanAddress(mac_addr_t *addr);
	command const mac_addr_t * getPanAddress();

	command bool getCCA();
}
