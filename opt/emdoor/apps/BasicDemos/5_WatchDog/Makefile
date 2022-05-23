COMPONENT=WatchDogAppC

######################

#使用LED模块
PFLAGS += -DUSE_BOARD_LED

#使用串口调试模块
PFLAGS += -DUART_DEBUG

#调试级别
PFLAGS += -DADBG_LEVEL=9

#禁止RF使用LED，以避免混乱点灯程序
PFLAGS += -DANT_RADIO_NOT_LED


######################

include $(MAKERULES)

