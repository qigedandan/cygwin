
 
generic configuration AlarmMilli16C()
{
  provides interface Init;
  provides interface Alarm<TMilli,uint16_t>;
}
implementation
{

    components new Alarm32khz16C() as AlarmFrom;
    components CounterMilli16C as Counter;
    components new TransformAlarmC(TMilli,uint16_t,T32khz,uint16_t,5) as Transform;

    Init = AlarmFrom;
    Alarm = Transform;

    Transform.AlarmFrom -> AlarmFrom;
    Transform.Counter -> Counter;
    
}

