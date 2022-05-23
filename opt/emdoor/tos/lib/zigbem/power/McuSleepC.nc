configuration McuSleepC
{
    provides interface McuSleep;
    provides interface McuSleepControl;
}
implementation
{
    components McuSleepP;
    McuSleep = McuSleepP;
    McuSleepControl = McuSleepP;

    components McuSleepLockManC;
    McuSleepP.McuSleepLockMan -> McuSleepLockManC;

  
   //components new VirtualizedSleepAlarmMilli32C();
 
  //McuSleepP.SleepAlarm -> VirtualizedSleepAlarmMilli32C;
}

