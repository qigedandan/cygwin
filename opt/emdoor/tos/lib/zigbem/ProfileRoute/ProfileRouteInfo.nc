
interface ProfileRouteInfo
{
	command uint8_t getType(message_t* msg);
	command uint8_t getSensorType(message_t* msg);
	command uint16_t getOriginaddr(message_t* msg);
}

