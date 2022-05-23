

#ifndef _H_io8051_H
#define _H_io8051_H

/**
 * Keil byte order
 *  uint16_t big endian (MSB first)
 *  sfr16    little endian (LSB first)
 *
 * Keil stores multi-byte-values as big endian (MSB first, at the
 * lowest address). This means for uint16_t values the high order byte
 * (MSB) must be selected as the address for uint16_t values.
 *
 * sfr16 values the are stored as little endian as such the LSB must
 * be selected as the address of the sfr16 register
 * 
 * It might be worth ignoring the sfr16 definition altogether to avoid
 * confusion, or at least use the following macros to illustrate what
 * is going on - possibly in a compiler agnostic way.
 *
 * http://www.keil.com/support/man/docs/c51/c51_xe.htm
 * http://www.keil.com/support/man/docs/c51/c51_le_sfr16.htm
 *
 */

/**
 * SDCC byte order
 *
 * SDCC apparently stores multibyte values as little endian, it is
 * unclear whether this is the case for sfr16 registers or not.
 *
 * Hopefully someone remembers to chech before compiling with sdcc =].
 *
 * http://sdcc.sourceforge.net/doc/sdccman.pdf
 */


#define _BSWAP_UINT16(word) (((uint8_t*)&word)[0]<<8 | ((uint8_t*)&word)[1])

#define SFR16_TO_UINT16 (uint16_t) _BSWAP_UINT16

#ifdef __KEIL__
#define UINT16_TO_SFR16 (sfr16) _BSWAP_UINT16
#else

/* This warning shows up in Nesc - so maybe it should be defined in
   the makefile or something

#warning "This code probably will not work without the Keil Compiler."
*/
#define UINT16_TO_SFR16(w) w
#endif

uint8_t volatile P0   __attribute((sfrAT0x80));
uint8_t volatile SP   __attribute((sfrAT0x81));
uint8_t volatile DPL  __attribute((sfrAT0x82));
uint8_t volatile DPH  __attribute((sfrAT0x83));
uint8_t volatile DPL1 __attribute((sfrAT0x84));
uint8_t volatile DPH1 __attribute((sfrAT0x85));

// 0x86 used differently by CC2430/nRF24E1

uint8_t volatile PCON   __attribute((sfrAT0x87));
uint8_t volatile TCON   __attribute((sfrAT0x88));
uint8_t volatile TMOD   __attribute((sfrAT0x89));
uint8_t volatile TL0    __attribute((sfrAT0x8A));
uint8_t volatile TL1    __attribute((sfrAT0x8B));
uint8_t volatile TH0    __attribute((sfrAT0x8C));
uint8_t volatile TH1    __attribute((sfrAT0x8D));
uint8_t volatile CKCON  __attribute((sfrAT0x8E));
uint8_t volatile P1     __attribute((sfrAT0x90));
uint8_t volatile EXIF   __attribute((sfrAT0x91));
uint8_t volatile MPAGE  __attribute((sfrAT0x92));
uint8_t volatile SCON   __attribute((sfrAT0x98));
uint8_t volatile SBUF   __attribute((sfrAT0x99));
//uint8_t volatile T2CON  __attribute((sfrAT0xC8));
uint8_t volatile RCAP2L __attribute((sfrAT0xCA)); 
uint8_t volatile RCAP2H __attribute((sfrAT0xCB));
uint8_t volatile TL2    __attribute((sfrAT0xCC));
uint8_t volatile TH2    __attribute((sfrAT0xCD));
uint8_t volatile PSW    __attribute((sfrAT0xD0));
uint8_t volatile EICON  __attribute((sfrAT0xD8));
uint8_t volatile ACC    __attribute((sfrAT0xE0));
uint8_t volatile B      __attribute((sfrAT0xF0));


// Interrupt control at 0xE8 is used differently

uint8_t volatile EIP       __attribute((sfrAT0xF8));
//uint8_t volatile P1_ALT    __attribute((sfrAT0x97));
uint8_t volatile P2        __attribute((sfrAT0xA0));
uint8_t volatile ADCCON    __attribute((sfrAT0xA1));
uint8_t volatile ADCDATAH  __attribute((sfrAT0xA2));
uint8_t volatile ADCDATAL  __attribute((sfrAT0xA3));
uint8_t volatile ADCSTATIC __attribute((sfrAT0xA4));
uint8_t volatile PWMCON    __attribute((sfrAT0xA9));
uint8_t volatile PWMDUTY   __attribute((sfrAT0xAA));
uint8_t volatile REGX_MSB  __attribute((sfrAT0xAB));
uint8_t volatile REGX_LSB  __attribute((sfrAT0xAC));
uint8_t volatile REGX_CTRL __attribute((sfrAT0xAD));
uint8_t volatile RSTREAS   __attribute((sfrAT0xB1));
uint8_t volatile SPI_DATA  __attribute((sfrAT0xB2));
uint8_t volatile SPI_CTRL  __attribute((sfrAT0xB3));
uint8_t volatile SPICLK    __attribute((sfrAT0xB4));
uint8_t volatile TICK_DV   __attribute((sfrAT0xB5));
uint8_t volatile CK_CTRL   __attribute((sfrAT0xB6));


/*  BIT Registers  */

/*  PSW */
uint8_t volatile CY  __attribute((sbitAT0xD7));
uint8_t volatile AC  __attribute((sbitAT0xD6));
uint8_t volatile F0  __attribute((sbitAT0xD5));
uint8_t volatile RS1 __attribute((sbitAT0xD4));
uint8_t volatile RS0 __attribute((sbitAT0xD3));
uint8_t volatile OV  __attribute((sbitAT0xD2));
uint8_t volatile F1  __attribute((sbitAT0xD1));
uint8_t volatile P   __attribute((sbitAT0xD0));


/*  TCON  */

uint8_t volatile TF1 __attribute((sbitAT0x8F));
uint8_t volatile TR1 __attribute((sbitAT0x8E));
uint8_t volatile TF0 __attribute((sbitAT0x8D));
uint8_t volatile TR0 __attribute((sbitAT0x8C));
uint8_t volatile IE1 __attribute((sbitAT0x8B));
uint8_t volatile IT1 __attribute((sbitAT0x8A));
uint8_t volatile IE0 __attribute((sbitAT0x89));
uint8_t volatile IT0 __attribute((sbitAT0x88));


/*  IE  */ 

/* The interupt mask register definition seems to be common, but the
   semantics of the bits other than "disable/enble all" (bit 7, EA) seems
   to vary. On chipcon this register is name IE0EN
*/

uint8_t volatile IE         __attribute((sfrAT0A8));
norace uint8_t volatile EA __attribute((sbitAT0xAF));

/*  IP  */

uint8_t volatile PT2 __attribute((sbitAT0xBD));
uint8_t volatile PS  __attribute((sbitAT0xBC));
uint8_t volatile PT1 __attribute((sbitAT0xBB));
uint8_t volatile PX1 __attribute((sbitAT0xBA));
uint8_t volatile PT0 __attribute((sbitAT0xB9));
uint8_t volatile PX0 __attribute((sbitAT0xB8));


/*  P0 bit adressable locations */

uint8_t volatile P0_0 __attribute((sbitAT0x80));
uint8_t volatile P0_1 __attribute((sbitAT0x81));
uint8_t volatile P0_2 __attribute((sbitAT0x82));
uint8_t volatile P0_3 __attribute((sbitAT0x83));
uint8_t volatile P0_4 __attribute((sbitAT0x84));
uint8_t volatile P0_5 __attribute((sbitAT0x85));
uint8_t volatile P0_6 __attribute((sbitAT0x86));
uint8_t volatile P0_7 __attribute((sbitAT0x87));


/*  P0 alternate functions */

uint8_t volatile T1   __attribute((sbitAT0x86));
uint8_t volatile T0   __attribute((sbitAT0x85));
uint8_t volatile INT1 __attribute((sbitAT0x84));
uint8_t volatile INT0 __attribute((sbitAT0x83));


/*  P1 bit adressable locations */

uint8_t volatile P1_0 __attribute((sbitAT0x90));
uint8_t volatile P1_1 __attribute((sbitAT0x91));
uint8_t volatile P1_2 __attribute((sbitAT0x92));
uint8_t volatile P1_3 __attribute((sbitAT0x93));
uint8_t volatile P1_4 __attribute((sbitAT0x94));
uint8_t volatile P1_5 __attribute((sbitAT0x95));
uint8_t volatile P1_6 __attribute((sbitAT0x96));
uint8_t volatile P1_7 __attribute((sbitAT0x97));

/*  P1  alternate functions*/

uint8_t volatile T2 __attribute((sbitAT0x90));


/*  P2 bit adressable locations */
/*  On some platforms (eg. cc2430) not all are available */
uint8_t volatile P2_0 __attribute((sbitAT0xA0));
uint8_t volatile P2_1 __attribute((sbitAT0xA1));
uint8_t volatile P2_2 __attribute((sbitAT0xA2));
uint8_t volatile P2_3 __attribute((sbitAT0xA3));
uint8_t volatile P2_4 __attribute((sbitAT0xA4));
uint8_t volatile P2_5 __attribute((sbitAT0xA5));
uint8_t volatile P2_6 __attribute((sbitAT0xA6));
uint8_t volatile P2_7 __attribute((sbitAT0xA7));


/*  SCON  */

uint8_t volatile SM0 __attribute((sbitAT0x9F));
uint8_t volatile SM1 __attribute((sbitAT0x9E));
uint8_t volatile SM2 __attribute((sbitAT0x9D));
uint8_t volatile REN __attribute((sbitAT0x9C));
uint8_t volatile TB8 __attribute((sbitAT0x9B));
uint8_t volatile RB8 __attribute((sbitAT0x9A));
uint8_t volatile TI  __attribute((sbitAT0x99));
uint8_t volatile RI  __attribute((sbitAT0x98));


/*  T2CON  */

uint8_t volatile TF2    __attribute((sbitAT0xCF));
uint8_t volatile EXF2   __attribute((sbitAT0xCE));
uint8_t volatile RCLK   __attribute((sbitAT0xCD));
uint8_t volatile TCLK   __attribute((sbitAT0xCC));
uint8_t volatile EXEN2  __attribute((sbitAT0xCB));
uint8_t volatile TR2    __attribute((sbitAT0xCA));
uint8_t volatile C_T2   __attribute((sbitAT0xC9));
uint8_t volatile CP_RL2 __attribute((sbitAT0xC8));


/*  EICON  */

uint8_t volatile SMOD1 __attribute((sbitAT0xDF));
uint8_t volatile WDTI  __attribute((sbitAT0xDB));


/*  EIE  */

uint8_t volatile EWDI __attribute((sbitAT0xEC));
uint8_t volatile EX5  __attribute((sbitAT0xEB));
uint8_t volatile EX4  __attribute((sbitAT0xEA));
uint8_t volatile EX3  __attribute((sbitAT0xE9));
uint8_t volatile EX2  __attribute((sbitAT0xE8));


/*  EIP  */

uint8_t volatile PWDI __attribute((sbitAT0xFC));
uint8_t volatile PX5  __attribute((sbitAT0xFB));
uint8_t volatile PX4  __attribute((sbitAT0xFA));
uint8_t volatile PX3  __attribute((sbitAT0xF9));
uint8_t volatile PX2  __attribute((sbitAT0xF8));


/* RADIO */

uint8_t volatile PWR_UP __attribute((sbitAT0xA7));
uint8_t volatile DR2    __attribute((sbitAT0xA6));
uint8_t volatile CE     __attribute((sbitAT0xA6));
uint8_t volatile CLK2   __attribute((sbitAT0xA5));
uint8_t volatile DOUT2  __attribute((sbitAT0xA4));
uint8_t volatile CS     __attribute((sbitAT0xA3));
uint8_t volatile DR1    __attribute((sbitAT0xA2));
uint8_t volatile CLK1   __attribute((sbitAT0xA1));
uint8_t volatile DATA   __attribute((sbitAT0xA0));


#endif // _H_io8051_H
