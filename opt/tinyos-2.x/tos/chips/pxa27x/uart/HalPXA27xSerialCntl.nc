/* $Id: HalPXA27xSerialCntl.nc,v 1.4 2006/12/12 18:23:12 vlahan Exp $ */
/*
 * Copyright (c) 2005 Arch Rock Corporation 
 * All rights reserved. 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *	Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *	Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *  
 *   Neither the name of the Arch Rock Corporation nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE ARCHED
 * ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */

/**
 * @author Phil Buonadonna
 */

#include "pxa27x_serial.h"

interface HalPXA27xSerialCntl
{
  /** 
   * Modify runtime port parameters
   *
   * @param baudrate The integer value of baudrate
   * @param databits The Number of data bits
   * @param partiy Values of EVEN,ODD or NONE
   * @param stopbits Values of 1 or 2
   * @param flow_cntl TRUE to enable hardware flow control
   *
   * @return SUCCESS if parameters successfully applied. FAIL otherwise
   */
  async command error_t configPort(uint32_t baudrate, 
				    uint8_t databits, 
				    uart_parity_t parity, 
				    uint8_t stopbits, 
				    bool flow_cntl);
    
  /**
   * Flush the port FIFOs
   *
   * @return SUCCESS if flushed, FAIL otherwise.
   */
  async command error_t flushPort();

}

