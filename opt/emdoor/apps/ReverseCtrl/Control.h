/******************************************************
*	Name:LedCtrl.h
*	Date:2010-11-30
*	Author:tivacc
*	Description:
*******************************************************/
#ifndef CONTROL_H_
#define CONTROL_H_

/*========================macro define==============================*/
#define 	TRUE				1
#define 	FALSE				0

#define 	RF_MAX_GROUP_LENGTH		10		//命令的最大接收条数
#define 	RF_MAX_RX_LENGTH			127		//rf命令接收的最大字节数
#define 	COM_MAX_RX_LENGTH			64		//串口数据
#define		COM_MAX_GROUP_LENGTH 	10		//

#define 	COM_OUTPUT_LENGTH			19
#define 	COMMAND_LENGTH				4

#define 	DEVICE_OFF			0X00
#define		DEVICE_OPEN			0X01
#define 	DEVICE_REPEAT		0X02
#define		DEVICE_DELAY		0X03

#define		ALWAYS_OPEN			0X00	//设备常开

//Rf data position
#define RF_FCF_LENGTH	0	
#define RF_FCF_CTRL		1
#define RF_FCF_DSN		3
#define RF_FCF_PANID	4
#define RF_FCF_DESTADDR		6
#define RF_FCF_SRCADDR		8
#define RF_FCF_TYPE				10		
#define RF_FCF_GRP				11
#define RF_DATA_HEAD			12
#define RF_DATA_IC_TYPE		13
#define RF_DATA_DEV_TYPE 	15
#define RF_DATA_ORIADDR		16
#define RF_DATA_CMD_NO		17
#define RF_DATA_CMD_HEAD 	20
#define RF_DATA_CMD_CAP 	21
#define RF_DATA_CMD_DELAY 21
#define RF_DATA_CMD_COUNT 22

//serial port data position
#define COM_DATA_HEAD	0
#define COM_DATA_IC_TYPE	1
#define COM_DATA_LENGTH		3
#define COM_DATA_DESTADDR	5
#define COM_DATA_DEV_TYPE 5
#define COM_DATA_SRCADDR	7
#define COM_DATA_ORIADDR	9
#define COM_DATA_NO			11
#define COM_DATA_HOP		13
#define COM_DATA_CMD		14
#define COM_DATA_FCS		18

//FRAME HEAD
#define PC2NETGATE_CMD		0X36
#define NETGATE2PC_ACK		0X35
#define NETGATE2NODE_CMD	0X34
#define NODE2NETGATE_ACK	0X33
#define NODE2NETGATE_INFO	0X32

#define MCU_TYPE					0x2430

/*==========================typedef===================================*/


/*==========================gloabal variable==========================*/
/**串口输出数据字符串
*/
/*							   					       head|mcu      |length   |dev type |sourAddr |oriAddr  |seqNo    |hop |CMD		   					|fcs*/
//串口传输数据传输成功
norace uint8_t 	TRANS_SUCCESS[] = {0x35,0x30,0x24,0x0e,0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0xa0,0x00,0xa0,0xda};
//串口数据校验失败
norace uint8_t 	TRANS_FAILURE[] = {0x35,0x30,0x24,0x0e,0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x01,0x9c};
//串口忙
norace uint8_t 	TRANS_BUSY[]    = {0x35,0x30,0x24,0x0e,0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0xff,0x00,0xff,0x98};
//节点超时
norace uint8_t 	NODE_TIMEOUT[]  = {0x33,0x30,0x24,0x0e,0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0xff,0x00,0xff,0x96};


#endif
