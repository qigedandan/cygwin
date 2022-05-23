#include "CC2430_CSP.h"

module HplCC2420RadioP
{
	provides interface HplCC2420Radio;
	provides interface CC2420Fifo;
}
implementation
{
	/*************************************************************************/
	/* HplCC2420Radio */
	/******/
	command void HplCC2420Radio.reset()
	{
		// Power cycle voltage regulator
      		_CC2430_RFPWR |= _BV(CC2430_RFPWR_RREG_RADIO_PD); 
      		_CC2430_RFPWR &= ~_BV(CC2430_RFPWR_RREG_RADIO_PD);

      		// RFPWR contains the register ADI_RADIO_PD as a delayed version
      		// The manual however waits for the IF
      		while ( !(RFIF & _BV(CC2430_RFIF_RREG_ON)) ) {
      		}
	}
	
	command void HplCC2420Radio.radioOn()
	{
	      RFERRIE = 1;  /* Important to turn on the radio error interrupt */
	      // Set delay an power up radio
	      _CC2430_RFPWR = 0x04; // Power up radio and set delay

	      // Wait for radio to power up.
	      // Wait by delay time in RFPWR_RREG_DELAY
	      // One or the other should be good enough..
	      while ((_CC2430_RFPWR & 0x10)) {}
	}
	
	command void HplCC2420Radio.radioOff()
	{
		_CC2430_RFPWR |= _BV(CC2430_RFPWR_RREG_RADIO_PD);
	}
	
	command void HplCC2420Radio.rxOn()
	{
		/* flush rx buffer */
		RFST = _CC2430_ISFLUSHRX;
		RFST = _CC2430_ISFLUSHRX;


		/* enable interrupts  TODO  */
		/*call InterruptFIFOP.enableRisingEdge();*/

		/* Enable receiver */
		RFST = _CC2430_ISRXON;
	}
	
	command void HplCC2420Radio.rxOff()
	{
		RFST = _CC2430_ISFLUSHRX;
		RFST = _CC2430_ISFLUSHRX;
		RFST = _CC2430_ISFLUSHTX;
		RFST = _CC2430_ISFLUSHTX;
		
		RFST = _CC2430_ISRFOFF;

		/* disable interrupts TODO */
		/*call InterruptFIFOP.disable();*/
		
	}

	command void HplCC2420Radio.oscOn()
	{
		SLEEP  &= ~_BV(CC2430_SLEEP_OSC_PD); // Power up external osc
		CLKCON &= ~_BV(CC2430_CLKCON_CLKSPD); // Select clock source  = ext osc
		// Wait for XOSC powered up and stable
		while (!(SLEEP & _BV(CC2430_SLEEP_XOSC_STB)));
	}
	
	command void HplCC2420Radio.oscOff()
	{
		SLEEP  |= _BV(CC2430_SLEEP_OSC_PD); // Power up external osc
	}
	

	/*************************************************************************/
	/* TXFIFO */
	/******/
	uint8_t *m_txfifo_data = NULL;
	uint8_t m_txfifo_length = 0;
	error_t m_txfifo_error = SUCCESS;
	
	/* RXFIFO */
	uint8_t *m_rxfifo_data = NULL;
	uint8_t m_rxfifo_length = 0;
	error_t m_rxfifo_error = SUCCESS;

	task void taskRxfifoReadDone()
	{
		signal CC2420Fifo.readDone(m_rxfifo_data, m_rxfifo_length, m_rxfifo_error);
	}

	void readCC2420Fifo(uint8_t* data, uint8_t length)
	{
		uint8_t i=0;
	
		atomic
		{
			m_rxfifo_data = data;
			m_rxfifo_length = length;
			m_rxfifo_error = SUCCESS;
		}

		for (i=0; i < length; ++i)
		{
			data[i] = RFD;
		}

		post taskRxfifoReadDone();
	}
	
	async command cc2420_status_t CC2420Fifo.beginRead(uint8_t* data, uint8_t length)
	{
		readCC2420Fifo(data, length);
		
		return 0;
	}

	async command error_t CC2420Fifo.continueRead( uint8_t* data, uint8_t length )
	{
		readCC2420Fifo(data, length);
		
		return SUCCESS;
	}

	async default event void CC2420Fifo.readDone( uint8_t* data, uint8_t length, error_t error ) { }


	task void taskTxfifoWriteDone()
	{
		signal CC2420Fifo.writeDone(m_txfifo_data, m_txfifo_length, m_txfifo_error);
	}

	async command cc2420_status_t CC2420Fifo.write( uint8_t* data, uint8_t length )
	{
		uint8_t i=0;


		ADBG(1, "TXFIFO.write \n");
		
		m_txfifo_data = data;
		m_txfifo_length = length;
		m_txfifo_error = SUCCESS;

		
		for (i=0; i < length; ++i)
		{
			RFD = data[i];
		}

		post taskTxfifoWriteDone();
		
		return 0;
	}

	async default event void CC2420Fifo.writeDone( uint8_t* data, uint8_t length, error_t error ){ }

}

