

#ifndef STRING_H
#define STRING_H

extern int strlen (char *);
extern void *memcpy (void *s1, void *s2, int n);
extern char memcmp (void *s1, void *s2, int n);
extern void *memset  (void *s, char val, int n);

extern char *strcat(char *s1, char *s2);
extern void strcpy(char *s1, char *s2);
extern char strcmp (char *s1, char *s2);


#include <stdio.h>

#endif //STRING_H

