/*************************************************
*	FUNCTION NAME : RelaySlaveM.nc
*	FUNCTION DESCRIPTION : LED����˸
*	FUCNTION DATE :2010/10/14
*	FUNCTION AUTHOR: EMDOOR
**/
#include "../../Device.h"
#include "../../Control.h"

//�������ݻ���ṹ��
typedef struct RfBuffer_tag 
{
	uint8_t data[RF_MAX_RX_LENGTH];
	struct RfBuffer_tag *next;
} RfBuffer_t;

module RelaySlaveM {
	uses {
		interface Boot;					//ϵͳ�����ӿ�
		interface Packet;				//
		interface UartStream;		//���ڴ���ӿ�
		interface AMPacket;
		interface AMSend;				//RF���ͽӿ�
		interface Receive;			//RF���սӿ�
		interface Relay;
		interface Timer<TMilli> as Timer;
		interface Timer<TMilli> as Timer1;
		interface StdControl as UartStdControl;	//���ڳ�ʼ��
		interface SplitControl as RFControl;		//RF��ʼ��
	}
}
implementation {
	uint8_t actionFlag = TRUE;					//����״̬
	uint8_t rfUsed,rfManaged,rfCount;
	uint8_t RepeatCap,DelayTime;
	uint16_t RepeatCount;
	uint8_t actionType,timerCount;
	RfBuffer_t RfBuf[RF_MAX_GROUP_LENGTH];		//RF���ݽ��ջ���
	
	message_t m_msg;							//RF���ݽṹ��
	uint16_t InfoNo = 0;

	/**���߷��ʹ��ڽ��յ�����
	*/
	task void ManualAck()
	{
		uint8_t j;
		uint8_t *RfPayload;
		uint16_t destAddress;
		RfPayload = call Packet.getPayload(&m_msg, NULL);
		
		destAddress = (RfBuf[rfManaged].data[RF_FCF_SRCADDR]) + \
					(((uint16_t)(RfBuf[rfManaged].data[RF_FCF_SRCADDR+1]))<<8);

		//����֡ͷ
		su8(RfPayload,0,NODE2NETGATE_ACK);
		
		//IC����
		su8(RfPayload,1,RfBuf[rfManaged].data[RF_DATA_IC_TYPE]);		
		su8(RfPayload,2,RfBuf[rfManaged].data[RF_DATA_IC_TYPE+1]);
		
		//�豸����ID
		su8(RfPayload,3,DEVICE_ID_RELAY);
		
		//ԭʼ��ַ
		su16(RfPayload,4,call AMPacket.address());
		
		//֡���к�
		su8(RfPayload,6,RfBuf[rfManaged].data[RF_DATA_CMD_NO]);		
		su8(RfPayload,7,RfBuf[rfManaged].data[RF_DATA_CMD_NO+1]);
		
		//Ӧ����
		if(actionFlag)
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
				
		//�������������������ݣ�����û���������
		atomic
		{
			RfBuf[rfManaged].next = NULL;
			rfManaged = (rfManaged+1)%RF_MAX_GROUP_LENGTH;
		}
		
		//��������
		call AMSend.send(destAddress, &m_msg, 12);
	}
	
	//������Ϣ֡
	task void InfoProcess()
	{
		uint8_t j;
		uint8_t *RfPayload;
		uint16_t destAddress;
		RfPayload = call Packet.getPayload(&m_msg, NULL);
		
		destAddress = 0x0001;				//���ص�ַĬ��Ϊ0x0001

		//������Ϣ֡
		su8(RfPayload,0,NODE2NETGATE_INFO);
		
		//IC����--cc2430
		su16(RfPayload,1,MCU_TYPE);		
		
		//�豸����ID--�̵����ڵ�
		su8(RfPayload,3,DEVICE_ID_RELAY);
		
		//ԭʼ��ַ
		su16(RfPayload,4,call AMPacket.address());
		
		//֡���к�
		su16(RfPayload,6,InfoNo);
		InfoNo++ ;			//������һ֡������Ϣ��������Ϣ���кż�1
		
		su32(RfPayload,8,0);		//����field ���0

		//��������
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
					call Relay.RelayOff();
					call Timer.startOneShot(17);
					break;
				case DEVICE_OPEN :
					call Relay.RelayOn();		
					call Timer.startOneShot(17);
					break;
				case DEVICE_REPEAT :
					RepeatCap = RfBuf[rfManaged].data[RF_DATA_CMD_CAP];
					RepeatCount = RfBuf[rfManaged].data[RF_DATA_CMD_COUNT]+(((uint16_t)RfBuf[rfManaged].data[RF_DATA_CMD_COUNT+1])<<8);
					
					timerCount = 0;
					call Timer.startPeriodic(1000);		//����Ϊ��λ
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

	/**  �����¼�����������LED.nc�Ѿ�������MainC.Boot�ӿ�
		ϵͳ���������ô˺���
	*/
	event void Boot.booted()
	{
		RepeatCap = 0;
		RepeatCount= 0;
		DelayTime = 0;

		call UartStdControl.start();		//���ڳ�ʼ��
		call RFControl.start();					//RF��ʼ��
		
		call Relay.RelayInit();
		call Relay.RelayOn();
		//call Timer1.startPeriodic(3000);
	}
	
	event void Timer.fired()
	{
		timerCount++;
		if(actionType == DEVICE_REPEAT)
		{
			if(ALWAYS_OPEN == RepeatCap)
				call Relay.RelayToggle();
			else if(timerCount >= RepeatCap)
			{
				timerCount = 0;
				if(RepeatCount)
					{
						call Relay.RelayToggle();
						RepeatCount--;
					}
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
				call Relay.RelayOn();	
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
	
	/*��Ƶ��������*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		// Add your code here
		uint8_t length = len+MAC_PROTOCOL_SIZE;
		
		uint8_t i;
		call Timer.stop();		//�����ݽ��գ��رն�ʱ��
		RepeatCap =0;RepeatCount=0;DelayTime=0;
		
		RfBuf[rfUsed].data[0] = length;
		for(i=1;i<length-1;i++)
		{RfBuf[rfUsed].data[i] = ((uint8_t *)msg)[i];}
		
		atomic
		{
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
	
	/** ʵ�ֽӿ�RFControl �ӿ��е��¼�*/
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
