
#ifndef OSAGENT_H
#define OSAGENT_H

//#define USE_OSAGENT

#ifdef USE_OSAGENT
	/* Use OSAgent Framework */
	#define OSA_MainC			OSAMainC
	#define OSA_TimerMilliC		OSATimerMilliC
	#define OSA_Alarm32khzC	OSAAlarm32khzC
#else
	/* Just use the orignal TinyOS */
	#define OSA_MainC			MainC
	#define OSA_TimerMilliC		TimerMilliC
	#define OSA_Alarm32khzC	Alarm32khzC
#endif

#endif /* OSAGENT_H */

