
 
generic configuration OSAAlarmMilli32C()
{
  provides interface Init;
  provides interface Alarm<TMilli,uint32_t>;
}
implementation
{

    components new OSAAlarm32khz16C() as AlarmFrom;
    components OSACounterMilli32C as Counter;
    components new TransformAlarmC(TMilli,uint32_t,T32khz,uint16_t,5) as Transform;

    Init = AlarmFrom;
    Alarm = Transform;

    Transform.AlarmFrom -> AlarmFrom;
    Transform.Counter -> Counter;
    
}

