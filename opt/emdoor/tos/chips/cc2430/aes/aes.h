#ifndef _AES_H_
#define _AES_H_

/******************************************************************************
*************   AES encryption / decryption functions or macros   *************
*******************************************************************************

Functions for performing a encryption or decryption using the Advanced
Encryption Standard. A unique 16 byte key must be loaded prior to the
encryption or decryption process.

The Direct Memory Access (DMA) may also be used for data transfer to and from
the AES module.

******************************************************************************/


#define AES_BUSY        0x08
#define ENCRYPT         0x00
#define DECRYPT         0x01

#define FLAG_INIT_VECT         	0x00
#define FLAG_LOAD_KEY         	0x01

// Macro for setting the mode of the AES operation
#define AES_SETMODE(mode)              \
  do {                                 \
    ENCCS &= ~0x70;                    \
    ENCCS |= mode;                     \
  } while (0)

// _mode_ is one of
#define CBC             0x00
#define CFB             0x10
#define OFB             0x20
#define CTR             0x30
#define ECB             0x40
#define CBC_MAC         0x50

// Macro for starting or stopping encryption or decryption
#define AES_SET_ENCR_DECR_KEY_IV(mode) \
  do {                                 \
    ENCCS &= ~0x07;                    \
    ENCCS |=  mode;                    \
  } while(0)

// Where _mode_ is one of
#define AES_ENCRYPT     0x00
#define AES_DECRYPT     0x02
#define AES_LOAD_KEY    0x04
#define AES_LOAD_IV     0x06


// Macro for starting the AES module for either encryption, decryption,
// key or initialisation vector loading.
#define AES_START()     ENCCS |= 0x01

#endif
