/* $Id: HplCC2420PinsC.nc,v 1.4 2006/12/12 18:23:42 vlahan Exp $ */
/*
 * Copyright (c) 2005 Arched Rock Corporation 
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
 *   Neither the name of the Arched Rock Corporation nor the names of its
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
 * 
 * @author Phil Buonadonna
 */
configuration HplCC2420PinsC 
{

  provides interface GeneralIO as CCA;
  provides interface GeneralIO as CSN;
  provides interface GeneralIO as FIFO;
  provides interface GeneralIO as FIFOP;
  provides interface GeneralIO as RSTN;
  provides interface GeneralIO as SFD;
  provides interface GeneralIO as VREN;

}

implementation 
{
  components GeneralIOC;
  
  CCA = GeneralIOC.GeneralIO[CC2420_CCA_PIN];
  CSN = GeneralIOC.GeneralIO[CC2420_CSN_PIN];
  FIFO = GeneralIOC.GeneralIO[CC2420_FIFO_PIN];
  FIFOP = GeneralIOC.GeneralIO[CC2420_FIFOP_PIN];
  RSTN = GeneralIOC.GeneralIO[CC2420_RSTN_PIN];
  SFD = GeneralIOC.GeneralIO[CC2420_SFD_PIN];
  VREN = GeneralIOC.GeneralIO[CC2420_VREN_PIN];
}
