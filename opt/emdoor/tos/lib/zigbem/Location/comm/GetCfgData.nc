
interface GetCfgData
{

	command void Write(uint8_t *data,uint8_t len);
	
	command void Read(uint8_t *data,uint8_t len);
}
