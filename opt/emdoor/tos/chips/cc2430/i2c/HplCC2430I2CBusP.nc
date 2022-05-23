

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

	uint8_t ack;//应答标志
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
			
			WriteSDA1();//发送起始条件数据信号
			WriteSCL1();
	
			_nop_();		//起始建立时间大于4.7us
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
		
			WriteSDA0();	//发送起始信号
	
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
	
			WriteSCL0();	//钳位

			_nop_();
			_nop_();
			}
	}
  
	async command void I2C.setStop() {
		atomic{
		
			WriteSDA0();	//发送结束条件的数据信号
			_nop_();		//发送结束条件的时钟信号
			WriteSCL1();	//结束条件建立时间大于4us
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			WriteSDA1();	//发送I2C总线结束命令
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
	
		for(BitCnt = 0;BitCnt < 8;BitCnt++)			//一个字节
		{
			if((data<< BitCnt)& 0x80)
			{
				WriteSDA1();	//判断发送位
			}
			else	
			{
				WriteSDA0();
			}
			
			_nop_();
			
			WriteSCL1();	//时钟线为高，通知被控器开始接受数据
			
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
		
			WriteSCL0();
		}
		
		_nop_();
		_nop_();
		WriteSDA1();	//释放数据线，准备接受应答位
		_nop_();
		_nop_();
		WriteSCL1();
		_nop_();
		_nop_();
		_nop_();
	
		if( (call I2CData.get()) == 1) //判断DATA位是否有反馈
		{
			ack = 0x00;              //运行至此说明没有反馈
		}
		else
		{
			ack = 0x01;		//判断是否收到应答信号
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
		
			WriteSCL0();	//置时钟线为低，准备接收
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			WriteSCL1();	//置时钟线为高使得数据有效
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			_nop_();
			
			ReadSDA();
			retc = retc << 1;	//左移补零
			if((call I2CData.get()) == 1)
			{
				retc = retc + 1;	//当数据为真加一
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
