

module AtpCmdCommP
{
	provides interface StdControl;
	provides interface AtpCmdComm;

	uses interface StdControl as AtpUartStdControl;
	uses interface AtpUart;
	
	uses interface AtpCmdPacket;
}
implementation
{
	uint16_t m_packet_len = 0;
	uint8_t m_packet_buf[sizeof(atp_cmd_packet_t)+1];


	/*============================================================*/
	command error_t StdControl.start()
	{
		return call AtpUartStdControl.start();
	}

	command error_t StdControl.stop()
	{
		return call AtpUartStdControl.stop();
	}
	/*============================================================*/
	/* Packet Control */
	command error_t AtpCmdComm.sendCmdPacket(atp_cmd_packet_t *packet)
	{
		/* fill into the buffer now */
		atomic {
			/* generate packet stream */
			call AtpCmdPacket.generatePacket(packet, m_packet_buf, &m_packet_len);
			
			/* add to buffer and send */
			call AtpUart.sendData(m_packet_buf, m_packet_len);
		}
		
		return SUCCESS;
	}

	
	event void AtpCmdPacket.receivedPacket(atp_cmd_packet_t *packet)
	{
		signal AtpCmdComm.receivedCmdPacket(packet, SUCCESS);
	}


	task void signalSendCmdPacketDone()
	{
	}
	default event void AtpCmdComm.sendCmdPacketDone(atp_cmd_packet_t *packet, error_t error) {}
	

	/*=== receive ===*/
	event void AtpUart.receivedByte( uint8_t byte )
	{
		call AtpCmdPacket.receiveNext(&byte, 1);
	}


}


