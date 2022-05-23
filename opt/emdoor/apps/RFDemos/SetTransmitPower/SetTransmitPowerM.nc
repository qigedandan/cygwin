/*************************************************
*	FUNCTION NAME : SetTransmintPowerM.nc
*	FUNCTION DESCRIPTION : ��Ƶͨ�ŷ��书������
*	FUCNTION DATE :2010/10/18
*	FUNCTION AUTHOR: EMDOOR
**/

#define DBG_LEV 1000

module SetTransmitPowerM
{
	uses {
		interface Boot;
		interface StdControl as UartStdControl;
		interface UartStream;		
		interface AMSend;
		interface Receive;
		interface Packet;
		interface AMPacket;		
		interface GlobalTXPower;
		interface SplitControl as RFControl;
		interface Leds;
	}
}
implementation
{	
	enum
	{		
		INPUT_CHOICE = 0,
		INPUT_PA_LEVEL = 1,
	};

	enum
	{
		PA_LEVEL_31 = 31,
		PA_LEVEL_27 = 27,
		PA_LEVEL_23 = 23,
		PA_LEVEL_19 = 19,
		PA_LEVEL_15 = 15,
		PA_LEVEL_11 = 11,
		PA_LEVEL_7   = 7,
		PA_LEVEL_3   = 3,
	};

	message_t msg;
	uint16_t count = 0;		
	uint8_t m_input_type = 0;
	bool choice = FALSE;
	bool power_input = FALSE;
	uint8_t m_power_index = 0;

	task void sendData();

	/*��ʾ�˵�*/
	task void showMenu()
	{
		if(m_input_type == INPUT_PA_LEVEL)
		{/*�ȴ����빦��ֵ*/
			ADBG(DBG_LEV, "\r\n###################################\r\n");
			ADBG(DBG_LEV, "\r\n*[1]  PA_LEVEL_3\r\n");
			ADBG(DBG_LEV, "*[2]  PA_LEVEL_7\r\n");
			ADBG(DBG_LEV, "*[3]  PA_LEVEL_11\r\n");
			ADBG(DBG_LEV, "*[4]  PA_LEVEL_15\r\n");
			ADBG(DBG_LEV, "*[5]  PA_LEVEL_19\r\n");
			ADBG(DBG_LEV, "*[6]  PA_LEVEL_23\r\n");
			ADBG(DBG_LEV, "*[7]  PA_LEVEL_27\r\n");
			ADBG(DBG_LEV, "*[8]  PA_LEVEL_31\r\n");
			ADBG(DBG_LEV, "\r\n###################################\r\nSelect:\r\n");	
			
			power_input = FALSE;
		}
		else
		{/*ѡ���Ƿ�ı书��*/
			ADBG(DBG_LEV, "\r\n#########################################################\r\n* MY nodeId = 0x%x, GROUP = 0x%x,  Current PA_LEVEL = %d, set PA_LEVEL?(Y/N)\r\n",
				ADBG_N(call AMPacket.address()),
				ADBG_N(TOS_IEEE_PANID),
				ADBG_N(call GlobalTXPower.getTXPower())
			);

			m_input_type = INPUT_CHOICE;
			choice = FALSE;
		}
	}

	task void setPower()
	{
		atomic
		{
			switch(m_power_index) {

			case 1:
				call GlobalTXPower.setTXPower(PA_LEVEL_3);
				break;
			case 2:
				call GlobalTXPower.setTXPower(PA_LEVEL_7);
				break;
			case 3:
				call GlobalTXPower.setTXPower(PA_LEVEL_11);
				break;
			case 4:
				call GlobalTXPower.setTXPower(PA_LEVEL_15);
				break;
			case 5:
				call GlobalTXPower.setTXPower(PA_LEVEL_19);
				break;
			case 6:
				call GlobalTXPower.setTXPower(PA_LEVEL_23);
				break;
			case 7:
				call GlobalTXPower.setTXPower(PA_LEVEL_27);
				break;
			case 8:
				call GlobalTXPower.setTXPower(PA_LEVEL_31);
				break;
			default:				
				break;			
			}
			ADBG(DBG_LEV, "\r\n**Set Power OK!\r\n");
			post sendData();
		}
	}

	task void sendData()
	{
		uint8_t i;
		uint8_t* payload = call Packet.getPayload(&msg, NULL);
		uint16_t address = call AMPacket.address();
		uint16_t dest_address = 1;

		count++;

		payload[0] = count;
		payload[1] = count >> 8;

		ADBG( DBG_LEV, "\r\n\r\n* Sending ... from [%d], to [%d], len=[%d]\r\n",
			ADBG_N(address),
			ADBG_N(dest_address),
			ADBG_N(sizeof(count))
		);

		call AMSend.send(dest_address, &msg, sizeof(count));

		call Leds.BlueLedToggle();
		// LED_BLUE_TOGGLE;
	}

	/*�����괦��*/
	event void AMSend.sendDone(message_t* msg, error_t success)
	{
		ADBG(DBG_LEV, "* Sent%s!\r\n", (success == SUCCESS) ? "OK" : "FAIL");		

		m_input_type = INPUT_CHOICE;

		post showMenu();
	}



	/*�Ӵ��ڽ�����*/
	async event void UartStream.receivedByte(uint8_t c)
	{
		if(c != '\r')
		{
			if(m_input_type == INPUT_CHOICE)
			{/*����ѡ��*/
				ADBG(DBG_LEV, "%c", c);
				
				if(c == 'Y' || c == 'y')
				{
					choice = TRUE;
					return;
				}
				else if(c == 'N' || c== 'n')
				{
					post sendData();
					return;
				}
				else
				{
					ADBG(DBG_LEV, "\r\n invalid input!!\r\n");					
					post showMenu();
					return;
				}
			}
			else
			{/*���빦�ʵȼ�*/
				ADBG(DBG_LEV, "%c", c);
				if(c >= '1' && c <= '8' && power_input != TRUE)
				{					
					m_power_index = (uint8_t)( c - '0');					
					power_input = TRUE;
					return;
				}
				else
				{
					ADBG(DBG_LEV, "\r\n invalid input!!\r\n");					
					post showMenu();
					return;
				}
			}			
		}

		if(m_input_type == INPUT_PA_LEVEL )
		{			
			if( power_input == TRUE)
			{				
				post setPower();
			}
		}
		else 
		{
			if(choice ==TRUE) {
				m_input_type = INPUT_PA_LEVEL;
				post showMenu();	
			}			
		}
		
	}
		
	/*�ڵ�����*/
	event void Boot.booted()
	{	
		/*������Ƶ*/
		call RFControl.start();

		/*��������ͨ��*/
		call UartStdControl.start();

		call Leds.YellowLedOff();
		call Leds.BlueLedOff();
		// LED_YELLOW_OFF;
		// LED_BLUE_OFF;

		ADBG(DBG_LEV, "\r\n#####################################################\r\n");
		ADBG(DBG_LEV, "   [SETTXPOWER DEMO] My Address = 0x%x, Group = 0x%x\r\n", ADBG_N(call AMPacket.address()), ADBG_N(TOS_IEEE_PANID));
		ADBG(DBG_LEV, "#####################################################\r\n");

		m_input_type = INPUT_CHOICE;
		if(call AMPacket.address()!=1)
		{
			post showMenu();
		}
	}

	/** ʵ�ֽӿ�RFControl �ӿ��е��¼�*/
	event void RFControl.startDone(error_t result)
	{
	}

	event void RFControl.stopDone(error_t result)
	{
	}

	/** ʵ�ֽӿ�UartStream �ӿ��е��¼�*/
	async event void UartStream.sendDone(uint8_t* buf, uint16_t len, error_t error)
	{		
	}

	async event void UartStream.receiveDone(uint8_t* buf, uint16_t len, error_t error)
	{
	}	

	/*��Ƶ��������*/
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		uint8_t i;
		ADBG(DBG_LEV, "\r\n*Receive, len = [%d]\r\n", ADBG_N(len));
		
		call Leds.YellowLedToggle();
		// LED_YELLOW_TOGGLE;
		
		m_input_type = INPUT_CHOICE;

		post showMenu();
	}
}
	
		

