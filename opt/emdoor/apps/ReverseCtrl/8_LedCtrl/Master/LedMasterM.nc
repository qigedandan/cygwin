/*************************************************
*	FUNCTION NAME : LedMasterM.nc
*	FUNCTION DESCRIPTION : 控制LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

#include "../../Device.h"
#include "../../Control.h"

//串口数据缓存结构体
typedef struct comBuffer_tag 
{
	uint8_t rxBuf[COM_MAX_RX_LENGTH];
	struct comBuffer_tag *next;
} comBuffer_t;

module LedMasterM {
	uses {
		interface Boot;						//系统启动接口
		interface UartStream;			//串口处理接口
		interface Packet;					//
		interface AMSend;					//RF发送接口
		interface AMPacket;
		interface Receive;				//RF接收接口
		interface Timer<TMilli> as Timer;
		interface Timer<TMilli> as Timer1;
		interface StdControl as UartStdControl;	//串口初始化
		interface SplitControl as RFControl;		//RF初始化
	}
}
implementation {
	norace uint8_t SscomRxEndFlag;
	norace uint8_t RfAckFlag = FALSE;											//RF传输完成标志
	norace uint8_t RfTxRdyFlag = FALSE;
	norace comBuffer_t ComPortBuf[COM_MAX_GROUP_LENGTH];	//串口命令缓存区
	
	uint16_t rcvLength,ackSeqNo;
	uint8_t ComPortData[COM_MAX_RX_LENGTH];		//串口接收临时缓冲
	uint8_t RadioData[RF_MAX_RX_LENGTH];
	uint8_t count=0,rxUsed=0,rxManaged=0; 		//串口处理基数		
	message_t m_msg;							//RF数据结构体

	/**无线发送数据
	*/
	task void sendData()
	{
		uint8_t j;
		uint8_t *RfPayload;
		uint16_t destAddress;
		RfPayload = call Packet.getPayload(&m_msg, NULL);
		
		if(rxManaged>=COM_MAX_GROUP_LENGTH)
		{rxManaged = 0;}
		
		ackSeqNo = (ComPortBuf[rxManaged].rxBuf[COM_DATA_NO]) + (((uint16_t)(ComPortBuf[rxManaged].rxBuf[COM_DATA_NO+1]))<<8);
		destAddress = (ComPortBuf[rxManaged].rxBuf[COM_DATA_DESTADDR]) + (((uint16_t)(ComPortBuf[rxManaged].rxBuf[COM_DATA_DESTADDR+1]))<<8);

		//命令帧头
		su8(RfPayload,0,ComPortBuf[rxManaged].rxBuf[COM_DATA_HEAD]);
		//IC类型
		su8(RfPayload,1,ComPortBuf[rxManaged].rxBuf[COM_DATA_IC_TYPE]);		
		su8(RfPayload,2,ComPortBuf[rxManaged].rxBuf[COM_DATA_IC_TYPE+1]);
		
		//设备类型
		su8(RfPayload,3,DEVICE_ID_NETGATE);	
		
		//原始地址
		su16(RfPayload,4,call AMPacket.address());
		
		//帧序列号
		su8(RfPayload,6,ComPortBuf[rxManaged].rxBuf[COM_DATA_NO]);		
		su8(RfPayload,7,ComPortBuf[rxManaged].rxBuf[COM_DATA_NO+1]);
		
		//命令内容
		for(j=0;j<COMMAND_LENGTH;j++)
		{
			su8(RfPayload,8+j,ComPortBuf[rxManaged].rxBuf[COM_DATA_CMD+j]);
		}
				
		//处理完成命令缓冲区中数据，清除该缓冲区内容
		atomic
		{
			ComPortBuf[rxManaged].next = NULL;
			rxManaged = (rxManaged+1)%RF_MAX_GROUP_LENGTH;
		}
		
		//发送数据
		call AMSend.send(destAddress, &m_msg, COMMAND_LENGTH+8);	
	}
	
	/*串口数据接收*/
	async event void UartStream.receivedByte(uint8_t byte)
	{
		uint8_t* Data = ComPortData;
		call UartStream.receive(Data,byte);
		
		SscomRxEndFlag = FALSE;
		call Timer.startOneShot(40);
	}

	/**  启动事件处理函数，在LED.nc已经关联到MainC.Boot接口
		系统启动后会调用此函数
	*/
	event void Boot.booted()
	{
		uint8_t i;
		for(i=0;i<COM_MAX_GROUP_LENGTH;i++)
			{ComPortBuf[i].next = NULL;}
			
		call UartStdControl.start();		//串口初始化
		call RFControl.start();					//RF初始化
	}
	
	/** 串口超时 */
	event void Timer.fired()
	{
		if(!SscomRxEndFlag)
		{
			call UartStream.receive(NULL,0);		//数据超时，清除原来接收的数据
			call UartStream.send((uint8_t *)TRANS_BUSY,COM_OUTPUT_LENGTH); 
		}
	}
	
	/** 应答超时检测 */
	event void Timer1.fired()
	{
		
		if(RfAckFlag == FALSE)
		{
			RfAckFlag = TRUE;			
			call UartStream.send((uint8_t *)NODE_TIMEOUT,COM_OUTPUT_LENGTH); 
		}
	}
		
	/*射频接收数据，此处处理为单跳之内的数据*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		// Add your code here
		uint8_t *OutPut = (uint8_t*)RadioData;
		uint8_t frameHead;
		uint8_t i,fcs=0;
		
		//call UartStream.send((uint8_t*)payload,25-sizeof(cc2420_header_t));
		su8(OutPut,0,((uint8_t *)msg)[RF_DATA_HEAD]);											//head
		su16(OutPut,1,((uint16_t)((uint8_t*)msg)[RF_DATA_IC_TYPE+1]<<8)|((uint8_t*)msg)[RF_DATA_IC_TYPE]);			//mcu type
		su16(OutPut,3,((uint8_t *)msg)[RF_FCF_LENGTH]+1);									//length
		su16(OutPut,5,((uint8_t*)msg)[RF_DATA_DEV_TYPE]);									//device type
		su16(OutPut,7,((uint16_t)((uint8_t*)msg)[RF_FCF_SRCADDR+1]<<8)|((uint8_t*)msg)[RF_FCF_SRCADDR]);  			//src_address	
		su16(OutPut,9,((uint16_t)((uint8_t*)msg)[RF_DATA_ORIADDR+1]<<8)|((uint8_t*)msg)[RF_DATA_ORIADDR]);      //origin_address	
		su16(OutPut,11,((uint16_t)((uint8_t*)msg)[RF_DATA_CMD_NO+1]<<8)|((uint8_t*)msg)[RF_DATA_CMD_NO]);  	  	//SeqNo		
		su8(OutPut,13,1);																		//hopcount,默认设置为1		
		su8(OutPut,14,((uint8_t*)msg)[RF_DATA_CMD_HEAD]);  	//Ack command
		su8(OutPut,15,((uint8_t*)msg)[RF_DATA_CMD_HEAD+1]);
		su8(OutPut,16,((uint8_t*)msg)[RF_DATA_CMD_HEAD+2]);
		su8(OutPut,17,((uint8_t*)msg)[RF_DATA_CMD_HEAD+3]);
		for(i=0;i<=17;i++)
			{fcs += *(OutPut+i);}
		su8(OutPut,18,fcs);	
		//分类信息
		frameHead = ((uint8_t *)msg)[RF_DATA_HEAD];
		switch(frameHead)
		{
			case 0x32 : /*NODE2NETGATE_INFO*/
				;;;
				call UartStream.send(OutPut,COM_OUTPUT_LENGTH);				
				break;
			case 0x33 :/*NODE2NETGATE_ACK*/
				;;;
				RfAckFlag = TRUE;
				call UartStream.send(OutPut,COM_OUTPUT_LENGTH);
				break;
			default :
				//call UartStream.send((uint8_t*)"error!",sizeof("error!"));
				break;
		}
	}
	
	/** 实现接口RFControl 接口中的事件*/
	event void RFControl.startDone(error_t result)
	{
	}

	event void RFControl.stopDone(error_t result)
	{
	}
	
	event void AMSend.sendDone(message_t* msg, error_t error)
	{
		RfAckFlag = FALSE;
		call Timer1.startOneShot(100);			//100ms超时判断是否接收到节点的手动ack
	}
	
	async event void UartStream.sendDone( uint8_t* buf, uint16_t len, error_t error )
	{
		if(RfTxRdyFlag)
		{
			RfTxRdyFlag = FALSE;							//
			
			atomic
			{
				/* if(rxUsed >= (COM_MAX_GROUP_LENGTH-1))				//循环存储上位机命令
				{
					ComPortBuf[rxUsed].next = &ComPortBuf[0];			//指向下一buffer地址
					rxUsed = 0;
				}
				else
				{
					ComPortBuf[rxUsed].next = &ComPortBuf[rxUsed+1];
					rxUsed += 1;						
				} */
				ComPortBuf[rxUsed].next = &ComPortBuf[(rxUsed+1)%RF_MAX_GROUP_LENGTH];
				rxUsed = (rxUsed+1)%RF_MAX_GROUP_LENGTH;
			}
						
			post sendData();						//发送数据
		}
	}
	
	async event void UartStream.receiveDone(uint8_t* buf, uint16_t len, error_t error)
	{
		uint8_t i=0,fcs=0;
		uint8_t *SscomData;
		uint8_t SscomLength;
		SscomRxEndFlag = TRUE;
		
		atomic
		{
			SscomData = buf;
			SscomLength = len;
		}
		
		//call UartStream.send(buf,len);
		//验证数据正确性
		if((SscomData[COM_DATA_HEAD] == PC2NETGATE_CMD) && \
				(((((uint16_t)SscomData[COM_DATA_IC_TYPE]) <<8) + \
							SscomData[COM_DATA_IC_TYPE+1]) == MCU_TYPE))
		{
			atomic
			{
				//串口帧内容
				for(i=0;i<SscomLength-1;i++)
				{
					fcs += *(SscomData + i);
				}
			}
			//完整性验证，若正确，存入命令Buffer
			if(fcs == *(SscomData + SscomLength - 1))
			{
				atomic
				{
					for(i=0;i<SscomLength-1;i++)
					{
						ComPortBuf[rxUsed].rxBuf[i] = *(SscomData + i);
					}
				}
				
				RfTxRdyFlag = TRUE;			//rf 数据准备好，等待串口发送完成
				
				TRANS_SUCCESS[COM_DATA_NO] = *(SscomData + COM_DATA_NO);
				TRANS_SUCCESS[COM_DATA_NO+1] = *(SscomData + COM_DATA_NO+1);
				call UartStream.send((uint8_t *)TRANS_SUCCESS,COM_OUTPUT_LENGTH);	//应答上位机,成功
				
				/* atomic
				{
					if(rxUsed >= (COM_MAX_GROUP_LENGTH-1))					//循环存储上位机命令
					{
						ComPortBuf[rxUsed].next = &ComPortBuf[0];			//指向buffer
						rxUsed = 0;
					}
					else
					{
						ComPortBuf[rxUsed].next = &ComPortBuf[rxUsed+1];
						rxUsed += 1;						
					}
				}
				
				post sendData(); */
				
			}
			else
			{
				TRANS_FAILURE[COM_DATA_NO] = *(SscomData + COM_DATA_NO);
				TRANS_FAILURE[COM_DATA_NO+1] = *(SscomData + COM_DATA_NO+1);
				call UartStream.send((uint8_t *)TRANS_FAILURE,COM_OUTPUT_LENGTH);
			}
		}
		else
		{	
			//接收到的数据不是控制命令，应答上位机busy
			call UartStream.send((uint8_t *)TRANS_BUSY,COM_OUTPUT_LENGTH);
		}
	} 
}
