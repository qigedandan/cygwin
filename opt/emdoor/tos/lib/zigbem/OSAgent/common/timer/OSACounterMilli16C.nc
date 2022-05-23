
    
configuration OSACounterMilli16C
{
  provides interface Counter<TMilli,uint16_t>;
}
implementation
{

    components OSACounter32khz16C as CounterFrom;
    components new TransformCounterC(TMilli,uint16_t,T32khz,uint16_t,5,uint32_t) as Transform;

    Counter = Transform.Counter;

    Transform.CounterFrom -> CounterFrom;


}

