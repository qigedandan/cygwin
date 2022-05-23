#ifndef DEBUGGER_STEP_H
#define DEBUGGER_STEP_H

#define DBGER_STEP_SIZE  10

uint16_t step_value[DBGER_STEP_SIZE] = {0};

#define DBGER_STEP(n, v)	do { \
	step_value[ (n) ] = (v); \
} while (0)



#endif

