/*************************************************
*	FUNCTION NAME : AesM.nc
*	FUNCTION DESCRIPTION :
*	FUCNTION DATE :2010/10/15
*	FUNCTION AUTHOR: EMDOOR
**/

#define DBG_LEV	9
#include "aes.h"

module AesM
{
	uses interface Boot;
	uses interface Aes;
}
implementation
{
#define STRING_LENGTH       16
#define STRING_LENGTH_DMA 	2*16

#define LENGTH_IV  16
#define LENGTH_KEY 16

uint8_t key[LENGTH_KEY] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x11};
uint8_t IV[LENGTH_IV ] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

char plainText[STRING_LENGTH];
char cipherText[STRING_LENGTH];

	task void doAes()
	{
	uint8_t i;
		call Aes.setMode(CTR);
		call Aes.loadKey(key);

	    memset(plainText,' ', STRING_LENGTH);
   		memset(cipherText,' ', STRING_LENGTH);

   		ADBG(DBG_LEV,"\r\nplainText before aes\r\n");

   		for(i=0;i<STRING_LENGTH;i++)
		{
			ADBG(DBG_LEV,"%c",plainText[i]);
		}
		
   		ADBG(DBG_LEV,"\r\ncipherText before aes\r\n");

		for(i=0;i<STRING_LENGTH;i++)
		{
			ADBG(DBG_LEV,"%c",cipherText[i]);
		}

   		ADBG(DBG_LEV,"\r\nplainText before aes\r\n");

		strcpy(plainText, (char*)"AES Demo");

		for(i=0;i<STRING_LENGTH;i++)
		{
			ADBG(DBG_LEV,"%c",plainText[i]);
		}
		
		call Aes.encrypt(plainText,STRING_LENGTH,cipherText,IV);

   		ADBG(DBG_LEV,"\r\ncipherText after aes\r\n");

		for(i=0;i<STRING_LENGTH;i++)
		{
			ADBG(DBG_LEV,"%c",cipherText[i]);
		}		

		call Aes.decrypt(cipherText,STRING_LENGTH,plainText,IV);

		ADBG(DBG_LEV, "\r\nafter decrypt\r\n");

		for(i=0;i<STRING_LENGTH;i++)
		{
			ADBG(DBG_LEV,"%c",plainText[i]);
		}		
	}
	
	event void Boot.booted()
	{
		post doAes();
	}
}

