
    
configuration CounterMilli32C
{
  provides interface Counter<TMilli,uint32_t>;
}
implementation
{


    components Counter32khz16C as CounterFrom;
    components new TransformCounterC(TMilli,uint32_t,T32khz,uint16_t,5,uint32_t) as Transform;

    Counter = Transform.Counter;

    Transform.CounterFrom -> CounterFrom;


}

