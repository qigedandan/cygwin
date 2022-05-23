module CC2430SpiP {	
  provides  interface SpiControl;
  provides	interface SpiByte;
  provides	interface SpiPacket;	

  uses interface CC2430Spi as Spi;
}
implementation {   
  async command void SpiControl.startSpi() {
    atomic {
      call Spi.initMaster();
      call Spi.setClockPolarity(TRUE);
      call Spi.setClockPhase(TRUE);
      call Spi.setRate(9600);
      call Spi.enableSpi(TRUE);
    }
  }

  async command void SpiControl.stopSpi() {
    call Spi.enableSpi(FALSE);
  }

  async command void SpiByte.write( uint8_t tx ) {
    call Spi.write( tx );
  }
  
  async command uint8_t SpiByte.read() {
    return call Spi.read();
  }
  
  task void SpiFinishTask() {
	signal SpiPacket.sendDone(SUCCESS);
  }
  
  async command error_t SpiPacket.send(uint8_t len,uint8_t *value) {
	uint8_t i;
	uint8_t data;
	for(i = 0;i < len; i++)
	{
		data = *(value+i);
		call Spi.write(data);
	}
	
	post SpiFinishTask();
	return SUCCESS;	
  }
  
  default event void SpiPacket.sendDone(error_t result) {}
}




