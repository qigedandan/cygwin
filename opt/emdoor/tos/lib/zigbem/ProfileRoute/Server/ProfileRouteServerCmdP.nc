
module ProfileRouteServerCmdP {

	provides interface ProfileRouteServerCmd;

	uses interface AtpCmdComm;

}
implementation{

	profile_route_info_t m_routeInfo;
	atp_cmd_packet_t m_atpPacket;

	/*****************************/
	void recievePacketPing(atp_cmd_packet_t *packet)
	{
		signal ProfileRouteServerCmd.ping();
	}
	void recievePacketSet(atp_cmd_packet_t *packet)
	{
		memset(&m_routeInfo,0,sizeof(profile_route_info_t));
		memcpy(&m_routeInfo,&(packet->data),(packet->len));
		signal ProfileRouteServerCmd.setRouteInfo(&m_routeInfo);
	}
	/*****************************/
	
	command error_t ProfileRouteServerCmd.pingAck(){
		memset(&m_atpPacket,0,sizeof(atp_cmd_packet_t));
		
		m_atpPacket.cmd = PRSERVER_CMD_PING_ACK ;
		m_atpPacket.len = 0 ;
		
		call AtpCmdComm.sendCmdPacket(&m_atpPacket);
	}
	
	command error_t ProfileRouteServerCmd.updateRouteInfo(profile_route_info_t *routeInfo){
		memset(&m_atpPacket,0,sizeof(atp_cmd_packet_t));
		
		m_atpPacket.cmd = PRSERVER_CMD_UPDATE ;
		m_atpPacket.len = (routeInfo->len)*sizeof(uint16_t) + ROUTE_HEADER_SIZE;
		memcpy(&(m_atpPacket.data),routeInfo,m_atpPacket.len);
		
		call AtpCmdComm.sendCmdPacket(&m_atpPacket);

	}

	command error_t ProfileRouteServerCmd.pingRouteInfo(profile_route_info_t* routeInfo) {
		memset(&m_atpPacket, 0, sizeof(atp_cmd_packet_t));

		m_atpPacket.cmd = PRSERVER_CMD_NODE_PING;
		m_atpPacket.len = (routeInfo->len)*sizeof(uint16_t) + ROUTE_HEADER_SIZE;

		memcpy(&(m_atpPacket.data), routeInfo, m_atpPacket.len);

		call AtpCmdComm.sendCmdPacket(&m_atpPacket);
	}
	

	event void AtpCmdComm.receivedCmdPacket(atp_cmd_packet_t *packet, error_t error){
		switch(packet->cmd){
		case PRSERVER_CMD_PING:
			recievePacketPing(packet);
			break;
		case PRSERVER_CMD_SET:
			recievePacketSet(packet);
			break;
		default:
			break;
		}
	}

	event void AtpCmdComm.sendCmdPacketDone(atp_cmd_packet_t *packet, error_t error){}	

	default event void ProfileRouteServerCmd.ping(){}
	default event void ProfileRouteServerCmd.setRouteInfo(profile_route_info_t *routeInfo){}

}	

