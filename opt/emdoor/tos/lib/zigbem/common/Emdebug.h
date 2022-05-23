#ifndef UARTDEBUG_H
#define UARTDEBUG_H

#ifdef UART_DEBUG
#include <stdarg.h>
#include <stdio.h>
#include "uart.h"

#define SCRATCH 64
#define BUF_LEN 256
char uart_debug_buf[BUF_LEN];
int uart_debug_level = ADBG_LEVEL;
uint8_t current_task_id = 255;


int tmprfdhead, tmprfdtail;

// call this from startup routine
void uartDebugInit()
{
    uart0Init(UART_BAUDRATE);
}

// output a char to the uart
void uartDebugPutChar(char c)
{
    if (c == '\n')
    {
        uart0PutChar('\r');
    }
    uart0PutChar(c);
}

void uartDebugPrint()
{
    int i = 0;
    while ((i <BUF_LEN) &&  (uart_debug_buf[i] != '\0')) 
    {
        uartDebugPutChar(uart_debug_buf[i++]);  
    }
}



#ifndef ADBG_LEVEL
#define ADBG_LEVEL 1
#endif


#define ADBG(__x, __args...)\
{ \
    atomic \
    {\
        if (__x >= uart_debug_level) \
        { \
            sprintf(uart_debug_buf, __args); \
            uartDebugPrint(); \
        } \
    } \
}

#define ADBG_N(x)     ((int)(x))

#else
int uart_debug_level = 1;
uint8_t current_task_id = 255;
    #define ADBG(__x,__args...)
#endif


#define ADBG_SET_LEVEL(l)	{ uart_debug_level = (l); }
#define ADBG_SYS_INFO(l)		{ADBG(l, "[SYSINFO] task id=%d\n", (int)current_task_id); }

#endif
