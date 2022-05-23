COMPONENT = EMSleepNodeAppC


#############################

#使用串口调试模块
PFLAGS += -DUART_DEBUG -DUSE_BOARD_LED

PFLAGS += -DPACKET_LINK

PFLAGS += -DCC2420_HW_ACKNOWLEDGEMENTS

PFLAGS += -DADBG_LEVEL=3000


#使用标准2420射频协议栈
USE_CC2420_STACK = 1

#使用低功耗模式
MCU_SLEEP = 1

#属于传感器程序
SENSOR_APP = 1

#通讯频道
CH=12

#休眠设置
#同步后休眠时间休眠290s，工作10s
#PFLAGS += -DSLEEPNODE_SYNC_SLEEP=290000   -DSLEEPNODE_SYNC_WAKEUP=10000

#################################
include $(MAKERULES)