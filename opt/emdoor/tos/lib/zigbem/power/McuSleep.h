#ifndef MCUSLEEP_H
#define MCUSLEEP_H


#ifndef MCU_SLEEP_TIME
#define MCU_SLEEP_TIME 3000
#endif

#ifndef MCU_ACTIVE_TIME
#define MCU_ACTIVE_TIME 3000
#endif


/*********************************************************************/
#ifdef MCU_SLEEP_LOCK
    #define LOCK_SLEEP(o)        { call o.lock();  }
    #define UNLOCK_SLEEP(o)    { call o.unlock(); }
#else
    #define LOCK_SLEEP(o)
    #define UNLOCK_SLEEP(o)
#endif


/*********************************************************************/

#define UQ_MCUSLEEP_LOCK    "McuSleepLock"

#ifdef MCU_SLEEP
	#define UINT8_PM0_T		uint8_t_xdata_pm0
	#define UINT16_PM0_T	uint16_t_xdata_pm0
	#define UINT32_PM0_T 	uint32_t_xdata_pm0
	#define MESSAGE_PM0_T	message_t_xdata_pm0
#else
	#define UINT8_PM0_T 	uint8_t
	#define UINT16_PM0_T	uint16_t
	#define UINT32_PM0_T	uint32_t
	#define MESSAGE_PM0_T	message_t
#endif

#endif
