#include "Debugger.h"

module DebuggerRegP
{
	provides interface DebuggerHandler;
}
implementation
{


	task void doProcess()
	{
		DBGER_OUT("\r\n\r\n\r\n>>>>REG information====\r\n");
		/* print registry information */

		DBGER_OUT("[Power] PCON=0x%x, SLEEP=0x%x, CLKCON=0x%x\r\n\r\n", (int)PCON, (int)SLEEP, (int)CLKCON);
		DBGER_OUT("[INT] IEN0=0x%x, IEN1=0x%x, IEN2=0x%x, TCON=0x%x, T2CON=0x%x, ", (int)IEN0, (int)IEN1, (int)IEN2, (int)TCON, (int)T2CON);
		DBGER_OUT("S0CON=0x%x, S1CON=0x%x, IRCON=0x%x, IRCON2=0x%x\r\n\r\n", (int)S0CON, (int)S1CON, (int)IRCON, (int)IRCON2);
		
		DBGER_OUT("[RFINT] RFERRIF=0x%x, RFIF=0x%x, RFIM=0x%x\r\n\r\n", (int)RFERRIF, (int)RFIF, (int)RFIM);
		
		DBGER_OUT("[RF] MDMCTRL0H=0x%x, MDMCTRL0L=0x%x, MDMCTRL1H=0x%x, MDMCTRL1L=0x%x\r\n", (int)_CC2430_MDMCTRL0H, (int)_CC2430_MDMCTRL0L, (int)_CC2430_MDMCTRL1H, (int)_CC2430_MDMCTRL1L);
		DBGER_OUT("       TXCTRLH =0x%x, TXCTRLL=0x%x, RXCTRL0H=0x%x, RXCTRL0L=0x%x, RXCTRL1H=0x%x, RXCTRL1L=0x%x\r\n", (int)_CC2430_TXCTRLH, (int)_CC2430_TXCTRLL, (int)_CC2430_RXCTRL0H, (int)_CC2430_RXCTRL0L, (int)_CC2430_RXCTRL1H, (int)_CC2430_RXCTRL1L);
		DBGER_OUT("       RXFIFOCNT =0x%x, RFSTATUS=0x%x, RFPWR=0x%x\r\n\r\n", (int)_CC2430_RXFIFOCNT, (int)_CC2430_RFSTATUS, (int)_CC2430_RFPWR);

		DBGER_OUT("[Timer1] T1CTL=0x%x, T1CCTL0=0x%x, T1CCTL1=0x%x, T1CCTL2=0x%x\r\n\r\n", (int)T1CTL, (int)T1CCTL0, (int)T1CCTL1, (int)T1CCTL2);
		DBGER_OUT("             T1CNTL=0x%x, T1CNTH=0x%x \n", (int)T1CNTL, (int)T1CNTH);
		DBGER_OUT("             T1CC0L=0x%x, T1CC0H=0x%x, T1CC1L=0x%x, T1CC1H=0x%x, T1CC2L=0x%x, T1CC2H=0x%x \n", (int)T1CC0L, (int)T1CC0H, (int)T1CC1L, (int)T1CC1H, (int)T1CC2L, (int)T1CC2H);
		
		
		
		DBGER_OUT("<<<<REG information====\r\n");
	}

	command bool DebuggerHandler.process(char *cmd)
	{
		if (*cmd == 'r')
		{
			post doProcess();
			return TRUE;
		}

		return FALSE;
	}

	default event char *DebuggerHandler.getDebugBuf()
	{
		return NULL;
	}
	
	default event void DebuggerHandler.debugOutput(char *cmd)
	{
	}
}

