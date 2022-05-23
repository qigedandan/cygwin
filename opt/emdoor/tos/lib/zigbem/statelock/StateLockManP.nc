generic module StateLockManP(uint8_t NUM_LOCK)
{
	provides interface Init;
	provides interface StateLock[uint8_t num];
	provides interface StateLockMan;
}
implementation
{
	#define LOCK_BITMAP_COUNT (NUM_LOCK/8 + 1)
	norace uint8_t m_lock_bitmap[LOCK_BITMAP_COUNT];

	command error_t Init.init()
	{
		atomic
		{
			memset(m_lock_bitmap, 0, sizeof(m_lock_bitmap));
		}
    	
		return SUCCESS;
	}

	
	command void StateLockMan.reset()
	{
		atomic
		{
			memset(m_lock_bitmap, 0, sizeof(m_lock_bitmap));
		}
	}
    
	command void StateLock.lock[uint8_t num]()
	{
		ADBG(DBG_LEV, "  @ -->StateLock.lock %d\n", (int)num);
		atomic
		{
			m_lock_bitmap[num/8] |= _BV(num%8);
		}
		
		signal StateLockMan.lockFired();
	}

	command void StateLock.unlock[uint8_t num]()
	{
		ADBG(DBG_LEV, "  @ <--StateLock.unlock %d\n", (int)num);
		atomic
		{
			m_lock_bitmap[num/8] &= ~_BV(num%8);
		}
		
		signal StateLockMan.unlockFired();
	}

	command bool StateLockMan.isLocked()
	{
		atomic
		{
			bool locked = FALSE;
			uint8_t i;
			
			for (i=0; i < LOCK_BITMAP_COUNT; ++i)
			{
				if (m_lock_bitmap[i])
				{
					locked = TRUE;
					break;
				}
			}

			return locked;
		}
	}

	default event void StateLockMan.lockFired() {}
	default event void StateLockMan.unlockFired() {}
}

