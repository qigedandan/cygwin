
//in face in the flash 0x1fff8, use MEMCTR.FMAP to access this one
#define CC2430_FLASH_IEEE_BASE		0xFFF8
#define CC2430_FLASH_IEEE_FMAP		3

#define CC2430_FLASH_IEEE_BYTE(n)		(*(uint8_t_code *)(CC2430_FLASH_IEEE_BASE+n))

module FlashIEEEP
{
    provides interface Init;
    provides interface FlashIEEE;
    
    uses interface ActiveMessageAddress;
}
implementation
{
    uint8_t m_ieee[8];

    command error_t Init.init()
    {
    	 uint8_t i;
    	 uint16_t old_code_map;
    	 atomic
    	 {
	        ADBG(0, "FlashIEEEC.Init.init  \n");
	        //FLASH:0x18000-0x1FFFF   =>  CODE:0x8000-0xFFFF
	        CC2430_CODE_MAP_SAVE(old_code_map);
	        CC2430_CODE_MAP_TO(CC2430_FLASH_IEEE_FMAP);

	        m_ieee[0] = CC2430_FLASH_IEEE_BYTE(7);
	        m_ieee[1] = CC2430_FLASH_IEEE_BYTE(6);
	        m_ieee[2] = CC2430_FLASH_IEEE_BYTE(5);
	        m_ieee[3] = CC2430_FLASH_IEEE_BYTE(4);
	        m_ieee[4] = CC2430_FLASH_IEEE_BYTE(3);
	        m_ieee[5] = CC2430_FLASH_IEEE_BYTE(2);
	        m_ieee[6] = CC2430_FLASH_IEEE_BYTE(1);
	        m_ieee[7] = CC2430_FLASH_IEEE_BYTE(0);

		for (i=0; i < 8; ++i)
		{
			ADBG(0, "m_ieee[%d] = 0x%x\n", (int)i, (int)m_ieee[i]);
		}
	        //For TOS
	        
	       ADBG(0, "FlashIEEEC.Init.init  OK\n");

	       CC2430_CODE_MAP_LOAD(old_code_map);
        }

        return SUCCESS;
    }

    command uint16_t FlashIEEE.GetPANID()
    {
    	return ((m_ieee[4]<<8) | m_ieee[5]);
    }

    
    command uint16_t FlashIEEE.GetShortAddress()
    {
    	return ((m_ieee[6]<<8) | m_ieee[7]);
    }
    
    command void FlashIEEE.GetIEEE(uint8_t *ieee)
    {
      memcpy(ieee, m_ieee, sizeof(m_ieee));
    }

    
    command void FlashIEEE.WriteToRegister()
    {
       ADBG(1, "_CC2430_PANID =0x%x, _CC2430_SHORTADDR=0x%x\n", call FlashIEEE.GetPANID(), call FlashIEEE.GetShortAddress());


        _CC2430_IEEE_ADDR0 = m_ieee[0];
        _CC2430_IEEE_ADDR1 = m_ieee[1];
        _CC2430_IEEE_ADDR2 = m_ieee[2];
        _CC2430_IEEE_ADDR3 = m_ieee[3];
        _CC2430_IEEE_ADDR4 = m_ieee[4];
        _CC2430_IEEE_ADDR5 = m_ieee[5];
        _CC2430_IEEE_ADDR6 = m_ieee[6];
        _CC2430_IEEE_ADDR7 = m_ieee[7];

        
    	_CC2430_PANID = call FlashIEEE.GetPANID();
    	_CC2430_SHORTADDR = call FlashIEEE.GetShortAddress(); 
    }

    command void FlashIEEE.WriteToAM()
    {
    	call ActiveMessageAddress.setAddress((uint8_t)((call FlashIEEE.GetPANID()) & 0xFF), 
    									 call FlashIEEE.GetShortAddress()
    									);
       TOS_NODE_ID = call FlashIEEE.GetShortAddress();
    	/* History problem :( */
    	TOS_IEEE_SADDR	= call FlashIEEE.GetShortAddress();
	TOS_IEEE_PANID	= call FlashIEEE.GetPANID();
    }

    async event void ActiveMessageAddress.changed()
    {
    	
    }
}

