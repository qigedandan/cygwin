#include "Location.h"

generic configuration CC2431LocationEngineC() {
  provides interface CalcLocation ;
}

implementation {

  components CC2431LocationEngineP ;
  CalcLocation = CC2431LocationEngineP ;
  
}
