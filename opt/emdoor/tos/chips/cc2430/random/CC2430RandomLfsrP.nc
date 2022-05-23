
module CC2430RandomLfsrP
{
  provides interface Init;
  provides interface Random;
}
implementation
{

// enabling the random generator
inline void enableRandomGenerator()
{
	ADCCON1 &= ~0x0C; 
}

// clocking the random generator
inline void clockRandomGenerator()
{
	ADCCON1 |= 0x04; 
}

  command error_t Init.init() {
    atomic {
    uint8_t i;

	// turning on power to analog part of radio
   	_CC2430_RFPWR = 0x04;

   	// waiting for voltage regulator.
   	while( _CC2430_RFPWR & 0x10 );

   	// Turning on receiver to get output from IF-ADC
   	RFST = 0xE2;

	//wait 
   	for(i=0;i<0xff;i++);

   	enableRandomGenerator();

   	for(i = 0 ; i < 32 ; i++)
   	{
      RNDH = _CC2430_ADCTSTH;
      clockRandomGenerator();
   	}

    }
    return SUCCESS;
  }

  /* Return the next 16 bit random number */
  async command uint16_t Random.rand16() {
	clockRandomGenerator();
	return (uint16_t) RNDH << 8 | RNDL ;
  }

  async command uint32_t Random.rand32() {
    return (uint32_t)call Random.rand16() << 16 | call Random.rand16();
  }
}
