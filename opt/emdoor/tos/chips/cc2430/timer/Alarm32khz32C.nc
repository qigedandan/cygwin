

generic configuration Alarm32khz32C()
{
    provides interface Alarm<T32khz,uint32_t> as Alarm;
}
implementation
{
    components new Alarm32khz16C();
    components new TransformAlarmC(T32khz,uint32_t,T32khz,uint16_t,0) as Transform;
    components Counter32khz32C;

    Alarm = Transform;

    Transform.AlarmFrom -> Alarm32khz16C.Alarm;
    Transform.Counter -> Counter32khz32C.Counter;
}
