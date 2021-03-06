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
 * Sends packets with prefixed preambles, according to the B-MAC
 * protocol.
 *
 * @author Greg Hackmann
 */
configuration BmacSenderC
{
	provides interface AsyncSend as Send;
	provides interface StdControl;
	provides interface CcaControl[am_id_t amId];
	
	uses interface RadioPowerControl;
	uses interface AsyncSend as SubSend;
	uses interface Resend;
	uses interface FixedSleepLplListener;
	uses interface PacketAcknowledgements;
	uses interface LowPowerListening;
	uses interface State as SendState;
	uses interface AMPacket;
	uses interface Alarm<TMilli, uint16_t> as PreambleAlarm;
	uses interface CcaControl as SubCcaControl[am_id_t amId];
}
implementation
{
	components BmacSenderP as BP;
	components PreambleSenderC as Sender;
	components LedsC;
	
	Send = BP;
	StdControl = BP;
	CcaControl = BP;

	BP.SubSend -> Sender;
	BP.FixedSleepLplListener = FixedSleepLplListener;
	BP.SendState = SendState;
	BP.PreambleSender -> Sender;
	BP.SenderControl -> Sender;
	BP.PacketAcknowledgements = PacketAcknowledgements;
	BP.LowPowerListening = LowPowerListening;
	BP.Leds -> LedsC;
	BP.AMPacket = AMPacket;
	BP.SubCcaControl -> Sender;
	
	Sender.RadioPowerControl = RadioPowerControl;
	Sender.SubSend = SubSend;
	Sender.Resend = Resend;
	Sender.PreambleAlarm = PreambleAlarm;
	Sender.SubCcaControl = SubCcaControl;
}
