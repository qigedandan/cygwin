 #include <ioCC2430.h>
 #include "mcs51hardware.h"
 
 module HplCC2430SpiP {
  provides interface CC2430Spi as SPI;
  
  uses {
    interface GeneralIO as SS;   // Slave set line
    interface GeneralIO as SCK;  // SPI clock line
    interface GeneralIO as MOSI; // Master out, slave in
    interface GeneralIO as MISO; // Master in, slave out
  }
}
implementation {
  async command void SPI.initMaster() {
    call MOSI.makeOutput();
    call MISO.makeInput();
    call SCK.makeOutput();
	call SS.makeOutput();
    call SPI.setMasterBit(TRUE);
  }

  async command void SPI.initSlave() {
    call MISO.makeOutput();
    call MOSI.makeInput();
    call SCK.makeInput();
    call SS.makeInput();
    call SPI.setMasterBit(FALSE);
  }
   
  async command uint8_t SPI.read() { 
    call SS.clr();
	while (READ_BIT(U1CSR,0));		//等待接收数据完成
	call SS.set();
	return U1BUF; 
  }
  
  async command void SPI.write(uint8_t data) {
	call SS.clr();
	U1BUF = data;
	while(U1CSR & READ_BIT(U1CSR,0)); 
	call SS.set();
  }
  
  //=== SPI Bus utility routines. ==================
  /*MODE bit*/
  async command void SPI.enableSpi(bool enabled) {
    if (enabled) {
	  CLR_BIT(U1CSR, 7);
    }
    else {
      SET_BIT(U1CSR, 7);
    }
  }

  /* ORDER bit */
  async command void SPI.setDataOrder(bool lsbFirst) {
    if (lsbFirst) {
      CLR_BIT(U1GCR, 5);
    }
    else {
      SET_BIT(U1GCR, 5);
    }
  }
  
  async command bool SPI.isOrderLsbFirst() {
    return READ_BIT(U1GCR, 5);
  }
  
  /* SLAVE bit */
  async command void SPI.setMasterBit(bool isMaster) {
    if (isMaster) {
      CLR_BIT(U1CSR, 5);
    }
    else {
      SET_BIT(U1CSR, 5);
    }
  }
  async command bool SPI.isMasterBitSet() {
    return READ_BIT(U1CSR, 5);
  }
  
  /* CPOL bit */
  async command void SPI.setClockPolarity(bool highWhenIdle) {
    if (highWhenIdle) {
      SET_BIT(U1GCR, 7);
    }
    else {
      CLR_BIT(U1GCR, 7);
    }
  }
  
  async command bool SPI.getClockPolarity() {
    return READ_BIT(U1GCR, 7);
  }
  
  /* CPHA bit */
  async command void SPI.setClockPhase(bool sampleOnTrailing) {
    if (sampleOnTrailing) {
      SET_BIT(U1GCR, 6);
    }
    else {
      CLR_BIT(U1GCR, 6);
    }
  }
  
  async command bool SPI.getClockPhase() {
    return READ_BIT(U1GCR, 6);
  }

  async command void SPI.setRate (uint16_t rate) {
	switch(rate)
	{
		case 9600: 
			U1BAUD = 59;
			U1GCR &= ~0X1F;			
			U1GCR |= 8;
			break;
		case 38400:
			U1BAUD = 59;
			U1GCR &= ~0X1F;	
			U1GCR = 10;
			break;
		case 115200:
			U1BAUD = 216;
			U1GCR &= ~0X1F;	
			U1GCR = 11;
			break;
		default:
			U1BAUD = 59;
			U1GCR &= ~0X1F;	
			U1GCR = 8;
			break;
	}
  }
}
