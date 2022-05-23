#ifndef DEBUGGER_LOG_H
#define DEBUGGER_LOG_H

#define DBGER_LOG_LEN   25

char log_value[][DBGER_LOG_LEN] = {
	"LOG1",
	"LOG2",
};

#define DBGER_LOG_SIZE	sizeof(log_value)/sizeof(log_value[0])

#define DBGER_LOG(n, __args...)	do { \
	sprintf(log_value[ (n) ], __args); \
} while (0)



#endif /* DEBUGGER_LOG_H */

