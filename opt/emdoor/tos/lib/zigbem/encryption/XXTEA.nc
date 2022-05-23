
interface XXTEA
{
	command error_t encrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector);
	command error_t decrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector);
}

