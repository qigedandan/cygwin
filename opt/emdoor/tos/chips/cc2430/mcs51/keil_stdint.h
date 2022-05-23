

#ifndef _KEIL_STDINT_H
#define _KEIL_STDINT_H	1

/* Signed.  */

typedef signed char		int8_t;
typedef short		        int16_t;

// In Keil both are 16 bit, but not to Nesc!
//typedef int 		        int16_t;
typedef long			int32_t;

/* This will be removed later Keil does not support 64 bit types */
typedef long long int		int64_t;


/* Unsigned.  */

typedef unsigned char		uint8_t;
typedef unsigned short	        uint16_t; 

// In Keil both are 16 bit, but not to Nesc!
//typedef unsigned int	        uint16_t; 
typedef unsigned long		uint32_t;

/* This will be removed later Keil does not support 64 bit types*/
typedef unsigned long long int	uint64_t;

#endif //_KEIL_STDINT_H	1

