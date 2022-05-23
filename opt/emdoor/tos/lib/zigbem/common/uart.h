#ifndef UART_H
#define UART_H

#include <ioCC2430.h>
#include "CC2430Timer.h"


/* Ä¬ÈÏ²¨ÌØÂÊ */
#ifndef UART_BAUDRATE
	#define UART_BAUDRATE  9600
#endif

void uart0Init(uint32_t baud)
{
    /* Borrowed from ChipCon */
#define BAUD_E(baud, clkDivPow) (     \
    (baud==2400)   ?  6  +clkDivPow : \
    (baud==4800)   ?  7  +clkDivPow : \
    (baud==9600)   ?  8  +clkDivPow : \
    (baud==14400)  ?  8  +clkDivPow : \
    (baud==19200)  ?  9  +clkDivPow : \
    (baud==28800)  ?  9  +clkDivPow : \
    (baud==38400)  ?  10 +clkDivPow : \
    (baud==57600)  ?  10 +clkDivPow : \
    (baud==76800)  ?  11 +clkDivPow : \
    (baud==115200) ?  11 +clkDivPow : \
    (baud==153600) ?  12 +clkDivPow : \
    (baud==230400) ?  12 +clkDivPow : \
    (baud==307200) ?  13 +clkDivPow : \
    0  )

#define BAUD_M(baud) (      \
    (baud==2400)   ?  59  : \
    (baud==4800)   ?  59  : \
    (baud==9600)   ?  59  : \
    (baud==14400)  ?  216 : \
    (baud==19200)  ?  59  : \
    (baud==28800)  ?  216 : \
    (baud==38400)  ?  59  : \
    (baud==57600)  ?  216 : \
    (baud==76800)  ?  59  : \
    (baud==115200) ?  216 : \
    (baud==153600) ?  59  : \
    (baud==230400) ?  216 : \
    (baud==307200) ?  59  : \
  0)


    //    call Led1.on();

    // PERCFG selects beween alternative pin mappings for the
    // peripherals PERCFG.U0CFG == PERCFG.U0CFG select Uart0 as part
    // of port0 (U0CFG=0) or port1 (U0CFG=1)
    PERCFG &= ~0x1u;

    P0_ALT |= 0x0Cu; // Aka P0SEL


    U0GCR = BAUD_E((baud), ((CLKCON & _BV(CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) );

    U0BAUD = BAUD_M(baud);

    U0CSR |=  0x80u | 0x40u; // U0CSR.Mode=1 | U0CSR.ReceiveEnable=1
    U0UCR |= (0x2u  | 0x80u); //((HIGH_STOP) | FLUSH) 

    // Clear any pending flags
    UTX0IF = 0;
    URX0IF = 0;

}

void uart0PutChar(char c)
{
uint16_t i;
//    while (U0CSR & 0x01);
	for(i=0; i<10000; i++)
	{
		if(!(U0CSR & 0x01))
			break;
	}
    U0BUF = c;
//    while (U0CSR & 0x01);
	for(i=0; i<10000; i++)
	{
		if(!(U0CSR & 0x01))
			break;
	}
}


#endif
