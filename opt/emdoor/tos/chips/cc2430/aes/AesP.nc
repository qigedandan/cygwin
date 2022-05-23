module AesP {

  provides interface Init;
  provides interface Aes;

}

implementation
{

#define DELAY 0x0F

	uint8_t *pDataIn;
	uint8_t *pDataOut;
	uint8_t mode;
	uint16_t mLength;
	uint16_t nbrOfBlocks;
	uint16_t convertedBlock;

	void aesProcess()
	{
		uint16_t i;
   		uint8_t j, k;
   		uint8_t delay;

	   nbrOfBlocks = mLength / 16;
	   mode = 0;

	   if( (mLength % 16) != 0){
    	  // length not multiplum of 16, convert one block extra with zeropadding
	      nbrOfBlocks++;
	   }
	   
		mode = ENCCS & 0x70;

   		for(convertedBlock = 0; convertedBlock < nbrOfBlocks; convertedBlock++){
      		// Starting the conversion.
      		AES_START();

      		i = convertedBlock * 16;
      		// Counter, Output Feedback and Cipher Feedback operates on 4 bytes and not 16 bytes.
      		if((mode == CFB) || (mode == OFB) || (mode == CTR)){
        		for(j = 0; j < 4; j++){
            		// Writing the input data
            		// Zeropadding the remainder of the block
            		for(k = 0; k < 4; k++){
               		ENCDI = ((i + 4*j + k < mLength) ? pDataIn[i + 4*j + k] : 0x00 );
            	}
            	// wait for data ready
            	delay = DELAY;
            	while(delay--);
            	// Read out data for every 4th byte
            	for(k = 0; k < 4; k++){
               		pDataOut[i + 4*j + k] = ENCDO;
            	}
        	}
      	}
      	else if(mode == CBC_MAC){
         	// Writing the input data
         	// Zeropadding the remainder of the block
         	for(j = 0; j < 16; j++){
            	ENCDI = ((i + j < mLength) ? pDataIn[i + j] : 0x00 );
         	}
         	// The last block of the CBC-MAC is computed by using CBC mode.
         	if(convertedBlock == nbrOfBlocks - 2){
            	AES_SETMODE(CBC);
            	delay = DELAY;
            	while(delay--);
         	}
         	// The CBC-MAC does not produce an output on the n-1 first blocks
         	// only the last block is read out
         	else if(convertedBlock == nbrOfBlocks - 1){
            	// wait for data ready
            	delay = DELAY;
            	while(delay--);
            	for(j = 0; j < 16; j++){
               	pDataOut[j] = ENCDO;
            	}
         	}
      	}
      	else{
         	// Writing the input data
         	// Zeropadding the remainder of the block
         	for(j = 0; j < 16; j++){
            	ENCDI = ((i+j < mLength) ? pDataIn[i+j] : 0x00 );
         	}
         	// wait for data ready
         	delay = DELAY;
         	while(delay--);
         	// Read out data
         	for(j = 0; j < 16; j++){
            	pDataOut[i+j] = ENCDO;
         	}
      	}
      }
	}
	
	void LoadKeyOrInitVector(uint8_t *pDat,uint8_t key)
	{
	   	uint8_t i;

		// Checking whether to load a key or an initialisation vector.
	   if(key){
    	  AES_SET_ENCR_DECR_KEY_IV(AES_LOAD_KEY);
	   }
	   else {
    	  AES_SET_ENCR_DECR_KEY_IV(AES_LOAD_IV);
	   }
	   // Starting loading of key or vector.
	   AES_START();

	   // loading the data (key or vector)
	   for(i = 0; i < 16; i++){
    	  ENCDI = pDat[i];
	   }	
	}

	command error_t Aes.encrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector)
	{
		pDataIn = pSrc ;
		mLength = length ;
		pDataOut = pDest ;

		LoadKeyOrInitVector(pInitVector,FLAG_INIT_VECT);
		
		AES_SET_ENCR_DECR_KEY_IV(AES_DECRYPT);
		
		aesProcess();
	}

	command error_t Aes.decrypt(uint8_t *pSrc, uint16_t length, uint8_t *pDest, uint8_t *pInitVector)
	{
		pDataIn = pSrc ;
		mLength = length ;
		pDataOut = pDest ;

		LoadKeyOrInitVector(pInitVector,FLAG_INIT_VECT);
		
		AES_SET_ENCR_DECR_KEY_IV(AES_DECRYPT);
		
		aesProcess();
	}

	command error_t Aes.loadKey(uint8_t *pData)
	{
		LoadKeyOrInitVector(pData,FLAG_LOAD_KEY);
	}
	
	command error_t Aes.initVector(uint8_t *pData)
	{
		LoadKeyOrInitVector(pData,FLAG_INIT_VECT);
	}
	
	command error_t Aes.setMode(uint8_t mMode)
	{
		AES_SETMODE(mMode);
	}

	command error_t Init.init()
	{
		
	}
	
}

