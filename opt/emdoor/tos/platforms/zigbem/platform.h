#ifndef PLATFORM_H

#include "AM.h"

#define TOS_UART_ADDR    0xFFFE

//#define DEBUG_STDOUTC		StdNullC

#ifndef DEBUG_STDOUTC
	#define DEBUG_STDOUTC	StdOutC
#endif

#ifndef EM_NODE_TYPE
    #define EM_NODE_TYPE   1
#endif

uint16_t TOS_IEEE_SADDR	= TOS_AM_ADDRESS;
uint16_t TOS_IEEE_PANID	= TOS_AM_GROUP;

uint8_t TOS_IEEE_GROUP = EM_NODE_TYPE;

#include "platform_interrupt.h"

#endif
