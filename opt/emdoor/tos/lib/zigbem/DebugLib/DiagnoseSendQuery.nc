
interface DiagnoseSendQuery
{
	command error_t sendCmd(uint16_t id);
	//event void receivedAck(uint8_t* buf, uint8_t len);
	event void receivedAck(char* string);
}
