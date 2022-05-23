
interface HplCC2430I2CBus {

  async command void setStart();
  async command void setStop();   
  
  async command void writeByte(uint8_t data);
  async command uint8_t readByte();
  
  async command void Setting(uint16_t addr,uint8_t len,uint8_t *pdat);
  
  
  async command error_t read(uint16_t addr, uint8_t length, uint8_t* data);
  async command error_t write(uint16_t addr, uint8_t length, uint8_t* data);
  async event void readDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data);
  async event void writeDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data);
  
  
  
}
