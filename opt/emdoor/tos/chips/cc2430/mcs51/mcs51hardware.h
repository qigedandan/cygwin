


#ifndef _H_mcs51hardware_H
#define _H_mcs51hardware_H

#include <io8051.h>
// At some point someone is probably going to use these from avrlibc =]

#ifndef _BV
#define _BV(bit) (1 << (bit))
#endif

// Borrow these from atm128hardware
// Using these for IO seems rather silly as IO ports are bit accessible as
// Px_y (where x is the port and y is the pin)
#define SET_BIT(port, bit)    ((port) |= _BV(bit))
#define CLR_BIT(port, bit)    ((port) &= ~_BV(bit))
#define READ_BIT(port, bit)   (((port) & _BV(bit)) != 0)
#define FLIP_BIT(port, bit)   ((port) ^= _BV(bit))

// Define the input/output valus of the Px_DIR registers
// One could imagine some 8051 implementation being wierd enough to change
// these
#define MAKE_IO_PIN_OUTPUT(dir_reg, pin) dir_reg |= _BV(pin)
#define MAKE_IO_PIN_INPUT(dir_reg, pin)  dir_reg &= ~_BV(pin)

// Test whether an IO pin is set to input or output
#define IS_IO_PIN_OUTPUT(dir_reg, pin) dir_reg | _BV(pin)
#define IS_IO_PIN_INPUT(dir_reg, pin)  !(dir_reg & _BV(pin))

/*
 * We need slightly different defs than SIGNAL, INTERRUPT
 * See gcc manual for explenation of gcc-attributes
 * See nesC Language Reference Manual for nesc attributes
 *
 * signal: Interrupts are disabled inside function.
 * interrupt: Sets up interrupt vector, but doesn't disable interrupts
 * spontaneous: nesc attribute to indicate that there are "inisible" calls to this
 *              function i.e. interrupts

 * It seems that 8051 compilers only define the interrupt keyword (not
 * signal). It is unclear wether interrupts are disabled or enabled by
 * default.

 * We use AVR-like syntax so the mangle script looks for something like:
 *    void __vector_9() __attribute((interrupt))) {
 *
 * Which is mangled to
 *    void __vector interrupt 9 () {
 *
 * NOTE: This means that the interrupt number is passed as part of the
 * name - so don't change it! This name is further passed to the
 * CIL-inliner script in order for it to leave it there.
 */

// Interrupt: interrupts are enabled (probably =)
#define MCS51_INTERRUPT(signame) \
void signame() __attribute((interrupt, spontaneous, C))

// atomic statement runtime support
typedef uint8_t __nesc_atomic_t;

inline void __nesc_disable_interrupt() { EA=0; }
inline void __nesc_enable_interrupt()  { EA=1; }
    
inline __nesc_atomic_t __nesc_atomic_start(void) __attribute((spontaneous)) {
  __nesc_atomic_t tmp = EA;
  EA = 0; 
  return tmp;
}

inline void __nesc_atomic_end(__nesc_atomic_t oldSreg) __attribute__((spontaneous)) {
  EA = oldSreg;
}

#define u8(buf, offset) (*((uint8_t*)(buf) + (offset)))

#define u16(buf, offset) ((uint16_t)(u8(buf, offset) | (u8(buf, (offset)+1)<<8)))

#define u32(buf, offset)		(uint32_t)((uint32_t)u16((buf), (offset)) | ((uint32_t)u16((buf), (offset)+2) << 16))

#define su8(buf, offset, data)  {\
	u8(buf, offset) = (data);\
}

/* #define su16(buf, offset, data) {\
	u8(buf, offset) = (uint8_t)((data) & 0x00FF);\
	u8(buf, (offset)+1) = (uint8_t)(((data) & 0xFF00) >> 8);\
} */

#define su16(buf, offset, data) {\
	u8(buf, offset) =(uint8_t)(((data) & 0xFF00) >> 8);\
	u8(buf, (offset)+1) = (uint8_t)((data) & 0x00FF);\
} 

/* #define su32(buf, offset, data) {\
	su16((buf), (offset), ((data)&0x0000FFFF)); \
	su16((buf), (offset)+2, (((data)&0xFFFF0000) >> 16)); \
} */

#define su32(buf, offset, data) {\
	su16((buf), (offset), (((data)&0xFFFF0000) >> 16)); \
	su16((buf), (offset)+2,((data)&0x0000FFFF)); \
}

#endif //_H_mcs51hardware_H
