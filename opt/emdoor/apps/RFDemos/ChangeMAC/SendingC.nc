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
 * @date $Date: 2007/11/06 23:58:56 $
 */
#define DBG_LEV 15
generic module SendingC(uint16_t interval, bool sends)
{
	uses
	{
		interface Boot;
		interface AMSend as AMSender;
		interface Receive as AMReceiver;
		interface Packet;
		interface AMPacket;
		interface Timer<TMilli> as SendTimer;
		interface SplitControl;
	}
}

implementation
{
	uint16_t sn = 0;
	message_t packet;

	event void Boot.booted()
	{
		ADBG(DBG_LEV, "Boot.booted\n");
		call SplitControl.start();
	}

	event void AMSender.sendDone(message_t * bufPtr, error_t error)
	{
		ADBG(DBG_LEV, "----> AMSender.sendDone error=%d\n", (int)error);
	}

	event void SendTimer.fired()
	{
		ADBG(DBG_LEV, "----> SendTimer.fired sends=%d\n", (int)sends);
		if(sends && call AMPacket.address()!= 1)
		{
			sn++;
			ADBG(DBG_LEV, "----> AMSender.send sn=%d\n", sn);
			/*call AMSender.send(AM_BROADCAST_ADDR, &packet, 2 * sizeof(uint8_t));*/
			memcpy(packet.data, &sn, sizeof(sn));
			call AMSender.send(0x0001, &packet, sizeof(sn));
		}
	}
	
	event message_t * AMReceiver.receive(message_t * message, void * payload, uint8_t length)
	{
		ADBG(15, "<---- AMReceiver.receive message=0x%x  from node %d, length=%d, sn=%d\n", (int)message, (int) call AMPacket.source(message),(int)length, *((uint16_t *)payload));
		return message;
	}
	
	event void SplitControl.startDone(error_t err)
	{
		uint8_t * nodeId;
		nodeId = (uint8_t *)call Packet.getPayload(&packet, NULL);
		*nodeId = TOS_NODE_ID;

		call SendTimer.startPeriodic(8000);
	}

	event void SplitControl.stopDone(error_t err)
	{
	}
}
