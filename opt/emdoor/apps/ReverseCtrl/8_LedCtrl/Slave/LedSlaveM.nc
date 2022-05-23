/*************************************************
*	FUNCTION NAME : LedSlaveMM.nc
*	FUNCTION DESCRIPTION : LED灯闪烁
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/

#include "../../Device.h"
#include "../../Control.h"

//串口数据缓存结构体
typedef struct RfBuffer_tag 
{
	uint8_t data[RF_MAX_RX_LENGTH];
	struct RfBuffer_tag *next;
} RfBuffer_t;

module LedSlaveM {
	uses {
		interface Boot;					//系统启动接口
		interface Packet;				//
		interface UartStream;		//串口处理接口
		interface AMPacket;
		interface AMSend;				//RF发送接口
		interface Receive;			//RF接收接口
		interface Leds;
		interface Timer<TMilli> as Timer;				//超时定时器
		interface Timer<TMilli> as Timer1;			//定时发送信息定时器
		interface StdControl as UartStdControl;	//串口初始化
		interface SplitControl as RFControl;		//RF初始化
	}
}
implementation {
	uint8_t actionFlag = TRUE;					//控制状态
	uint8_t rfUsed,rfManaged,rfCount;
	uint8_t RepeatCap,DelayTime;
	uint16_t RepeatCount;
	uint8_t actionType,timerCount;
	RfBuffer_t RfBuf[RF_MAX_GROUP_LENGTH];		//RF数据接收缓存
		
	message_t m_msg;							//RF数据结构体
	uint16_t InfoNo = 0 ;					//自身信息序列号
	
	/**无线发送数据
	*/
	task void ManualAck()
	{
		uint8_t j;
		uint8_t *RfPayload;
		uint16_t destAddress;
		RfPayload = call Packet.getPayload(&m_msg, NULL);
		
		destAddress = (RfBuf[rfManaged].data[RF_FCF_SRCADDR]) + \
					(((uint16_t)(RfBuf[rfManaged].data[RF_FCF_SRCADDR+1]))<<8);

		//命令帧头
		su8(RfPayload,0,NODE2NETGATE_ACK);
		
		//IC类型
		su8(RfPayload,1,RfBuf[rfManaged].data[RF_DATA_IC_TYPE]);		
		su8(RfPayload,2,RfBuf[rfManaged].data[RF_DATA_IC_TYPE+1]);
		
		//设备类型ID
		su8(RfPayload,3,DEVICE_ID_LED);
		
		//原始地址
		su16(RfPayload,4,call AMPacket.address());
		
		//帧序列号
		su8(RfPayload,6,RfBuf[rfManaged].data[RF_DATA_CMD_NO]);		
		su8(RfPayload,7,RfBuf[rfManaged].data[RF_DATA_CMD_NO+1]);
		
		//应答结果
		if(actionFlag)			/*成功*/
		{
			su8(RfPayload,8,0x00);
			su8(RfPayload,9,0xAA);
			su8(RfPayload,10,0x00);
			su8(RfPayload,11,0xAA);
		}
		else
		{
			su8(RfPayload,8,0x00);
			su8(RfPayload,9,0x55);
			su8(RfPayload,10,0x00);
			su8(RfPayload,11,0x55);
		}
				
		//处理完成命令缓冲区中数据，清除该缓冲区内容
		atomic
		{
			RfBuf[rfManaged].next = NULL;
			rfManaged = (rfManaged+1)%RF_MAX_GROUP_LENGTH;
		}
		
		//发送数据
		call AMSend.send(destAddress, &m_msg, 12);
	}
	
	task void InfoProcess()
	{
		uint8_t j;
		uint8_t *RfPayload;
		uint16_t destAddress;
		RfPayload = call Packet.getPayload(&m_msg, NULL);
		
		destAddress = 0x0001;				//网关地址默认为0x0001

		//自身信息帧
		su8(RfPayload,0,NODE2NETGATE_INFO);
		
		//IC类型--cc2430
		su16(RfPayload,1,MCU_TYPE);		
		
		//设备类型ID--灯节点
		su8(RfPayload,3,DEVICE_ID_LED);
		
		//原始地址
		su16(RfPayload,4,call AMPacket.address());
		
		//帧序列号
		su16(RfPayload,6,InfoNo);
		InfoNo++ ;			//发送完一帧自身信息，自身信息序列号加1
		
		su32(RfPayload,8,0);		//负载field 填充0

		//发送数据
		call AMSend.send(destAddress, &m_msg, 12);
	}
	
	task void RfDataProcess()
	{
		if((0x36 == RfBuf[rfManaged].data[RF_DATA_HEAD])&&(0x2430 == ((RfBuf[rfManaged].data[RF_DATA_IC_TYPE]<<8) +\
				((uint16_t)RfBuf[rfManaged].data[RF_DATA_IC_TYPE+1]))))
		{			
			call UartStream.send(RfBuf[rfManaged].data,RfBuf[rfManaged].data[0]);
			post ManualAck();
			actionType = RfBuf[rfManaged].data[RF_DATA_CMD_HEAD];
			switch(actionType)
			{
				case DEVICE_OFF :
					call Leds.YellowLedOff();
					call Timer.startOneShot(17);
					break;
				case DEVICE_OPEN :
					call Leds.YellowLedOn();
					call Timer.startOneShot(17);
					break;
				case DEVICE_REPEAT :
					RepeatCap = RfBuf[rfManaged].data[RF_DATA_CMD_CAP];
					RepeatCount = RfBuf[rfManaged].data[RF_DATA_CMD_COUNT]+(((uint16_t)RfBuf[rfManaged].data[RF_DATA_CMD_COUNT+1])<<8);
					
					timerCount = 0;
					call Timer.startPeriodic(1000);		//以秒为单位
					break;
				case DEVICE_DELAY :
					DelayTime = RfBuf[rfManaged].data[RF_DATA_CMD_DELAY];
					
					timerCount = 0;
					call Timer.startPeriodic(1000);
					break;
				default:
					actionFlag = FALSE;
					call Timer.startOneShot(17);
					break;
			}
		} 
	}

	/**  启动事件处理函数，在LED.nc已经关联到MainC.Boot接口
		系统启动后会调用此函数
	*/
	event void Boot.booted()
	{
		RepeatCap = 0;
		RepeatCount= 0;
		DelayTime = 0;
		
		call UartStdControl.start();		//串口初始化
		call RFControl.start();					//RF初始化
		
		call Leds.YellowLedOn();
		call Timer1.startPeriodic(3000);		
	}
	
	event void Timer.fired()
	{
		timerCount++;
		if(actionType == DEVICE_REPEAT)
		{
			if(ALWAYS_OPEN == RepeatCap)
				call Leds.YellowLedToggle();
			else if(timerCount >= RepeatCap)
			{
				timerCount = 0;
				if(RepeatCount)
					{call Leds.YellowLedToggle();RepeatCount--;}
				else
					{call Timer.stop();}
			}
			else 
				;
		}
		else if(actionType == DEVICE_DELAY)
		{
			if(timerCount >= DelayTime)
			{
				timerCount = 0;
				call Timer.stop();
				call Leds.YellowLedOn();				
			}
		}
		else 
		{
			call Timer.stop();
		}
	}
	
	event void Timer1.fired()
	{
		post InfoProcess();
	}
	
	/*射频接收数据*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		// Add your code here
		uint8_t length = len+MAC_PROTOCOL_SIZE;
		
		uint8_t i;
		
		call Timer.stop();		//有数据接收，关闭定时器
		RepeatCap =0;RepeatCount=0;DelayTime=0;
		
		RfBuf[rfUsed].data[0] = length;
		for(i=1;i<length-1;i++)
		{RfBuf[rfUsed].data[i] = ((uint8_t *)msg)[i];}
		
		atomic
		{
			/* if(rfUsed>=(RF_MAX_GROUP_LENGTH-1))
			{
				RfBuf[rfUsed].next = &RfBuf[0];
				rfUsed =0;
			}
			else
			{
				RfBuf[rfUsed].next = &RfBuf[rfUsed+1];
				rfUsed += 1;
			} */
			
			RfBuf[rfUsed].next = &RfBuf[(rfUsed+1)%RF_MAX_GROUP_LENGTH];
			rfUsed = (rfUsed+1)%RF_MAX_GROUP_LENGTH;			
		}
		
		actionFlag = TRUE;
		post RfDataProcess();
	}
	
	async event void UartStream.receivedByte(uint8_t byte)
	{
	}		
	
	async event void UartStream.sendDone(uint8_t* buf, uint16_t len, error_t error)
	{
	}
	
	async event void UartStream.receiveDone(uint8_t* buf, uint16_t len, error_t error)
	{
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
	}	
}
