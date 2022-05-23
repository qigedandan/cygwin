/*
 * Copyright (c) 2005-2006 Arch Rock Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Arch Rock Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * ARCHED ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */

/**
 * @author Jonathan Hui <jhui@archrock.com>
 * @author David Moss
 * @author Roman Lim
 * @author Razvan Musaloie-E.
 * @author Jeonggil Ko
 * @version $Revision: 1.4 $ $Date: 2008/06/23 20:25:15 $
 */
 
#include "CC2430_CSP.h"

module CC2420SpiP {

  provides {
    interface ChipSpiResource;
    interface Resource[ uint8_t id ];
    interface CC2420Fifo as Fifo[ uint8_t id ];
    interface CC2420Ram as Ram[ uint16_t id ];
    interface CC2420Register as Reg[ uint8_t id ];
    interface CC2420Strobe as Strobe[ uint8_t id ];
  }
  
  uses {
    interface Resource as SpiResource;
    interface State as WorkingState;
    interface Leds;
  }
}

implementation {

  enum {
    RESOURCE_COUNT = uniqueCount( "CC2420Spi.Resource" ),
    NO_HOLDER = 0xFF,
  };

  /** WorkingStates */
  enum {
    S_IDLE,
    S_BUSY,
  };

  /** Address to read/write on the CC2420, also maintains caller's client id */
  norace uint16_t m_addr;
  
  /** Each bit represents a client ID that is requesting SPI bus access */
  uint8_t m_requests = 0;
  
  /** The current client that owns the SPI bus */
  uint8_t m_holder = NO_HOLDER;
  
  /** TRUE if it is safe to release the SPI bus after all users say ok */
  bool release;
  
  /***************** Prototypes ****************/
  error_t attemptRelease();
  task void grant();
  cc2420_status_t readStatus();
  
  /***************** ChipSpiResource Commands ****************/
  /**
   * Abort the release of the SPI bus.  This must be called only with the
   * releasing() event
   */
  async command void ChipSpiResource.abortRelease() {
    atomic release = FALSE;
  }
  
  /**
   * Release the SPI bus if there are no objections
   */
  async command error_t ChipSpiResource.attemptRelease() {
    return attemptRelease();
  }
  
  /***************** Resource Commands *****************/
  async command error_t Resource.request[ uint8_t id ]() {
        /*
    atomic {
      if ( call WorkingState.requestState(S_BUSY) == SUCCESS ) {
        m_holder = id;
        if (call SpiResource.isOwner()) {
          post grant();
          
        } else {
          call SpiResource.request();
        }
        
      } else {
        m_requests |= 1 << id;
      }
    }*/

    m_holder = id;
    post grant();
    
    return SUCCESS;
  }
  
  async command error_t Resource.immediateRequest[ uint8_t id ]() {
    error_t error;
        /*
    atomic {
      if ( call WorkingState.requestState(S_BUSY) != SUCCESS ) {
        return EBUSY;
      }
      
      
      if(call SpiResource.isOwner()) {
        m_holder = id;
        error = SUCCESS;
      
      } else if ((error = call SpiResource.immediateRequest()) == SUCCESS ) {
        m_holder = id;
        
      } else {
        call WorkingState.toIdle();
      }
    }*/

   
    m_holder = id;
    error = SUCCESS;
    
    return error;
  }

  async command error_t Resource.release[ uint8_t id ]() {
    uint8_t i;

    /*
    atomic {
      if ( m_holder != id ) {
        return FAIL;
      }

      m_holder = NO_HOLDER;
      if ( !m_requests ) {
        call WorkingState.toIdle();
        attemptRelease();
        
      } else {
        for ( i = m_holder + 1; ; i++ ) {
          i %= RESOURCE_COUNT;
          
          if ( m_requests & ( 1 << i ) ) {
            m_holder = i;
            m_requests &= ~( 1 << i );
            post grant();
            return SUCCESS;
          }
        }
      }
    }*/
    
    return SUCCESS;
  }
  
  async command uint8_t Resource.isOwner[ uint8_t id ]() {
    /*atomic return (m_holder == id);*/
    return TRUE;
  }


  /***************** SpiResource Events ****************/
  event void SpiResource.granted() {
    post grant();
  }
  
  /***************** Fifo Commands ****************/
  uint8_t m_fifo_read_addr;
  uint8_t *m_fifo_read_data;
  uint8_t m_fifo_read_len;
  uint8_t m_fifo_read_status;
  
  uint8_t m_fifo_write_addr;
  uint8_t *m_fifo_write_data;
  uint8_t m_fifo_write_len;
  uint8_t m_fifo_write_status;
  
  
  task void signalFifoReadDone()
  {
    signal Fifo.readDone[ m_fifo_read_addr ]( m_fifo_read_data, m_fifo_read_len, m_fifo_read_status );
  }
  
  task void signalFifoWriteDone()
  {
    signal Fifo.writeDone[ m_fifo_write_addr ]( m_fifo_write_data, m_fifo_write_len, m_fifo_write_status );
  }
  
  async command cc2420_status_t Fifo.beginRead[ uint8_t addr ]( uint8_t* data, 
                                                                uint8_t len ) {
    
    cc2420_status_t status = 0;
    
    
    ADBG(4, "Fifo.beginRead addr=0x%x, data=0x%x, len=%d\r\n", (int)addr, data, (int)len);
/*
    atomic {
      if (call WorkingState.isIdle()) {
        return status;
      }
    }*/
    
    status = m_fifo_read_status = readStatus();
    
    call Fifo.continueRead[ addr ]( data, len );
    
    /* return RF status??? */
    return status;
  }

  async command error_t Fifo.continueRead[ uint8_t addr ]( uint8_t* data,
                                                           uint8_t len ) {
    uint8_t i;
        
    ADBG(4, "Fifo.continueRead addr=0x%x, data=0x%x, len=0x%x\r\n", (int)addr, data, (int)len);
    for (i=0; i < len; ++i)
    {
      data[i] = RFD;
    }
    
    /* Signal readDone event */
    /*signal Fifo.readDone[ addr ]( data, len, 0 );*/
    m_fifo_read_addr = addr;
    m_fifo_read_data = data;
    m_fifo_read_len = len;
    m_fifo_read_status = m_fifo_read_status;
    post signalFifoReadDone();
    
  }

  async command cc2420_status_t Fifo.write[ uint8_t addr ]( uint8_t* data, 
                                                            uint8_t len ) {

    uint8_t status = 0;
    uint8_t i = 0;
    
    ADBG(4, "Fifo.write addr=0x%x, data=0x%x, len=0x%x\r\n", (int)addr, (int)data, (int)len);
 /*
    atomic {
      if (call WorkingState.isIdle()) {
        return status;
      }
    }*/
    
    status = readStatus();
    
    /* then data */
    for (i=0; i < len; ++i)
    {
      RFD = data[i];
    }
    
    readStatus();
    
    /* Signal writeDone event */
    /*signal Fifo.writeDone[ addr ]( data, len, status );*/
    
    m_fifo_write_addr = addr;
    m_fifo_write_data = data;
    m_fifo_write_len = len;
    m_fifo_write_status = status;
    post signalFifoWriteDone();    

    return status;
  }

  /***************** RAM Commands ****************/
  async command cc2420_status_t Ram.read[ uint16_t addr ]( uint8_t offset,
                                                           uint8_t* data, 
                                                           uint8_t len ) {
    cc2420_status_t status = 0;
    
    dbg("CC2420SPiP", "Ram.read addr=0x%x, data=0x%x, len=%d\r\n", (int)addr, data, (int)len);
/*
    atomic {
      if(call WorkingState.isIdle()) {
        return status;
      }
    }
    */
    status = readStatus();
    
    /*
    IEEEADR = Spi.Ram[ CC2420_RAM_IEEEADR ];
    PANID = Spi.Ram[ CC2420_RAM_PANID ];
    SHORTADR = Spi.Ram[ CC2420_RAM_SHORTADR ];
    TXFIFO_RAM = Spi.Ram[ CC2420_RAM_TXFIFO ];
   */
    
    switch (addr)
    {
      case CC2420_RAM_IEEEADR:
        if (len >= 1) data[0] = _CC2430_IEEE_ADDR0;
        if (len >= 2) data[1] = _CC2430_IEEE_ADDR1;
        if (len >= 3) data[2] = _CC2430_IEEE_ADDR2;
        if (len >= 4) data[3] = _CC2430_IEEE_ADDR3;
        if (len >= 5) data[4] = _CC2430_IEEE_ADDR4;
        if (len >= 6) data[5] = _CC2430_IEEE_ADDR5;
        if (len >= 7) data[6] = _CC2430_IEEE_ADDR6;
        if (len >= 8) data[7] = _CC2430_IEEE_ADDR7;
        break;
      case CC2420_RAM_PANID:
        if (len >= 1) data[0] = _CC2430_PANIDL;
        if (len >= 2) data[1] = _CC2430_PANIDH;
        if (len >= 3) data[2] = _CC2430_SHORTADDRL;
        if (len >= 4) data[3] = _CC2430_SHORTADDRH;
        break;
      case CC2420_RAM_SHORTADR:
        if (len >= 1) data[0] = _CC2430_SHORTADDRL;
        if (len >= 2) data[1] = _CC2430_SHORTADDRH;
        break;
      case CC2420_RAM_TXFIFO:
        
        break;
    }

    /* return RF status??? */
    return status;

  }


  async command cc2420_status_t Ram.write[ uint16_t addr ]( uint8_t offset,
                                                            uint8_t* data, 
                                                            uint8_t len ) {

    cc2420_status_t status = 0;
    uint8_t tmpLen = len;
    uint8_t * tmpData = data;
    
    dbg("CC2420SPiP", "Ram.write addr=0x%x, data=0x%x, len=%d\r\n", (int)addr, data, (int)len);
/*
    atomic {
      if(call WorkingState.isIdle()) {
        return status;
      }
    }
    */
    /*
    IEEEADR = Spi.Ram[ CC2420_RAM_IEEEADR ];
    PANID = Spi.Ram[ CC2420_RAM_PANID ];
    SHORTADR = Spi.Ram[ CC2420_RAM_SHORTADR ];
    TXFIFO_RAM = Spi.Ram[ CC2420_RAM_TXFIFO ];
   */
   
    status = readStatus();
    
    switch (addr)
    {
      case CC2420_RAM_IEEEADR:
        if (len >= 1) _CC2430_IEEE_ADDR0 = data[0];
        if (len >= 2) _CC2430_IEEE_ADDR1 = data[1];
        if (len >= 3) _CC2430_IEEE_ADDR2 = data[2];
        if (len >= 4) _CC2430_IEEE_ADDR3 = data[3];
        if (len >= 5) _CC2430_IEEE_ADDR4 = data[4];
        if (len >= 6) _CC2430_IEEE_ADDR5 = data[5];
        if (len >= 7) _CC2430_IEEE_ADDR6 = data[6];
        if (len >= 8) _CC2430_IEEE_ADDR7 = data[7];
        break;
      case CC2420_RAM_PANID:
        if (len >= 1) _CC2430_PANIDL = data[0];
        if (len >= 2) _CC2430_PANIDH = data[1];
        if (len >= 3) _CC2430_SHORTADDRL = data[2];
        if (len >= 4) _CC2430_SHORTADDRH = data[3];
        break;
      case CC2420_RAM_SHORTADR:
        if (len >= 1) _CC2430_SHORTADDRL = data[0];
        if (len >= 2) _CC2430_SHORTADDRH = data[1];
        break;
      case CC2420_RAM_TXFIFO:
        
        break;
    }

    /* return RF status??? */
    return status;
  }

  /***************** Register Commands ****************/
  async command cc2420_status_t Reg.read[ uint8_t addr ]( uint16_t* data ) {

    cc2420_status_t status = 0;
    
    
    /*
    atomic {
      if(call WorkingState.isIdle()) {
        return status;
      }
    }*/
    
    status = readStatus();
  
    /*
  MAIN = Spi.Reg[ CC2420_MAIN ];
  MDMCTRL0 = Spi.Reg[ CC2420_MDMCTRL0 ];
  MDMCTRL1 = Spi.Reg[ CC2420_MDMCTRL1 ];
  RSSI = Spi.Reg[ CC2420_RSSI ];
  SYNCWORD = Spi.Reg[ CC2420_SYNCWORD ];
  TXCTRL = Spi.Reg[ CC2420_TXCTRL ];
  RXCTRL0 = Spi.Reg[ CC2420_RXCTRL0 ];
  RXCTRL1 = Spi.Reg[ CC2420_RXCTRL1 ];
  FSCTRL = Spi.Reg[ CC2420_FSCTRL ];
  SECCTRL0 = Spi.Reg[ CC2420_SECCTRL0 ];
  SECCTRL1 = Spi.Reg[ CC2420_SECCTRL1 ];
  BATTMON = Spi.Reg[ CC2420_BATTMON ];
  IOCFG0 = Spi.Reg[ CC2420_IOCFG0 ];
  IOCFG1 = Spi.Reg[ CC2420_IOCFG1 ];
  MANFIDL = Spi.Reg[ CC2420_MANFIDL ];
  MANFIDH = Spi.Reg[ CC2420_MANFIDH ];
  FSMTC = Spi.Reg[ CC2420_FSMTC ];
  MANAND = Spi.Reg[ CC2420_MANAND ];
  MANOR = Spi.Reg[ CC2420_MANOR ];
  AGCCTRL = Spi.Reg[ CC2420_AGCCTRL ];
    */  
    switch (addr)
    {
      case CC2420_MAIN:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_MAIN\r\n");
        break;
      case CC2420_MDMCTRL0:
        *data = _CC2430_MDMCTRL0;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_MDMCTRL0, data=0x%x\r\n", *data);
        break;
      case CC2420_MDMCTRL1:
        *data = _CC2430_MDMCTRL1;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_MDMCTRL1, data=0x%x\r\n", *data);
        break;
      case CC2420_RSSI:
        *data = _CC2430_RSSI;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_RSSI, data=0x%x\r\n", *data);
        break;
      case CC2420_SYNCWORD:
        *data = _CC2430_SYNCWORD;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_SYNCWORD, data=0x%x\r\n", *data);
        break;
      case CC2420_TXCTRL:
        *data = _CC2430_TXCTRL;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_TXCTRL, data=0x%x\r\n", *data);
        break;
      case CC2420_RXCTRL0:
        *data = _CC2430_RXCTRL0;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_RXCTRL0, data=0x%x\r\n", *data);
        break;
      case CC2420_RXCTRL1:
        *data = _CC2430_RXCTRL1;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_RXCTRL1, data=0x%x\r\n", *data);
        break;
      case CC2420_FSCTRL:
        *data = _CC2430_FSCTRL;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_FSCTRL, data=0x%x\r\n", *data);
        break;
      case CC2420_SECCTRL0:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_SECCTRL0\r\n");
        break;
      case CC2420_SECCTRL1:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_SECCTRL1\r\n");
        break;
      case CC2420_BATTMON:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_BATTMON\r\n");
        break;
      case CC2420_IOCFG0:
        *data = _CC2430_IOCFG0;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_IOCFG0, data=0x%x\r\n", *data);
        break;
      case CC2420_IOCFG1:
        *data = _CC2430_IOCFG1;
        dbg("CC2420SPiP", "Reg.read addr=CC2420_IOCFG1, data=0x%x\r\n", *data);
        break;
      case CC2420_MANFIDL:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_MANFIDL\r\n");
        break;
      case CC2420_MANFIDH:
        dbg("CC2420SPiP", "Reg.read addr=CC2420_MANFIDH\r\n");
        break;
      case CC2420_FSMTC:
        *data = _CC2430_FSMTC;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_FSMTC, data=0x%x\r\n", *data);
        break;
      case CC2420_MANAND:
        *data = _CC2430_MANAND;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_MANAND, data=0x%x\r\n", *data);
        break;
      case CC2420_MANOR:
        *data = _CC2430_MANOR;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_MANOR, data=0x%x\r\n", *data);
        break;
      case CC2420_AGCCTRL:
        *data = _CC2430_AGCCTRL;
        dbg("CC2420SPiP", "Reg.read addr=_CC2430_AGCCTRL, data=0x%x\r\n", *data);
        break;
    }
    
    /* return RF status??? */
    return status;

  }

  async command cc2420_status_t Reg.write[ uint8_t addr ]( uint16_t data ) {
    cc2420_status_t status = 0;
  /*
    atomic {
      if(call WorkingState.isIdle()) {
        return status;
      }
    }*/
    
    status = readStatus();
    
    switch (addr)
    {
      case CC2420_MAIN:
        dbg("CC2420SPiP", "Reg.write addr=CC2420_MAIN, data=0x%x\r\n", data);
        break;
      case CC2420_MDMCTRL0:
        _CC2430_MDMCTRL0 = data;
        ADBG(4, "Reg.write addr=_CC2430_MDMCTRL0, data=0x%x\r\n", data);
        break;
      case CC2420_MDMCTRL1:
        _CC2430_MDMCTRL1 = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_MDMCTRL1, data=0x%x\r\n", data);
        break;
      case CC2420_RSSI:
        _CC2430_RSSI = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_RSSI, data=0x%x\r\n", data);
        break;
      case CC2420_SYNCWORD:
        _CC2430_SYNCWORD = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_SYNCWORD, data=0x%x\r\n", data);
        break;
      case CC2420_TXCTRL:
        _CC2430_TXCTRL = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_TXCTRL, data=0x%x\r\n", data);
        break;
      case CC2420_RXCTRL0:
        _CC2430_RXCTRL0 = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_RXCTRL0, data=0x%x\r\n", data);
        break;
      case CC2420_RXCTRL1:
        _CC2430_RXCTRL1 = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_RXCTRL1, data=0x%x\r\n", data);
        break;
      case CC2420_FSCTRL:
        _CC2430_FSCTRL = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_FSCTRL, data=0x%x\r\n", data);
        break;
      case CC2420_SECCTRL0:
        
        dbg("CC2420SPiP", "Reg.write addr=CC2420_SECCTRL0, data=0x%x\r\n", data);
        break;
      case CC2420_SECCTRL1:
        
        dbg("CC2420SPiP", "Reg.write addr=CC2420_SECCTRL1, data=0x%x\r\n", data);
        break;
      case CC2420_BATTMON:
        
        dbg("CC2420SPiP", "Reg.write addr=CC2420_BATTMON, data=0x%x\r\n", data);
        break;
      case CC2420_IOCFG0:
        _CC2430_IOCFG0 = data;
        ADBG(1, "#warning Reg.write addr=_CC2430_IOCFG0, data=0x%x\r\n", data);
        break;
      case CC2420_IOCFG1:
       _CC2430_IOCFG1 = data;
        ADBG(1, "#warning Reg.write addr=_CC2430_IOCFG1, data=0x%x\r\n", data);
        break;
      case CC2420_MANFIDL:
        
        dbg("CC2420SPiP", "Reg.write addr=CC2420_MANFIDL, data=0x%x\r\n", data);
        break;
      case CC2420_MANFIDH:
        
        dbg("CC2420SPiP", "Reg.write addr=CC2420_MANFIDH, data=0x%x\r\n", data);
        break;
      case CC2420_FSMTC:
        _CC2430_FSMTC = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_FSMTC, data=0x%x\r\n", data);
        break;
      case CC2420_MANAND:
        _CC2430_MANAND = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_MANAND, data=0x%x\r\n", data);
        break;
      case CC2420_MANOR:
        _CC2430_MANOR = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_MANOR, data=0x%x\r\n", data);
        break;
      case CC2420_AGCCTRL:
        _CC2430_AGCCTRL = data;
        dbg("CC2420SPiP", "Reg.write addr=_CC2430_AGCCTRL, data=0x%x\r\n", data);
        break;
    }
    
    /* return RF status??? */
    return status;
  }

  
  /***************** Strobe Commands ****************/
  async command cc2420_status_t Strobe.strobe[ uint8_t addr ]() {
  
    cc2420_status_t status = 0;
    /*
    atomic {
      if (call WorkingState.isIdle()) {
        return 0;
      }
    }*/
    
    /*  */
    /*
      SNOP = Spi.Strobe[ CC2420_SNOP ];
  SXOSCON = Spi.Strobe[ CC2420_SXOSCON ];
  STXCAL = Spi.Strobe[ CC2420_STXCAL ];
  SRXON = Spi.Strobe[ CC2420_SRXON ];
  STXON = Spi.Strobe[ CC2420_STXON ];
  STXONCCA = Spi.Strobe[ CC2420_STXONCCA ];
  SRFOFF = Spi.Strobe[ CC2420_SRFOFF ];
  SXOSCOFF = Spi.Strobe[ CC2420_SXOSCOFF ];
  SFLUSHRX = Spi.Strobe[ CC2420_SFLUSHRX ];
  SFLUSHTX = Spi.Strobe[ CC2420_SFLUSHTX ];
  SACK = Spi.Strobe[ CC2420_SACK ];
  SACKPEND = Spi.Strobe[ CC2420_SACKPEND ];
  SRXDEC = Spi.Strobe[ CC2420_SRXDEC ];
  STXENC = Spi.Strobe[ CC2420_STXENC ];
  SAES = Spi.Strobe[ CC2420_SAES ];
  #define _CC2430_SNOP 0xC0
  #define _CC2430_ISSTOP      0xFF
#define _CC2430_ISSTART     0xFE
#define _CC2430_ISTXCALN    0xE1
#define _CC2430_ISRXON      0xE2
#define _CC2430_ISTXON      0xE3
//#define _CC2430_ISTXONCCA   0xE4
#define _CC2430_ISTXONCCA   0xE3
#define _CC2430_ISRFOFF     0xE5
#define _CC2430_ISFLUSHRX   0xE6
#define _CC2430_ISFLUSHTX   0xE7
#define _CC2430_ISACK       0xE8
#define _CC2430_ISACKPEND   0xE9
  */
  
    status = readStatus();
  
    switch (addr)
    {
      case CC2420_SNOP:
        RFST = _CC2430_SNOP;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SNOP\r\n");
        break;
      case CC2420_SXOSCON:
        /*RFST = addr;*/
        
        /* There is no SXOSCON on CC2430?? So RX TX on?? */
        /* RFST = _CC2430_ISRXON;  */
        /* RFST = _CC2430_ISTXON; */
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SXOSCON\r\n");
        break;
      case CC2420_STXCAL:
        RFST = _CC2430_ISTXCALN;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_STXCAL\r\n");
        break;
      case CC2420_SRXON:
        RFST = _CC2430_ISRXON;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SRXON\r\n");
        break;
      case CC2420_STXON:
        RFST = _CC2430_ISTXON;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_STXON\r\n");
        break;
      case CC2420_STXONCCA:
        RFST = _CC2430_ISTXONCCA;
        /*dbg("CC2420SPiP", "Strobe.strobe CC2420_STXONCCA\r\n");*/
        break;
      case CC2420_SRFOFF:
        RFST = _CC2430_ISRFOFF;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SRFOFF\r\n");
        break;
      case CC2420_SXOSCOFF:
        /*RFST = addr;*/
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SXOSCOFF\r\n");
        break;
      case CC2420_SFLUSHRX:
        RFST = _CC2430_ISFLUSHRX;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SFLUSHRX\r\n");
        break;
      case CC2420_SFLUSHTX:
        RFST = _CC2430_ISFLUSHRX;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SFLUSHTX\r\n");
        break;
      case CC2420_SACK:
        RFST = _CC2430_ISACK;
        ADBG(4, "CC2420SPiP Strobe.strobe CC2420_SACK\r\n");
        break;
      case CC2420_SACKPEND:
        RFST = _CC2430_ISACKPEND;
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SACKPEND\r\n");
        break;
      case CC2420_SRXDEC:
        /*RFST = addr;*/
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SRXDEC\r\n");
        break;
      case CC2420_STXENC:
        /*RFST = addr;*/
        dbg("CC2420SPiP", "Strobe.strobe CC2420_STXENC\r\n");
        break;
      case CC2420_SAES:
        /*RFST = addr;*/
        dbg("CC2420SPiP", "Strobe.strobe CC2420_SAES\r\n");
        break;
    }
    
    /* return CC2420 status register value */
    return status;
  }

  
  /***************** Functions ****************/
  error_t attemptRelease() {/*
    if(m_requests > 0 
        || m_holder != NO_HOLDER 
        || !call WorkingState.isIdle()) {
      return FAIL;
    }
    
    atomic release = TRUE;
    signal ChipSpiResource.releasing();
    atomic {
      if (release) {
        call SpiResource.release();
        return SUCCESS;
      }
    }*/
    
    signal ChipSpiResource.releasing();
    call SpiResource.release();
    
    return EBUSY;
  }
  
  task void grant() {
    uint8_t holder;
    atomic { 
      holder = m_holder;
    }
    signal Resource.granted[ holder ]();
  }
  
  /* read RFSTATUS from CC2430 and convert to CC2420 status?? */
  cc2420_status_t readStatus()
  {
    cc2420_status_t cc2420_status = 0;
    uint8_t cc2430_status;
    
    _CC2430_RFPWR = 0x04;
    
    cc2430_status = _CC2430_RFSTATUS;
    
    
    
    dbg("CC2420SpiP", "read cc2430_status=0x%x\r\n", (int)cc2430_status);
    dbg("CC2420SpiP", "read _CC2430_RFPWR=0x%x\r\n", (int)_CC2430_RFPWR);
    
    
    /*
      CC2420_STATUS_RSSI_VALID = 1 << 1,
      CC2420_STATUS_LOCK = 1 << 2,
      CC2420_STATUS_TX_ACTIVE = 1 << 3,
      CC2420_STATUS_ENC_BUSY = 1 << 4,
      CC2420_STATUS_TX_UNDERFLOW = 1 << 5,
      CC2420_STATUS_XOSC16M_STABLE = 1 << 6,
    */
    /*
      CC2430_RFSTATUS_TX_ACTIVE   = 0x4,
      CC2430_RFSTATUS_FIFO        = 0x3,
      CC2430_RFSTATUS_FIFOP       = 0x2,
      CC2430_RFSTATUS_SFD         = 0x1,
      CC2430_RFSTATUS_CCA         = 0x0
    */
    if (cc2430_status & (1<<CC2430_RFSTATUS_TX_ACTIVE))
    {
      cc2420_status |= CC2420_STATUS_TX_ACTIVE;
    }
    
    /* ?? */
    cc2420_status |= CC2420_STATUS_RSSI_VALID;
    
    /*dbg("CC2420SpiP", "get cc2420_status=0x%x\r\n", (int)cc2420_status);*/
    
    return cc2420_status;
  }

  /***************** Defaults ****************/
  default event void Resource.granted[ uint8_t id ]() {
  }

  default async event void Fifo.readDone[ uint8_t addr ]( uint8_t* rx_buf, uint8_t rx_len, error_t error ) {
  }
  
  default async event void Fifo.writeDone[ uint8_t addr ]( uint8_t* tx_buf, uint8_t tx_len, error_t error ) {
  }

  default async event void ChipSpiResource.releasing() {
  }
  
}
