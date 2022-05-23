/*
 * "Copyright (c) 2007 Washington University in St. Louis.
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 *
 * IN NO EVENT SHALL WASHINGTON UNIVERSITY IN ST. LOUIS BE LIABLE TO ANY PARTY
 * FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
 * OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF WASHINGTON
 * UNIVERSITY IN ST. LOUIS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * WASHINGTON UNIVERSITY IN ST. LOUIS SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND WASHINGTON UNIVERSITY IN ST. LOUIS HAS NO
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
 * MODIFICATIONS."
 */
 
/**
 *
 * @author Greg Hackmann
 * @version $Revision: 1.1 $
 * @date $Date: 2007/11/06 23:58:58 $
 */

module BmacListenerQueueP
{
	provides interface AsyncReceive as Receive;
	
	uses interface FixedSleepLplListener;
	uses interface AsyncReceive as SubReceive;
	uses interface RadioPowerControl;
	uses interface State as SendState;
	uses interface AMPacket;
	uses interface ChannelMonitor;
}
implementation
{
	enum
	{
		MAX_INVALID_MESSAGES = 3,
	};
	
	bool msgQueued;
	message_t queuedMsg;
	uint16_t invalidMessages = 0;
	
	async command void * Receive.getPayload(message_t * msg, uint8_t * len)
	{
		return call SubReceive.getPayload(msg, len);
	}

	async command uint8_t Receive.payloadLength(message_t * msg)
	{
		return call SubReceive.payloadLength(msg);
	}
	
	command void Receive.updateBuffer(message_t * msg)
	{
		if(msg != &queuedMsg)
			call SubReceive.updateBuffer(msg);
	}
	
	void passUpPacket()
	{
		void * payload;
		uint8_t length;
		bool queued;

		atomic queued = msgQueued;
		if(queued)
		{
			payload = call SubReceive.getPayload(&queuedMsg, NULL);
			length = call SubReceive.payloadLength(&queuedMsg);
			signal Receive.receive(&queuedMsg, payload, length);
			atomic msgQueued = FALSE;
		}
    }

	task void detectReceiveDone()
	{
		call FixedSleepLplListener.startTimeout();
		if(call SendState.isIdle())
			call ChannelMonitor.check();
		else passUpPacket();
	}
  
	async event void ChannelMonitor.free()
	{
		passUpPacket();
	}
	
	async event void ChannelMonitor.busy()
	{
		post detectReceiveDone();
	}
  
	async event void ChannelMonitor.error()
	{
		post detectReceiveDone();
	}
	
	message_t * msg_;
	
	task void updateBuffer()
	{
		message_t * msg;
		atomic msg = msg_;
		call Receive.updateBuffer(msg);
	}

	async event void SubReceive.receive(message_t * msg, void * payload, uint8_t len)
	{
		ADBG(6, "FixedSleepLplListenerP.SubReceive.receive msg=0x%x, payload=0x%x, len=0x%x\n", (int)msg, (int)payload, (int)len);
		atomic msg_ = msg;

		if(!call AMPacket.isForMe(msg))
		{
			if((++invalidMessages) > MAX_INVALID_MESSAGES)
			{
				call FixedSleepLplListener.cancelTimeout();
#ifndef FORCE_RADIO_ON
				call RadioPowerControl.stop();
#endif
				post updateBuffer();
				return;
			}
		}
		// Stop the radio if we overheard someone else's message

		invalidMessages = 0;
		call FixedSleepLplListener.startTimeout();
		atomic
		{
			if(!msgQueued)
			{
				memcpy(&queuedMsg, msg, sizeof(message_t));
				msgQueued = TRUE;
			}
		}

		post updateBuffer();
		post detectReceiveDone();
	}
	
	event void RadioPowerControl.startDone(error_t err) { }
	event void RadioPowerControl.stopDone(error_t err) { }
}
