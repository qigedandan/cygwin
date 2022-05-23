

#include <Timer.h>

configuration Counter32khz32C
{
    provides interface Counter<T32khz,uint32_t> as Counter;
}
implementation {

    components new TransformCounterC( T32khz, uint32_t, T32khz, uint16_t, 0, uint16_t );
    components Counter32khz16C;

    Counter = TransformCounterC.Counter;

    TransformCounterC.CounterFrom -> Counter32khz16C.Counter;
}
