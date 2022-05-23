
interface FlashIEEE
{
	command uint16_t GetPANID();
	command uint16_t GetShortAddress();
	command void GetIEEE(uint8_t *ieee);
	command void WriteToRegister();
	command void WriteToAM();
}

