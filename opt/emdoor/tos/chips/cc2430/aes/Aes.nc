
#include "aes.h"

interface Aes {

  command error_t setMode(uint8_t mMode);
  command error_t loadKey(uint8_t *pData);
  command error_t initVector(uint8_t *pData);
  command error_t encrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector);
  command error_t decrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector);

//  async event void ();
}

