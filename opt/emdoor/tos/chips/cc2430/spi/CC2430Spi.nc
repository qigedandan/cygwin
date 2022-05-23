interface CC2430Spi {

  /** Initialize the CC2430 SPI bus into master mode.*/
  async command void initMaster();

  /** Initialize the CC2430 SPI bus into slave mode. */
  async command void initSlave();

  /** 
   * Read the SPI data register 
   * @return last data byte
   */
  async command uint8_t read();

  /** 
   * Write the SPI data register 
   * @param data   next data byte
   */
  async command void write(uint8_t data);
  
  /* SPCR: SPI Control Register */
  /* SPI bit */
  async command void enableSpi(bool enabled);
  //async command bool isSpiEnabled();
  /* DORD bit */
  async command void setDataOrder(bool lsbFirst);
  async command bool isOrderLsbFirst();
  /* MSTR bit */
  async command void setMasterBit(bool isMaster);
  async command bool isMasterBitSet();
  /* CPOL bit */
  async command void setClockPolarity(bool highWhenIdle);
  async command bool getClockPolarity();
  /* CPHA bit */
  async command void setClockPhase(bool sampleOnTrailing);
  async command bool getClockPhase();
  /* SPR1 and SPR0 bits */
  async command void setRate (uint16_t rate);
}
