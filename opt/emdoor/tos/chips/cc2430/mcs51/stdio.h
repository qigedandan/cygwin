/*--------------------------------------------------------------------------
STDIO.H

Prototypes for standard I/O functions.
Copyright (c) 1988-2002 Keil Elektronik GmbH and Keil Software, Inc.
All rights reserved.
--------------------------------------------------------------------------*/

#ifndef __STDIO_H__
#define __STDIO_H__

#ifndef EOF
 #define EOF -1
#endif

#ifndef NULL
 #define NULL ((void *) 0)
#endif

#ifndef _SIZE_T
 #define _SIZE_T
 typedef unsigned int size_t;
#endif

extern char _getkey ();
extern char getchar ();
extern char ungetchar (char);
extern char putchar (char);
extern int printf   (const char *, ...);
extern int sprintf  (char *, const char *, ...);
extern int vprintf  (const char *, char *);
extern int vsprintf (char *, const char *, char *);
extern char *gets (char *, int n);
extern int scanf (const char *, ...);
extern int sscanf (char *, const char *, ...);
extern int puts (const char *);


//extern void qsort(void * __base, unsigned int __nmemb, unsigned int __size, int * ( __compar)(const void *, const void *) );

#endif

