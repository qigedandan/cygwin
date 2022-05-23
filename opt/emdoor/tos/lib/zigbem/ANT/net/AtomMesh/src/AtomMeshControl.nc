interface AtomMeshControl
{
    command void setSleepTime(uint32_t ms);
    command uint32_t getSleepTime();

    command void setActiveTime(uint32_t ms);
    command uint32_t getActiveTime();

    command uint32_t getTotalTime();
    
    command void enableLowPower(bool enabled);
}

