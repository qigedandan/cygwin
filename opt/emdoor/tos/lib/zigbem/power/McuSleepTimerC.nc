configuration McuSleepTimerC
{
    provides interface Alarm<T32khz, uint32_t> as Alarm;
}
implementation
{
    components McuSleepTimerP;
    Alarm = McuSleepTimerP.Alarm;
    
    //mponents McuGlobalTimerP;    
    //uSleepTimerP.McuGlobalTimer -> McuGlobalTimerP;
}
