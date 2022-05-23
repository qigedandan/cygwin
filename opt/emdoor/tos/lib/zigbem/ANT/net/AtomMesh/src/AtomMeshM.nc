#include "Wsn.h"
module AtomMeshM
{
    provides interface Wsn;
    
    provides interface Init;
    provides interface StdControl;

    uses interface Init as SubInit;
    uses interface HALCC2420;
    uses interface StdControl as HALCC2420Control;
    uses interface StdControl as RouterControl;
}
implementation
{
    command error_t Wsn.loadIEEE()
    {
        atomic
        {
    	    uint16_t old_code_map;
            //FLASH:0x18000-0x1FFFF   =>  CODE:0x8000-0xFFFF
			CC2430_CODE_MAP_SAVE(old_code_map);
            CC2430_CODE_MAP_TO(EM_IEEE_FMAP);
            
            TOS_IEEE_SADDR = (EM_IEEE_BYTE(1)<<8) | EM_IEEE_BYTE(0);
            TOS_IEEE_PANID = (EM_IEEE_BYTE(3)<<8) | EM_IEEE_BYTE(2);

            //write data to the CC2420 IEEE
            _CC2430_IEEE_ADDR0 = EM_IEEE_BYTE(7);
            _CC2430_IEEE_ADDR1 = EM_IEEE_BYTE(6);
            _CC2430_IEEE_ADDR2 = EM_IEEE_BYTE(5);
            _CC2430_IEEE_ADDR3 = EM_IEEE_BYTE(4);
            _CC2430_IEEE_ADDR4 = EM_IEEE_BYTE(3);
            _CC2430_IEEE_ADDR5 = EM_IEEE_BYTE(2);
            _CC2430_IEEE_ADDR6 = EM_IEEE_BYTE(1);
            _CC2430_IEEE_ADDR7 = EM_IEEE_BYTE(0);

            _CC2430_PANID     = TOS_IEEE_PANID;
            _CC2430_SHORTADDR = TOS_IEEE_SADDR;

            //For TOS
            TOS_NODE_ID = TOS_IEEE_SADDR;
            
			CC2430_CODE_MAP_LOAD(old_code_map);
        }

        return SUCCESS;
    }
    
    command error_t Init.init()
    {
        call Wsn.loadIEEE();
        
        call SubInit.init();
        
        return SUCCESS;
    }

    command error_t StdControl.start()
    {
        call HALCC2420.setChannel(EM_RADIO_CHANNEL);
        call HALCC2420Control.start();
        call RouterControl.start();
        
        return SUCCESS;
    }

    command error_t StdControl.stop()
    {
        call RouterControl.stop();
        call HALCC2420Control.stop();
        
        return SUCCESS;
    }

    async event void HALCC2420.sendPacketDone(uint8_t *packet, error_t result) {}
    event uint8_t * HALCC2420.receivedPacket(uint8_t *packet) {}
}

