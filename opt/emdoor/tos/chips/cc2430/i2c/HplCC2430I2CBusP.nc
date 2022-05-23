

//#include "CC2430I2C.h"
#include "intrins.h"

module HplCC2430I2CBusP {
  provides interface HplCC2430I2CBus as I2C;

  uses {
    interface GeneralIO as I2CClk;
    interface GeneralIO as I2CData;
  }
}
implementation {

	uint8_t ack;//Ӧ���־
	uint8_t *pdata;
	uint8_t mLength;

	uint8_t ADDR;
	uint8_t ADDR_R;
	uint8_t ADDR_W;
	
	inline	void WriteSDA1(){
		call I2CData.makeOutput();
		call I2CData.set();
	}
	inline void WriteSDA0(){
		call I2CData.makeOutput();
		call I2CData.clr();
	}
	inline void WriteSCL1(){
		call I2CClk.makeOutput();
		call I2CClk.set();
	}
	inline void WriteSCL0(){
		call I2CClk.makeOutput();
		call I2CClk.clr();
	}
	inline void ReadSDA(){
		call I2CData.makeInput();
	}
	
	async command void I2C.Setting(uint16_t addr,uint8_t len,uint8_t *pdat)
	{
		ADDR = (uint8_t)addr;
		ADDR_W = ADDR<<1;
		ADDR_R = ADDR_W+1 ;
		mLength=len;
		pdata=pdat;
	}
	
	async command void I2C.setStart() {
		atomic{
			
			WriteSDA1();//������ʼ���������ź�
			WriteSCL1();
	
			_nop_();		//��ʼ����ʱ�����4.7us
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
		
			WriteSDA0();	//������ʼ�ź�
	
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
	
			WriteSCL0();	//ǯλ

			_nop_();
			_nop_();
			}
	}
  
	async command void I2C.setStop() {
		atomic{
		
			WriteSDA0();	//���ͽ��������������ź�
			_nop_();		//���ͽ���������ʱ���ź�
			WriteSCL1();	//������������ʱ�����4us
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			WriteSDA1();	//����I2C���߽�������
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
		}
	}
  
	async command void I2C.writeByte(uint8_t data) {
		uint8_t BitCnt;
		uint8_t temp;
	
		for(BitCnt = 0;BitCnt < 8;BitCnt++)			//һ���ֽ�
		{
			if((data<< BitCnt)& 0x80)
			{
				WriteSDA1();	//�жϷ���λ
			}
			else	
			{
				WriteSDA0();
			}
			
			_nop_();
			
			WriteSCL1();	//ʱ����Ϊ�ߣ�֪ͨ��������ʼ��������
			
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
		
			WriteSCL0();
		}
		
		_nop_();
		_nop_();
		WriteSDA1();	//�ͷ������ߣ�׼������Ӧ��λ
		_nop_();
		_nop_();
		WriteSCL1();
		_nop_();
		_nop_();
		_nop_();
	
		if( (call I2CData.get()) == 1) //�ж�DATAλ�Ƿ��з���
		{
			ack = 0x00;              //��������˵��û�з���
		}
		else
		{
			ack = 0x01;		//�ж��Ƿ��յ�Ӧ���ź�
		}
	
		WriteSCL0();
		_nop_();
		_nop_();
		_nop_();
	}

	async command uint8_t I2C.readByte() {
	{
		uint8_t retc;
		uint8_t BitCnt;
		
		retc = 0;
		
		WriteSDA1();
	
		for(BitCnt=0;BitCnt<8;BitCnt++)
		{
		
			WriteSCL0();	//��ʱ����Ϊ�ͣ�׼������
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			WriteSCL1();	//��ʱ����Ϊ��ʹ��������Ч
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			
			ReadSDA();
			retc = retc << 1;	//���Ʋ���
			if((call I2CData.get()) == 1)
			{
				retc = retc + 1;	//������Ϊ���һ
			}
		}
	
		WriteSCL0();
		_nop_();
		_nop_();
	
		return(retc);
  
		}
	}
	
	async command uint8_t I2C.read(uint16_t addr, uint8_t length, uint8_t* data)
	{
		uint8_t Read_Data;
		uint8_t i;
		
		call I2C.Setting(addr,length,data);

		call I2C.setStart();
		call I2C.writeByte(ADDR_R);
		for(i=0;i<mLength;i++)
		{
			if(ack == 1)
			{
				*(pdata+i)=call I2C.readByte();
			}
			else
			{
				return 0xfe;
			}
		}
		if(ack == 1)
		{
			call I2C.setStop();
			signal I2C.readDone(0,ADDR,mLength,pdata);
		}
		return 0xfe;
	}
	async command uint8_t I2C.write(uint16_t addr, uint8_t length, uint8_t* data)
	{
		uint8_t i;
		call I2C.Setting(addr,length,data);
		call I2C.setStart();
		call I2C.writeByte(ADDR_W);
		for(i=0;i<mLength;i++)
		{
			if(ack == 1)
			{
				call I2C.writeByte(*(pdata+i));
			}
			else
			{
			return 0xfe;
			}
		}
		if(ack == 1)
		{
			call I2C.setStop();
			signal I2C.writeDone(0,ADDR,mLength,pdata);
		}
		return 0xfe;
	}
}
