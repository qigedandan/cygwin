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
 * An HAL abstraction of the ChipCon CC2420 radio. This abstraction
 * deals specifically with radio configurations. All get() and set()
 * commands are single-phase. After setting some values, a call to
 * sync() is required for the changes to propagate to the cc2420
 * hardware chip. This interface allows setting multiple parameters
 * before calling sync().
 *
 * @author Jonathan Hui <jhui@archrock.com>
 * @version $Revision: 1.2 $ $Date: 2007/07/06 18:09:44 $
 */

interface CC2420Config {

  /**
   * Sync configuration changes with the radio hardware. This only
   * applies to set commands below.
   *
   * @return SUCCESS if the request was accepted, FAIL otherwise.
   */
  command error_t sync();
  event void syncDone( error_t error );

  /**
   * Change the channel of the radio, between 11 and 26
   */
  command uint8_t getChannel();
  command void setChannel( uint8_t channel );
 
  async command uint16_t getShortAddr();
  command void setShortAddr( uint16_t address );

  /**
   * Change the PAN address of the radio.
   */
  async command uint16_t getPanAddr();
  command void setPanAddr( uint16_t address );

  
  /**
   * @param on TRUE to turn address recognition on, FALSE to turn it off
   */
  command void setAddressRecognition(bool on);
  
  /**
   * @return TRUE if address recognition is enabled
   */
  async command bool isAddressRecognitionEnabled();
  
  /**
   * Sync must be called for acknowledgement changes to take effect
   * @param enableAutoAck TRUE to enable auto acknowledgements
   * @param hwAutoAck TRUE to default to hardware auto acks, FALSE to
   *     default to software auto acknowledgements
   */
  command void setAutoAck(bool enableAutoAck, bool hwAutoAck);
  
  /**
   * @return TRUE if hardware auto acks are the default, FALSE if software
   *     acks are the default
   */
  async command bool isHwAutoAckDefault();
  
  /**
   * @return TRUE if auto acks are enabled
   */
  async command bool isAutoAckEnabled();
  
}
