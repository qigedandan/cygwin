COMPONENT = testCollectionAppC
############################

#使用串口调试模块
PFLAGS += -DUART_DEBUG

#射频，不限制地址
PFLAGS += -DNO_RADIO_ADDRESS_REQ

#调试级别
PFLAGS += -DADBG_LEVEL=20

#使用硬件ACK
PFLAGS += -DCC2420_HW_ACKNOWLEDGEMENTS

#不使用休眠
#PFLAGS += -DFORCE_RADIO_ON

#使用CC2420射频协议栈
USE_CC2420_STACK = 1

#使用XMAC
CC2420_MAC = XMAC

#使用ctp协议否则使用LQI协议
#PFLAGS +=  -DCC2420_CTP

#链路层使用重发机制
PFLAGS += -DPACKET_LINK

######################

include $(MAKERULES)
