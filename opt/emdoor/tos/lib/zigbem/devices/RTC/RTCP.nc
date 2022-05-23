
generic module RTCP()
{
	provides interface RTC;
	uses interface GpioInterrupt as AlarmInterrupt;	
	uses interface I2CPacket<TI2CBasicAddr> as I2C;
}
implementation
{
	enum
	{
		RTC_NONE,
		RTC_WRITE,
		RTC_READ,
	};
	
	uint8_t m_state = RTC_NONE;
	rtc_time *m_rtc_time;
	uint8_t m_time_flag;
	uint8_t m_alarm_flag;
	uint8_t *p_alarm_flag;
	uint8_t m_write_buf[2];
	uint8_t m_error = SUCCESS;
	
	void writeByte(uint8_t reg_addr, uint8_t m_data)
	{
		atomic {
			m_write_buf[0] = reg_addr;
			m_write_buf[1] = m_data;
			
			call I2C.write(0, Addr_Pcf8563, 2, m_write_buf);
		}
	}

	void readByte(uint8_t addr, uint8_t *data)
	{
		call I2C.write(0, Addr_Pcf8563, 1, (uint8_t*)(&addr));
		call I2C.read(0, Addr_Pcf8563, 1, data);
	}
	
	command error_t RTC.setTime(rtc_time *Time,uint8_t mTimeFlag)
	{
		uint8_t m_time_tmp;
		atomic {
			if (m_state == RTC_WRITE || m_state == RTC_READ)
			{
				return EBUSY;
			}
			m_state = RTC_WRITE;
			m_rtc_time = Time;
			m_time_flag = mTimeFlag;
		}
		
		if(m_time_flag&Flag_year)
		{
			m_time_tmp = ((m_rtc_time->year)/10)*16 + (m_rtc_time->year)%10;
			writeByte(Addr_year,m_time_tmp);
		}
		if(m_time_flag&Flag_month)
		{
			m_time_tmp = ((m_rtc_time->month)/10)*16 + (m_rtc_time->month)%10;
			writeByte(Addr_month,m_time_tmp);
		}
		if(m_time_flag&Flag_day)
		{
			m_time_tmp = ((m_rtc_time->day)/10)*16 + (m_rtc_time->day)%10;
			writeByte(Addr_day,m_time_tmp);
		}
		if(m_time_flag&Flag_hour)
		{
			m_time_tmp = ((m_rtc_time->day)/10)*16 + (m_rtc_time->day)%10;
			writeByte(Addr_hour,m_time_tmp);
		}
		if(mTimeFlag&Flag_minute)
		{
			m_time_tmp = ((m_rtc_time->minute)/10)*16 + (m_rtc_time->minute)%10;		
			writeByte(Addr_minute,m_time_tmp);
		}
		if(mTimeFlag&Flag_second)
		{
			m_time_tmp = ((m_rtc_time->second)/10)*16 + (m_rtc_time->second)%10;		
			writeByte(Addr_second,m_time_tmp);
		}
		
		atomic m_state = RTC_NONE;
		signal RTC.setTimeDone(m_error,m_rtc_time,m_time_flag);
		
		return SUCCESS;
	}
	
	command error_t RTC.getTime(rtc_time *Time,uint8_t mTimeFlag)
	{
		uint8_t m_time_tmp;
		uint8_t m_reg_tmp;
		
		atomic {
			if (m_state == RTC_WRITE || m_state == RTC_READ)
			{
				return EBUSY;
			}
			m_state = RTC_READ;
			m_rtc_time = Time;
			m_time_flag = mTimeFlag;
		}
		
		if(m_time_flag&Flag_year)
		{
			readByte(Addr_year,&m_time_tmp);
			m_rtc_time->year = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_month)
		{
			readByte(Addr_month,&m_time_tmp);
			m_time_tmp &= 0x1f ;
			m_rtc_time->month = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_day)
		{
			readByte(Addr_day,&m_time_tmp);
			m_time_tmp &= 0x3f ;
			m_rtc_time->day = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_hour)
		{
			readByte(Addr_hour,&m_time_tmp);
			m_time_tmp &= 0x3f ;
			m_rtc_time->hour = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_minute)
		{
			readByte(Addr_minute,&m_time_tmp);
			m_time_tmp &= 0x7f ;
			m_rtc_time->minute = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_second)
		{
			readByte(Addr_second,&m_time_tmp);
			m_time_tmp &= 0x7f ;
			m_rtc_time->second = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}

		atomic m_state = RTC_NONE;
		signal RTC.getTimeDone(m_error,m_rtc_time,m_time_flag);
		
		return SUCCESS;
	}

	command error_t RTC.setAlarm(rtc_time *Time,uint8_t mTimeFlag,uint8_t mAlarmFlag)
	{
		uint8_t m_time_tmp;
		uint8_t m_reg_tmp;
		atomic {
			if (m_state == RTC_WRITE || m_state == RTC_READ)
			{
				return EBUSY;
			}
			m_state = RTC_WRITE;
			m_rtc_time = Time;
			m_time_flag = mTimeFlag;
			m_alarm_flag = mAlarmFlag;
		}

		if(m_time_flag&Flag_day)
		{
			m_time_tmp = ((m_rtc_time->day)/10)*16 + (m_rtc_time->day)%10;
			if(m_alarm_flag & Flag_Alarm_day)
			{
				m_time_tmp &= ~0x80 ;
			}
			else
			{
				m_time_tmp |= 0x80 ;
			}
			writeByte(Addr_Alarm_day,m_time_tmp);
		}
		if(m_time_flag&Flag_hour)
		{
			m_time_tmp = ((m_rtc_time->day)/10)*16 + (m_rtc_time->day)%10;
			if(m_alarm_flag & Flag_Alarm_hour)
			{
				m_time_tmp &= ~0x80 ;
			}
			else
			{
				m_time_tmp |= 0x80 ;	
			}
			writeByte(Addr_Alarm_hour,m_time_tmp);
		}
		if(mTimeFlag&Flag_minute )
		{
			m_time_tmp = ((m_rtc_time->minute)/10)*16 + (m_rtc_time->minute)%10;		
			if(m_alarm_flag & Flag_Alarm_minute)
			{
				m_time_tmp &= ~0x80 ;	
			}
			else
			{
				m_time_tmp |= 0x80 ;
			}
			writeByte(Addr_Alarm_minute,m_time_tmp);
		}
		if(mTimeFlag&Flag_minute )
		{
			m_time_tmp = ((m_rtc_time->week)/10)*16 + (m_rtc_time->week)%10;
			if(m_alarm_flag & Flag_Alarm_week)
			{
				m_time_tmp &= ~0x80 ;
			}
			else
			{
				m_time_tmp |= 0x80 ;
			}
			writeByte(Addr_Alarm_week,m_time_tmp);
		}

		readByte(Addr_Control_Status_2,&m_reg_tmp);
		ADBG(DBG_LEV, " \r\n Addr_Control_Status_2 = 0x%x \r\n",(int)(m_reg_tmp) );
		if(m_alarm_flag)
		{
			m_reg_tmp &= ~0xe0 ;
			m_reg_tmp &= ~0x08 ;
			m_reg_tmp |= 0x02 ;
			writeByte(Addr_Control_Status_2,m_reg_tmp);			
			ADBG(DBG_LEV, " \r\n RTC.setAlarm__m_alarm_flag = %d \r\n",(int)(m_alarm_flag) );
			ADBG(DBG_LEV, " \r\n Addr_Control_Status_2 = 0x%x \r\n",(int)(m_reg_tmp) );
			call AlarmInterrupt.enableFallingEdge();
		}
		else
		{
			m_reg_tmp &= ~0x02 ;
			writeByte(Addr_Control_Status_2,m_reg_tmp );
			call AlarmInterrupt.disable();
		}

		atomic m_state = RTC_NONE;
		signal RTC.setAlarmDone(m_error,m_rtc_time,m_time_flag,m_alarm_flag);
		
		return SUCCESS;		
	}
	
	command error_t RTC.getAlarm(rtc_time *Time,uint8_t mTimeFlag,uint8_t *pAlarmFlag)
	{
		uint8_t m_time_tmp;
		
		atomic {
			if (m_state == RTC_WRITE || m_state == RTC_READ)
			{
				return EBUSY;
			}
			m_state = RTC_READ;
			m_rtc_time = Time;
			m_time_flag = mTimeFlag;
			p_alarm_flag = pAlarmFlag;
		}
		
		if(m_time_flag&Flag_day)
		{
			readByte(Addr_Alarm_day,&m_time_tmp);
			if(m_time_tmp&0x80)
			{
				(*p_alarm_flag) |= Flag_Alarm_day;
			}
			m_time_tmp &= 0x3f ;
			m_rtc_time->day = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_hour)
		{
			readByte(Addr_Alarm_hour,&m_time_tmp);
			if(m_time_tmp&0x80)
			{
				(*p_alarm_flag) |= Flag_Alarm_hour;
			}
			m_time_tmp &= 0x3f ;
			m_rtc_time->hour = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_minute )
		{
			readByte(Addr_Alarm_minute ,&m_time_tmp);
			if(m_time_tmp&0x80)
			{
				(*p_alarm_flag) |= Flag_Alarm_minute;
			}
			m_time_tmp &= 0x7f ;
			m_rtc_time->minute = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}
		if(m_time_flag&Flag_week )
		{
			readByte(Addr_Alarm_week,&m_time_tmp);
			if(m_time_tmp&0x80)
			{
				(*p_alarm_flag) |= Flag_Alarm_week;
			}
			m_time_tmp &= 0x7f ;
			m_rtc_time->week = (m_time_tmp/16)*10 + m_time_tmp%16 ;
		}

		atomic m_state = RTC_NONE;
		signal RTC.getAlarmDone(m_error,m_rtc_time,m_time_flag,p_alarm_flag);
		
		return SUCCESS;
	}
	async event void 	AlarmInterrupt.fired()
	{
		uint8_t m_reg_tmp;
		readByte(Addr_Control_Status_2,&m_reg_tmp);
		m_reg_tmp &= ~0x08 ;
		writeByte(Addr_Control_Status_2,m_reg_tmp);
		signal RTC.AlarmFired();
	}
	async event void I2C.readDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data){}
	async event void I2C.writeDone(error_t error, uint16_t addr, uint8_t length, uint8_t* data){}
	
	default event void RTC.AlarmFired() {}
	default event void RTC.setTimeDone(error_t error, rtc_time *Time,uint8_t mTimeFlag) {}
	default event void RTC.getTimeDone(error_t error, rtc_time *Time,uint8_t mTimeFlag) {}
	default event void RTC.setAlarmDone(error_t error, rtc_time *Time,uint8_t mTimeFlag,uint8_t mAlarmFlag) {}
	default event void RTC.getAlarmDone(error_t error, rtc_time *Time,uint8_t mTimeFlag,uint8_t *pAlarmFlag){}

}

