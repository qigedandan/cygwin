#ifndef STDLIB_H
#define STDLIB_H

#include <stdio.h>


extern float atof (char *s1);
extern long  atol (char *s1);
extern int   atoi (char *s1);

typedef int (*__compar_fn_t)(const void *, const void *);

extern void qsort(void *__base, unsigned int __nmemb, unsigned int __size, 
__compar_fn_t __compar);

#endif
