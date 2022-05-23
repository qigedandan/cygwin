#include <Location.h>

interface  CalcLocation{

  command void Calc(LocBlindNode_t *blind ,LocDevPara_t *para ,LocRefNode_t *ref );
  
  event void CalcFinish();
}

