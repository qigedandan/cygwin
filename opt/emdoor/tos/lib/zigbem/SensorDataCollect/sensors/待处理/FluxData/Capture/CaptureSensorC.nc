generic configuration CaptureSensorC(uint32_t timeout)
{
    provides interface CaptureSensor;
}
implementation
{
    components new CaptureSensorM(timeout);

    CaptureSensor = CaptureSensorM;
    
    components HplCC2430Timer1AlarmCounterC;

    CaptureSensorM.GpioCapture -> HplCC2430Timer1AlarmCounterC.CaptureChannel2;


    components new TimerMilliC();
    CaptureSensorM.Timer -> TimerMilliC;
}
