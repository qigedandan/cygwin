

#include <Timer.h>

configuration OSACounter32khz32C
{
    provides interface Counter<T32khz,uint32_t> as Counter;
}
implementation {

    components new TransformCounterC( T32khz, uint32_t, T32khz, uint16_t, 0, uint16_t );
    components OSACounter32khz16C;

    Counter = TransformCounterC.Counter;

    TransformCounterC.CounterFrom -> OSACounter32khz16C.Counter;
}
