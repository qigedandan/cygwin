/* Place all CC2430 Interrupt here... For OSAgent Design  */

module PlatformInterruptC
{
	provides interface PlatformInterrupt;
	
	provides interface PlatformInterruptRF<TPlatformIntUser> as IntRFUser;
	provides interface PlatformInterruptRF<TPlatformIntOSA> as IntRFOSA;
	
	provides interface PlatformInterruptUART<TPlatformIntUser> as IntUARTUser;
	provides interface PlatformInterruptUART<TPlatformIntOSA> as IntUARTOSA;

	provides interface PlatformInterruptTimer<TPlatformIntUser> as IntTimerUser;
	provides interface PlatformInterruptTimer<TPlatformIntOSA> as IntTimerOSA;


	uses interface PlatformInterruptTimerControl as PlatformInterruptTimerControlUser;
	uses interface PlatformInterruptTimerControl as PlatformInterruptTimerControlOSA;
}
implementation
{
	
	enum
	{
		INT_FOR_USER = 0,
		INT_FOR_OSA = 1,
	};
	
	norace uint8_t m_rf_err_int = INT_FOR_USER;
	norace uint8_t m_rf_int = INT_FOR_USER;
	
	norace uint8_t m_uart_rx0_int = INT_FOR_USER;
	norace uint8_t m_uart_tx0_int = INT_FOR_USER;

	norace uint8_t m_t1_int = INT_FOR_USER;

	/*========== Interrupt Control ==========*/
	command void PlatformInterrupt.setIntRFtoUser()
	{
		atomic
		{
			m_rf_err_int = INT_FOR_USER;
			m_rf_int = INT_FOR_USER;
		}
	}
	command void PlatformInterrupt.setIntRFtoOSA()
	{
		atomic
		{
			m_rf_err_int = INT_FOR_OSA;
			m_rf_int = INT_FOR_OSA;
		}
	}
	
	command void PlatformInterrupt.setIntUARTtoUser()
	{
		atomic
		{
			m_uart_rx0_int = INT_FOR_USER;
			m_uart_tx0_int = INT_FOR_USER;
		}
	}
	command void PlatformInterrupt.setIntUARTtoOSA()
	{
		atomic
		{
			m_uart_rx0_int = INT_FOR_OSA;
			m_uart_tx0_int = INT_FOR_OSA;
		}
	}


	command void PlatformInterrupt.setIntTimertoUser()
	{
		atomic {
			call PlatformInterruptTimerControlOSA.stopAllAlarm();
			m_t1_int = INT_FOR_USER;
		}
	}
	command void PlatformInterrupt.setIntTimertoOSA()
	{
		atomic {
			call PlatformInterruptTimerControlUser.stopAllAlarm();
			m_t1_int = INT_FOR_OSA;
		}
	}

	command bool PlatformInterrupt.isIntTimerToUser()
	{
		atomic return (m_t1_int != INT_FOR_OSA);
	}
	
	command bool PlatformInterrupt.isIntTimerToOSA()
	{
		atomic return (m_t1_int == INT_FOR_OSA);
	}

	default command void PlatformInterruptTimerControlUser.stopAllAlarm() {}
	default command void PlatformInterruptTimerControlOSA.stopAllAlarm() {}
	
	/*========== RF Interrupt ==========*/
	MCS51_INTERRUPT(SIG_RFERR)
	{
		atomic
		{
			if (m_rf_err_int == INT_FOR_OSA)
			{/* OSAgent got this signal */
				signal IntRFOSA.firedRFERR();
			}
			else
			{
				signal IntRFUser.firedRFERR();
			}
		}
		
		RFERRIF = 0; // Same as TCON &= ~_BV(1);
	}

	MCS51_INTERRUPT(SIG_RF)
	{
		atomic
		{
			if (m_rf_int == INT_FOR_OSA)
			{/* OSAgent got this signal */
				signal IntRFOSA.firedRF();
			}
			else
			{
				signal IntRFUser.firedRF();
			}
		}
	}

	default event void IntRFUser.firedRFERR()
	{
		RFERRIF = 0; // Same as TCON &= ~_BV(1);
	}
 	default event void IntRFUser.firedRF()
 	{
 		RFIF &= ~((uint8_t)0x01);
		RFIF &= ~((uint8_t)0x02);
		RFIF &= ~((uint8_t)0x04);
		RFIF &= ~((uint8_t)0x08);
		RFIF &= ~((uint8_t)0x10);
		RFIF &= ~((uint8_t)0x20);
		RFIF &= ~((uint8_t)0x40);
		RFIF &= ~((uint8_t)0x80);
	      // Clear the general RF interrupts
	      S1CON &= ~0x03;
 	}
	
	default event void IntRFOSA.firedRFERR()
	{
		RFERRIF = 0; // Same as TCON &= ~_BV(1);
	}
	default event void IntRFOSA.firedRF()
	{
 		RFIF &= ~((uint8_t)0x01);
		RFIF &= ~((uint8_t)0x02);
		RFIF &= ~((uint8_t)0x04);
		RFIF &= ~((uint8_t)0x08);
		RFIF &= ~((uint8_t)0x10);
		RFIF &= ~((uint8_t)0x20);
		RFIF &= ~((uint8_t)0x40);
		RFIF &= ~((uint8_t)0x80);
	      // Clear the general RF interrupts
	      S1CON &= ~0x03;
	}

	/*========== RF Interrupt ==========*/
	
	default event void IntUARTUser.firedRX0() {}
	default event void IntUARTUser.firedTX0() {}

	default event void IntUARTOSA.firedRX0() {}
	default event void IntUARTOSA.firedTX0() {}


	/*========== Timer Interrupt ==========*/

	MCS51_INTERRUPT(SIG_T1)
	{
		atomic
		{
			if (m_t1_int == INT_FOR_OSA)
			{
				signal IntTimerOSA.firedT1();
			}
			else
			{
				signal IntTimerUser.firedT1();
			}
		}
	}

	default event void IntTimerUser.firedT1()
	{
	    // Clear all interrupt flags
	    T1CTL &= ~(CC2430_T1_CH0IF) & ~(CC2430_T1_CH1IF) & ~(CC2430_T1_CH2IF) & ~(CC2430_T1_OVFIF);
	}
	default event void IntTimerOSA.firedT1()
	{
	    // Clear all interrupt flags
	    T1CTL &= ~(CC2430_T1_CH0IF) & ~(CC2430_T1_CH1IF) & ~(CC2430_T1_CH2IF) & ~(CC2430_T1_OVFIF);
	}
}
