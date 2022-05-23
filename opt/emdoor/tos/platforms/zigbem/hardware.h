

#ifndef HARDWARE_H
#define HARDWARE_H

#include <ioCC2430.h>
#include <mcs51hardware.h>
#include <CC2420.h>



#define CC2430_MEMCTR_FMAP_MASK  		0xCF
#define CC2430_MEMCTR_FMAP_OFFSET	4
#define CC2430_CODE_MAP_TO(n)		atomic { MEMCTR = (MEMCTR&CC2430_MEMCTR_FMAP_MASK) | (n<< CC2430_MEMCTR_FMAP_OFFSET); }
#define CC2430_CODE_MAP_SAVE(v)	atomic { (v) = MEMCTR; }
#define CC2430_CODE_MAP_LOAD(v)	atomic { MEMCTR = (v); }




/*************************************************************************/
#include "Emdebug.h"

#ifdef ZIGBEM
    #include "Wsn.h"
#endif

#ifdef EM_LOW_POWER
    #define MCU_SLEEP_LOCK
#endif

#include "McuSleep.h"


#include "OSAgent.h"

#endif //HARDWARE_H
