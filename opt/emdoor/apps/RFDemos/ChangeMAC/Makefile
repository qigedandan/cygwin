COMPONENT = TestSendingAppC


######################

#使用LED模块
PFLAGS += -DUSE_MODULE_LED

#使用串口调试模块
PFLAGS += -DUART_DEBUG

#射频，不限制地址
PFLAGS += -DNO_RADIO_ADDRESS_REQ

#调试级别
PFLAGS += -DADBG_LEVEL=15

#不使用休眠
#PFLAGS += -DFORCE_RADIO_ON

#使用硬件ACK
PFLAGS += -DCC2420_HW_ACKNOWLEDGEMENTS

#使用CC2420射频协议栈
USE_CC2420_STACK = 1

#使用XMAC
CC2420_MAC = XMAC

#链路层使用重发机制
PFLAGS += -DPACKET_LINK

ifndef NOSEND
PFLAGS += -DTESTMAC_SEND
endif


######################

include $(MAKERULES)
