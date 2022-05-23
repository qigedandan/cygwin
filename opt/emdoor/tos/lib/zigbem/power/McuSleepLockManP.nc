generic module McuSleepLockManP(uint8_t NUM_LOCK)
{
    provides interface Init;
    provides interface McuSleepLock[uint8_t num];
    provides interface McuSleepLockMan;
}
implementation
{
    norace uint32_t lock_bitmap = 0x00000000;

    command error_t Init.init()
    {
        lock_bitmap = 0x00000000;
        return SUCCESS;
    }
    
    command void McuSleepLock.lock[uint8_t num]()
    {
        atomic
        {
            lock_bitmap |= _BV(num);
        }

        ADBG(1, "\n\n***Lock %d, All=0x%x*********************************\n\n", ADBG_N(num), ADBG_N(lock_bitmap));
    }

    command void McuSleepLock.unlock[uint8_t num]()
    {
        atomic
        {
            lock_bitmap &= ~ _BV(num);
        }
        
        ADBG(1, "\n\n***UNLock %d, All=0x%x *********************************\n\n", ADBG_N(num), ADBG_N(lock_bitmap));
    }

    command bool McuSleepLockMan.isLocked()
    {
        atomic return (lock_bitmap != 0x00000000);
    }
}
