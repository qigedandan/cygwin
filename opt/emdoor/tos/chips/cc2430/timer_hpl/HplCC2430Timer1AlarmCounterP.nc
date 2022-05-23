

generic module HplCC2430Timer1AlarmCounterP( typedef frequency )
{
  provides interface Counter<frequency, uint16_t> as Counter;
  provides interface Alarm<frequency, uint16_t> as Alarm0;
  provides interface Alarm<frequency, uint16_t> as Alarm1;
  provides interface Alarm<frequency, uint16_t> as Alarm2;
  provides interface Init;

  provides interface GpioCapture as CaptureChannel2;

  provides interface PlatformInterruptTimerControl;
  uses interface PlatformInterruptTimer<TPlatformIntUser> as IntTimer;
  uses interface PlatformInterrupt;



  //uses interface TimerRTC;

}
implementation
{

	// ORDER IS IMPORTANT HERE! Allways read Low register first!!
	#define GET_NOW(p) {((uint8_t*)&p)[1]=T1CNTL;  ((uint8_t*)&p)[0]=T1CNTH; }
	#define GET_COMPARE0(p)	{((uint8_t*)&p)[1]=T1CC0L;  ((uint8_t*)&p)[0]=T1CC0H; }

	/*
	   Strange method for PlatformInterruptC
	*/

	command void PlatformInterruptTimerControl.stopAllAlarm()
	{
		call Alarm0.stop();
		call Alarm1.stop();
		call Alarm2.stop();
	}
	/*
	* Argh.. Do we know if Timer1.init() has finished by this point?
	*/
	command error_t Init.init()
	{
		atomic
		{
			T1CCTL1 = 0;
			T1CCTL2 = 0;

			T1CNTL = 0;
			T1CNTH = 0;
			/* Force 32kHz Timer1 Tick speed.. */
			CLKCON = (CLKCON & ~CC2430_CLKCON_TICKSPD_MASK) | CC2430_TICKF_DIV_8; //divider = 8, 4MHz Timer1 Tick speed

			//T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_8);
			//T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_32);
			T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_128); //128 Divider
			//T1CTL  = ((T1CTL & ~CC2430_T1CTL_DIV_MASK) | CC2430_TIMER1_DIV_1);

			// Clear all interrupt flags
			T1CTL &= ~(CC2430_T1_CH0IF) & ~(CC2430_T1_CH1IF) & ~(CC2430_T1_CH2IF) & ~(CC2430_T1_OVFIF);

			//Timer mode free
			T1CTL  = (T1CTL & ~CC2430_T1CTL_MODE_MASK) | CC2430_TIMER1_MODE_FREE;
			
			// Compare register  	
			T1CCTL0 |= (1 << CC2430_T1CCTLx_MODE); // Mode = compare
			T1CCTL1 |= (1 << CC2430_T1CCTLx_MODE); // Mode = compare
			T1CCTL2 |= (1 << CC2430_T1CCTLx_MODE); // Mode = compare

			// Not comparing now
			T1CCTL0 &= ~0x40; // Compare int off
			T1CCTL1 &= ~0x40; // Compare int off
			T1CCTL2 &= ~0x40; // Compare int off
			 
			TIMIF |= _BV(CC2430_TIMIF_OVFIM); // Enable overflow int
			T1IE   = 1;   // enable events
		}
    
		return SUCCESS;
	}
 


	/*********************************************************************
	*                              Alarm 0                              *
	*********************************************************************/ 

	async command void Alarm0.stop()
	{
		ADBG(1, "Alarm0.stop \n");
		/* FIXME: Try to fix a bug when call PlatformInterrupt.setIntTimerToOSA from the User timer fired period */
		if (call PlatformInterrupt.isIntTimerToOSA())
		{
			return;
		}
		T1CCTL0 &= ~_BV(CC2430_T1CCTLx_IM) ; 
	}
	async command bool Alarm0.isRunning()
	{
		return (T1CCTL0 & _BV(CC2430_T1CCTLx_IM));
	}
	async command uint16_t Alarm0.getAlarm()
	{
		uint16_t r;

		((uint8_t*)&r)[1]=T1CC0L;
		((uint8_t*)&r)[0]=T1CC0H;
		
		return (r); 
	}

	async command uint16_t Alarm0.getNow()
	{
		uint16_t r;
		GET_NOW(r);
		return r;
	}

	async command void Alarm0.start(uint16_t dt)
	{
		uint16_t now;
		GET_NOW(now);

		call Alarm0.startAt( now, dt );
	}

	async command void Alarm0.startAt(uint16_t t0, uint16_t dt)
	{
		uint16_t set, now, elapsed;

		ADBG(1, "Alarm0.startAt t0=0x%x, dt=0x%x\n", t0, dt);

		atomic
		{
			GET_NOW(now);

			elapsed = now - t0; // This number wraps if counter has wrapped
   
			if (elapsed >= dt)
			{
				set = now + 5; // elapse in 5 tics
			}
			else
			{
				uint16_t remaining = dt - elapsed;
				if (remaining <= 5)
				{
					set = now + 5; // elapse in 5 tics
				}
				else
				{
					set = remaining + now;
				}
			}

			// Order is important!! Allways write Low byte first!!
			T1CC0L = (uint8_t) ((uint8_t*)&set)[1];
			T1CC0H = (uint8_t) ((uint8_t*)&set)[0];
			T1CCTL0 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask
    
			ADBG(1, "Alarm0.startAt T1CCTL0=0x%x\n", T1CCTL0);
		}

		return;
	}

	/*********************************************************************
	*                              Alarm 1                              *
	*********************************************************************/ 
	async command void Alarm1.stop()
	{
		/* FIXME: Try to fix a bug when call PlatformInterrupt.setIntTimerToOSA from the User timer fired period */
		if (call PlatformInterrupt.isIntTimerToOSA())
		{
			return;
		}
		T1CCTL1 &= ~_BV(CC2430_T1CCTLx_IM) ;
	}
	async command bool Alarm1.isRunning()
	{
		return (T1CCTL1 & _BV(CC2430_T1CCTLx_IM));
	}
	async command uint16_t Alarm1.getAlarm()
	{
		uint16_t r;
		// Order is important!! Read low first!!
		((uint8_t*)&r)[1] = T1CC1L;
		((uint8_t*)&r)[0] = T1CC1H;
		return (r); 
	}

	async command uint16_t Alarm1.getNow()
	{
		uint16_t r;
		GET_NOW(r);
		return r;
	}

	async command void Alarm1.start(uint16_t dt)
	{
		uint16_t now;
		GET_NOW(now);
		call Alarm1.startAt( now, dt );
	}

	async command void Alarm1.startAt(uint16_t t0, uint16_t dt)
	{
		uint16_t set, now, elapsed;

		ADBG(1, "Alarm1.startAt t0=0x%x, dt=0x%x\n", t0, dt);
		atomic
		{
			GET_NOW(now);

			elapsed = now - t0; // This number wraps if counter has wrapped
   
			if (elapsed >= dt)
			{
				set = now + 5; // elapse in 5 tics
			}
			else
			{
				uint16_t remaining = dt - elapsed;
				if( remaining <= 5 )  {
				set = now + 5; // elapse in 5 tics
				}
				else
				{
					set = remaining + now;
				}
			}

			// Order is important!! Allways write Low byte first!!
			T1CC1L = (uint8_t) ((uint8_t*)&set)[1];
			T1CC1H = (uint8_t) ((uint8_t*)&set)[0];
    
			T1CCTL1 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask
		}
		return;
	}

/*********************************************************************
 *                              Alarm 2                              *
 *********************************************************************/ 

	async command void Alarm2.stop()
	{
		/* FIXME: Try to fix a bug when call PlatformInterrupt.setIntTimerToOSA from the User timer fired period */
		if (call PlatformInterrupt.isIntTimerToOSA())
		{
			return;
		}
		T1CCTL2 &= ~_BV(CC2430_T1CCTLx_IM) ;
	}
	async command bool Alarm2.isRunning()
	{
		return (T1CCTL2 & _BV(CC2430_T1CCTLx_IM));
	}
	
	async command uint16_t Alarm2.getAlarm()
	{
		uint16_t r;
		// Order is important!! Read low first!!
		((uint8_t*)&r)[1] = T1CC2L;
		((uint8_t*)&r)[0] = T1CC2H;
		return (r); 
	}

	async command uint16_t Alarm2.getNow()
	{
		uint16_t r;
		GET_NOW(r);
		return r;
	}

	async command void Alarm2.start(uint16_t dt)
	{
		uint16_t now;
		GET_NOW(now);
		call Alarm2.startAt( now, dt );
	}

	async command void Alarm2.startAt(uint16_t t0, uint16_t dt)
	{
		uint16_t set, now, elapsed;

		ADBG(1, "Alarm2.startAt t0=0x%x, dt=0x%x\n", t0, dt);
    
		atomic
		{
			GET_NOW(now);

			elapsed = now - t0; // This number wraps if counter has wrapped
   
			if (elapsed >= dt)
			{
				set = now + 5; // elapse in 5 tics
			}
			else
			{
				uint16_t remaining = dt - elapsed;
				if (remaining <= 5)
				{
					set = now + 5; // elapse in 5 tics
				} else {
					set = remaining + now;
				}
			}

			// Order is important!! Allways write Low byte first!!
			T1CC2L = (uint8_t) ((uint8_t*)&set)[1];
			T1CC2H = (uint8_t) ((uint8_t*)&set)[0];
			T1CCTL2 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask
		}

		return;
	}



/*********************************************************************
 *                              Junk                                 *
 *********************************************************************/ 

      /*
    now = GET_NOW();
    elapsed now - t0;
    //((uint8_t*)&now)[0] = (uint8_t) T1CNTH;
    //((uint8_t*)&now)[1] = (uint8_t) T1CNTL;
    stor = now + dt; //t0 + dt;
    set = (uint16_t) (stor % 0xFFFF);

       T1CC0H = (uint8_t) ((uint8_t*)&set)[0];
       T1CC0L = (uint8_t) ((uint8_t*)&set)[1];
       T1CCTL0 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask
     return;
      */
 
         /* This stuff is stolen from the atm128 platfom (David Gay) */
     /* Leave it here for now ...*/
    //    uint32_t expires, guardedExpires, stor;
    //uint16_t compare, more_now;
    //const uint8_t mindt = 2;

    //now = call Alarm0.getNow();
//    ((uint8_t*)&now)[0] = (uint8_t) T1CNTH;
//    ((uint8_t*)&now)[1] = (uint8_t) T1CNTL;
//
//    if (dt < mindt)
//      dt = mindt;
//
//    expires = t0 + dt;
//
//    guardedExpires = expires - mindt;
//    if (t0 <= now)     {
//      //if it's in the past or the near future, fire now (i.e., test
//      //     guardedExpires <= now in wrap-around arithmetic).
//  if (guardedExpires >= t0 && // if it wraps, it's > now
//      guardedExpires <= now) {
//    //compare = call Alarm0.getNow() + mindt;
//    ((uint8_t*)&more_now)[0] = (uint8_t) T1CNTH;
//    ((uint8_t*)&more_now)[1] = (uint8_t) T1CNTL;
//    compare = more_now + mindt;
//  }
//  else
//    compare = expires;
//      }
//    else
//      {
//  // again, guardedExpires <= now in wrap-around arithmetic
//  if (guardedExpires >= t0 || // didn't wrap so < now
//      guardedExpires <= now) {
//    //compare = call Alarm0.getNow() + mindt ;
//    ((uint8_t*)&more_now)[0] = (uint8_t) T1CNTH;
//    ((uint8_t*)&more_now)[1] = (uint8_t) T1CNTL;
//    compare = more_now + mindt;
//  }
//  else
//    compare = expires;
//      }
//    T1CC0H = (uint8_t) ((uint8_t*)&compare)[0];
//    T1CC0L = (uint8_t) ((uint8_t*)&compare)[1];
//    //T1CTL  &= ~CC2430_T1_CH0IF;          // Clear IF
//    //T1CCTL0 |= _BV(CC2430_T1CCTLx_IM);  // Enable interrupt mask (IM)
//
//    return;
//

/*********************************************************************
 *                              Counter                              *
 *********************************************************************/ 

	async command uint16_t Counter.get()
	{
		uint16_t r;
		((uint8_t*)&r)[1] = T1CNTL;
		((uint8_t*)&r)[0] = T1CNTH;

		return r;
	}
	async command bool Counter.isOverflowPending()
	{
		return( T1CTL & CC2430_T1_OVFIF );
	}
	
	async command void Counter.clearOverflow()
	{
		T1CTL &= ~CC2430_T1_OVFIF;
	}


/********************************************************************
*            Capture  *
******************************************************************/

	async command error_t CaptureChannel2.captureRisingEdge()
	{
		PERCFG &= ~0x40; //Timer1 location 1
		P2_ALT &= ~0x10;  //Timer1 pr > timer4
		P2_ALT |= 0x08;     //timer1 pr > usart0
		P2_DIR |= 0xC0;     //channel 2 has pri
		P0_ALT |= 0x10;    //P0_4 Peripheral function
		T1CCTL2 = 0x40;    //capture mode, enable interrupt
		T1CCTL2 |= 0x01;  //rising capture
		T1CTL  = (T1CTL & ~CC2430_T1CTL_MODE_MASK) | CC2430_TIMER1_MODE_FREE;

		return SUCCESS;
	}
	async command error_t CaptureChannel2.captureFallingEdge()
	{
		PERCFG &= ~0x40; //Timer1 location 1
		P2_ALT &= ~0x10;  //Timer1 pr > timer4
		P2_ALT |= 0x08;     //timer1 pr > usart0
		P2_DIR |= 0xC0;     //channel 2 has pri
		P0_ALT |= 0x10;    //P0_4 Peripheral function
		T1CCTL2 = 0x40;    //capture mode, enable rising capture
		T1CCTL2 |= 0x02;  //falling capture
		T1CTL  = (T1CTL & ~CC2430_T1CTL_MODE_MASK) | CC2430_TIMER1_MODE_FREE;

		return SUCCESS;
	}

	/**
	* Disable further captures.
	*/ 
	async command void CaptureChannel2.disable()
	{
		P2_ALT &= ~0x08;     //usart0 pr > timer1 
		P2_DIR &= ~0xC0;     //usart0 has pri
		P0_ALT |= 0x10;      //P0_4 Peripheral function
		T1CCTL2 &= ~0x03;    //no capture
	}



/*********************************************************************
 *                              Interrupts                           *
 *********************************************************************/ 

  /*
   * The interrupt handler will be executed regardless of which
   * interrupt has been issued. Since the compare registers are likely
   * to fire with masks off - we need to check that this particular
   * interrupt is actually enabled.
   */


  int err_check = 0;

	void err_check_inc()
	{
		err_check++;
/*		if(err_check > 25)
		{
			ADBG(900, "\r\nRFERRIF = 0x%x\r\n",(int)(RFERRIF));
			uart_debug_level = 1;	
		}
*/		
		if (err_check > 50)
		{
//			uart_debug_level = 1;	
			ADBG(900,"Timer err_check_inc reset cpu!\n");
//			WDCTL = 0x0B;  /* reset the CPU in the smallest period */
		}
	}

	void err_check_reset()
	{
//		uart_debug_level = 200;
		//ADBG(900,"Timer err_check_reset!\n");
		err_check= 0;
	}

	event void IntTimer.firedT1()
	{
		bool get_alarm = FALSE;
     
		ADBG(1, "SIG_T1 T1CTL=0x%x, T1CCTL0=0x%x, T1CCTL1=0x%x, T1CCTL2=0x%x , uart_debug_level=%d, tmprfdhead=%d, tmprfdtail=%d, RFIF=%d, RFIM=%d\n", (int)T1CTL, (int)T1CCTL0, (int)T1CCTL1, (int)T1CCTL2,
			(int)uart_debug_level, tmprfdhead, tmprfdtail, (int)RFIF, (int)RFIM
		);

		ADBG_SYS_INFO(1);

		/* temperatory code!!! problem cannot be solved... */
		if (uart_debug_level == -1)
		{/* known issue:  XLQ&&XXL.. no method... */
			WDCTL = 0x0B;  /* reset the CPU in the smallest period */
			return;
		}
     
		atomic
		{
			if ( (T1CCTL2 & _BV(CC2430_T1CCTLx_IM)) && (T1CTL & CC2430_T1_CH2IF) )
			{
				uint16_t value;

				get_alarm = TRUE;
        
				ADBG(1, "SIG_T1 signal Alarm2.fired T1CCTL0=0x%x, T1CTL=0x%x, T1CCTL1=0x%x \n", (int)T1CCTL0, (int)T1CTL, (int)T1CCTL1);
     
				T1CTL   &= ~_BV(CC2430_T1CTL_CH2IF);   // Clear IF

				if (!(T1CCTL2 & _BV(CC2430_T1CCTLx_CPSEL)))
				{
					((uint8_t*)&value)[1] = T1CC2L;
					((uint8_t*)&value)[0] = T1CC2H;
					signal CaptureChannel2.captured(value);
				}
				else
				{
					T1CCTL2 &= ~_BV(CC2430_T1CCTLx_IM);    // Clear IM - startAt sets it
					signal Alarm2.fired();
				}
			}
		
			if ( (T1CCTL1 & _BV(CC2430_T1CCTLx_IM)) && (T1CTL & CC2430_T1_CH1IF) )
			{
				get_alarm = TRUE;
				T1CTL   &= ~_BV(CC2430_T1CTL_CH1IF);   // Clear IF
				T1CCTL1 &= ~_BV(CC2430_T1CCTLx_IM);    // Clear IM - startAt sets it
				ADBG(1, "SIG_T1 signal Alarm1.fired T1CCTL0=0x%x, T1CTL=0x%x, T1CCTL1=0x%x \n", (int)T1CCTL0, (int)T1CTL, (int)T1CCTL1);
				signal Alarm1.fired();
			}
			if ( (T1CCTL0 & _BV(CC2430_T1CCTLx_IM)) && (T1CTL & CC2430_T1_CH0IF) )
			{
				get_alarm = TRUE;
				T1CTL   &= ~_BV(CC2430_T1CTL_CH0IF);    // Clear IF
				T1CCTL0 &= ~_BV(CC2430_T1CCTLx_IM);     // Clear IM - startAt sets it
				ADBG(1, "SIG_T1 signal Alarm0.fired T1CCTL0=0x%x, T1CTL=0x%x, T1CCTL1=0x%x \n", (int)T1CCTL0, (int)T1CTL, (int)T1CCTL1);
				signal Alarm0.fired();
			}
			
			if (T1CTL & CC2430_T1_OVFIF)
			{
				T1CTL   &= ~_BV(CC2430_T1CTL_OVFIF);   // Clear IF
				signal Counter.overflow();
			}
		}

		T1CTL   &= ~_BV(CC2430_T1CTL_CH2IF);   // Clear IF
		T1CTL   &= ~_BV(CC2430_T1CTL_CH1IF);   // Clear IF
		T1CTL   &= ~_BV(CC2430_T1CTL_CH0IF);    // Clear IF
		T1CTL   &= ~_BV(CC2430_T1CTL_OVFIF);   // Clear IF
	
		if (get_alarm)
		{
			err_check_reset();
		}
		else
		{
			err_check_inc();
		}

		//ADBG(1, "STIF=%d, IEN0=%d, TimerRTC.getTime=%ld, getAlarmTime=%ld, updateRate=%ld\n", (int)STIF, (int)IEN0, call TimerRTC.getTime(), call TimerRTC.getAlarmTime(), call TimerRTC.getUpdateRate());
	}

	default async event void Counter.overflow() { }
	default async event void Alarm0.fired() { }
	default async event void Alarm1.fired() { }
	default async event void Alarm2.fired() { }

	default async event void CaptureChannel2.captured(uint16_t time){ }
	
}
