
module GetCfgDataP
{
    provides interface GetCfgData;
    uses interface HalFlash;
}

implementation
{    
#define BASE_FLASH_ADDR 0x1f000
        command void GetCfgData.Write(uint8_t *data,uint8_t len)
        {
            call HalFlash.erase((uint8_t*)BASE_FLASH_ADDR);
            call HalFlash.write((uint8_t*)(BASE_FLASH_ADDR), data, len);
            //ADBG(DBG_LEV, "\r\nGetCfgData ____Write__para_a = %d , para_n = %d \r\n",(int)(data[0]),(int)(data[1]));
        }
        command void GetCfgData.Read(uint8_t *data,uint8_t len)
        {
            call HalFlash.read( data,(uint8_t*)(BASE_FLASH_ADDR),  len);
		//ADBG(DBG_LEV, "\r\GetCfgData ____Read__para_a = %d , para_n = %d \r\n",(int)(data[0]),(int)(data[1]));
        }
        
}
