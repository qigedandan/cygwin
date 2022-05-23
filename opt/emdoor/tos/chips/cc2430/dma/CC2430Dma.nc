
#include "cc2430dma.h"

interface CC2430Dma {

  command dma_config_t * getConfig();
    
  command error_t armChannel();
  command error_t disarmChannel();
  command bool isArmed();
  command error_t startTransfer();
  command error_t stopTransfer();

  async event void transferDone();
}
